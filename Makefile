# ---------------------------------------------------------------------------
# cp-book — 종만북 문제 풀이 레포의 루트 자동화.
#
#   make new P=08-dp/WILDCARD     새 문제 폴더를 _template/ 로부터 생성
#   make test                     전체 문제 테스트
#   make test CH=08-dp            챕터 일괄 테스트
#   make test P=08-dp/WILDCARD    문제 하나만
#   make run  P=08-dp/WILDCARD    문제 하나 실행 (stdin)
#   make list                     문제 목록
#   make clean                    전체 빌드 산출물 삭제
#
# 문제를 푸는 동안에는 그냥 그 폴더로 cd 해서 `make test` 만 치면 된다.
# 빌드/테스트 규칙 자체는 rules.mk 한 곳에 있다.
# ---------------------------------------------------------------------------

ROOT     := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TEMPLATE := $(ROOT)/_template
PROBLEMS := $(ROOT)/problems

# 대상 범위: P 이 가장 좁고, 그다음 CH, 없으면 전체.
ifdef P
SCOPE_DIRS := $(PROBLEMS)/$(P)
else ifdef CH
SCOPE_DIRS := $(sort $(patsubst %/,%,$(dir $(wildcard $(PROBLEMS)/$(CH)/*/Makefile))))
else
SCOPE_DIRS := $(sort $(patsubst %/,%,$(dir $(wildcard $(PROBLEMS)/*/*/Makefile))))
endif

.PHONY: help new test run list clean
.DEFAULT_GOAL := help

help:
	@echo 'cp-book'
	@echo ''
	@echo '  make new P=<챕터>/<문제>    새 문제 폴더 생성   (예: make new P=08-dp/WILDCARD)'
	@echo '  make test                   전체 테스트'
	@echo '  make test CH=<챕터>         챕터 일괄'
	@echo '  make test P=<챕터>/<문제>   문제 하나'
	@echo '  make run  P=<챕터>/<문제>   실행 (stdin)'
	@echo '  make list                   문제 목록'
	@echo '  make clean                  빌드 산출물 삭제'
	@echo ''
	@echo '문제 폴더 안에서는: make / make test / make test-py / make test-cpp / make dbg'

# --- 새 문제 ---------------------------------------------------------------

new:
	@test -n "$(P)" || { \
		echo '사용법: make new P=<챕터>/<문제>'; \
		echo '  예:   make new P=08-dp/WILDCARD'; \
		exit 1; }
	@test ! -e "$(PROBLEMS)/$(P)" || { echo "이미 있음: problems/$(P)"; exit 1; }
	@test -d "$(TEMPLATE)" || { echo "템플릿이 없음: _template/"; exit 1; }
	@mkdir -p "$(PROBLEMS)/$(P)"
	@cp -R "$(TEMPLATE)/." "$(PROBLEMS)/$(P)/"
	@prob=$$(basename "$(P)"); chap=$$(dirname "$(P)"); \
	 find "$(PROBLEMS)/$(P)" -type f \
	   \( -name '*.py' -o -name '*.cpp' -o -name '*.md' \) \
	   -exec sed -i "s|{{PROBLEM}}|$$prob|g; s|{{CHAPTER}}|$$chap|g" {} +
	@echo "생성됨: problems/$(P)"
	@echo ""
	@echo "  1) tests/01.in, tests/01.out 에 예제 입출력을 붙여넣고"
	@echo "  2) cd problems/$(P) && make test"

# --- 테스트 / 실행 ---------------------------------------------------------

test:
	@dirs='$(SCOPE_DIRS)'; \
	 if [ -z "$$dirs" ]; then echo '대상 문제가 없음'; exit 0; fi; \
	 rc=0; \
	 for d in $$dirs; do \
	   if [ ! -f "$$d/Makefile" ]; then echo "건너뜀 (Makefile 없음): $${d#$(PROBLEMS)/}"; continue; fi; \
	   echo "== $${d#$(PROBLEMS)/}"; \
	   $(MAKE) --no-print-directory -C "$$d" test || rc=1; \
	 done; \
	 exit $$rc

run:
	@test -n "$(P)" || { echo '사용법: make run P=<챕터>/<문제>'; exit 1; }
	@$(MAKE) --no-print-directory -C "$(PROBLEMS)/$(P)" run

# --- 기타 ------------------------------------------------------------------

list:
	@dirs='$(sort $(patsubst %/,%,$(dir $(wildcard $(PROBLEMS)/*/*/Makefile))))'; \
	 if [ -z "$$dirs" ]; then echo '아직 문제 없음 — make new P=<챕터>/<문제>'; exit 0; fi; \
	 for d in $$dirs; do \
	   langs=''; \
	   [ -s "$$d/sol.py" ]  && langs="$$langs py"; \
	   [ -s "$$d/sol.cpp" ] && langs="$$langs cpp"; \
	   printf '  %-44s%s\n' "$${d#$(PROBLEMS)/}" "$$langs"; \
	 done

clean:
	@for d in $(sort $(patsubst %/,%,$(dir $(wildcard $(PROBLEMS)/*/*/Makefile)))); do \
	   $(MAKE) --no-print-directory -C "$$d" clean; \
	 done
	@echo '정리 완료'
