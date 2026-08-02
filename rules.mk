# ---------------------------------------------------------------------------
# cp-book — 문제 하나를 빌드/실행/검증하는 공통 규칙.
#
# 문제 폴더의 Makefile 은 이 파일을 include 하기만 한다.
# 빌드 규칙을 바꾸고 싶으면 여기 한 곳만 고치면 전체 문제에 반영된다.
#
#   make            빌드 (있는 언어만)
#   make test       tests/*.in 을 전부 돌려 tests/*.out 과 비교
#   make test-py    파이썬만
#   make test-cpp   C++만
#   make run        stdin 으로 직접 실행  (예: make run < tests/01.in)
#   make dbg        새니타이저 + 디버그 심볼로 C++ 빌드
#   make clean      빌드 산출물 삭제
# ---------------------------------------------------------------------------

CXX      ?= g++
CXXSTD   ?= c++17
CXXFLAGS ?= -std=$(CXXSTD) -O2 -Wall -Wextra
DBGFLAGS ?= -std=$(CXXSTD) -g -O0 -Wall -Wextra -fsanitize=address,undefined
PYTHON   ?= python3

BIN    := sol.bin
DBGBIN := sol.dbg.bin
TESTS  := $(sort $(wildcard tests/*.in))

# 풀이 파일은 "존재하고 비어 있지 않을 때"만 대상으로 삼는다.
# 한 언어로만 풀 거면 반대쪽 파일을 지우면 조용히 스킵된다.
HAS_PY  := $(shell [ -s sol.py ]  && echo 1)
HAS_CPP := $(shell [ -s sol.cpp ] && echo 1)

ifdef HAS_CPP
TEST_DEPS := $(BIN)
else
TEST_DEPS :=
endif

# ---------------------------------------------------------------------------
# 테스트 러너.
#
# 셸 함수로 정의해두고 한 셸 안에서 py/cpp 를 연달아 부른다 — 그래야 한쪽이
# 실패해도 다른 쪽이 계속 돌고, 종료 코드도 한 번만 합산된다.
#   run_suite <라벨> <실행할 명령>
# 비교는 공백/빈 줄을 무시하는 diff. 실패하면 expected vs actual 을 보여준다.
# ---------------------------------------------------------------------------
define SUITE_FN
run_suite() { \
	label="$$1"; cmd="$$2"; \
	pass=0; fail=0; total=0; start=$$(date +%s%N); \
	for input in $(TESTS); do \
		total=$$((total+1)); \
		expected="$${input%.in}.out"; \
		actual=$$(sh -c "$$cmd" < "$$input" 2>&1); status=$$?; \
		if [ $$status -ne 0 ]; then \
			fail=$$((fail+1)); \
			printf '  [%-3s] FAIL %s — exit %d\n' "$$label" "$$input" "$$status"; \
			printf '%s\n' "$$actual" | sed 's/^/        /'; \
		elif [ ! -f "$$expected" ]; then \
			fail=$$((fail+1)); \
			printf '  [%-3s] FAIL %s — %s 가 없음\n' "$$label" "$$input" "$$expected"; \
		elif printf '%s\n' "$$actual" | diff -q -w -B "$$expected" - >/dev/null 2>&1; then \
			pass=$$((pass+1)); \
		else \
			fail=$$((fail+1)); \
			printf '  [%-3s] FAIL %s\n' "$$label" "$$input"; \
			printf '%s\n' "$$actual" \
				| diff -u -w -B --label expected --label actual "$$expected" - \
				| sed 's/^/        /'; \
		fi; \
	done; \
	ms=$$(( ($$(date +%s%N) - start) / 1000000 )); \
	if [ $$fail -eq 0 ]; then mark='OK'; else mark='FAIL'; fi; \
	printf '  [%-3s] %d/%d %s  %d.%03ds\n' "$$label" "$$pass" "$$total" "$$mark" \
		$$((ms/1000)) $$((ms%1000)); \
	[ $$fail -eq 0 ]; \
}
endef

ifdef HAS_PY
RUN_PY := run_suite py '$(PYTHON) sol.py'
else
RUN_PY := echo '  [py ] skip (sol.py 없음)'
endif

ifdef HAS_CPP
RUN_CPP := run_suite cpp './$(BIN)'
else
RUN_CPP := echo '  [cpp] skip (sol.cpp 없음)'
endif

.PHONY: all build test test-py test-cpp run run-py run-cpp dbg clean

all: build

# --- 빌드 ------------------------------------------------------------------

$(BIN): sol.cpp
	@$(CXX) $(CXXFLAGS) -o $@ sol.cpp

$(DBGBIN): sol.cpp
	@$(CXX) $(DBGFLAGS) -o $@ sol.cpp

ifdef HAS_CPP
build: $(BIN)
dbg: $(DBGBIN)
	@echo '빌드됨: ./$(DBGBIN)  (asan+ubsan)'
else
build:
	@echo '  빌드할 sol.cpp 없음'
dbg: build
endif

# --- 테스트 ----------------------------------------------------------------
# 테스트 데이터가 하나도 없으면 통과 처리하지 않고 분명히 알린다.

test: $(TEST_DEPS)
	@test -n '$(TESTS)' || { echo '  테스트 없음 — tests/01.in 과 tests/01.out 을 만드세요'; exit 1; }
	@$(SUITE_FN); rc=0; $(RUN_PY) || rc=1; $(RUN_CPP) || rc=1; exit $$rc

test-py:
	@test -n '$(TESTS)' || { echo '  테스트 없음 — tests/01.in 과 tests/01.out 을 만드세요'; exit 1; }
	@$(SUITE_FN); $(RUN_PY)

test-cpp: $(TEST_DEPS)
	@test -n '$(TESTS)' || { echo '  테스트 없음 — tests/01.in 과 tests/01.out 을 만드세요'; exit 1; }
	@$(SUITE_FN); $(RUN_CPP)

# --- 실행 (stdin 그대로) ----------------------------------------------------

ifdef HAS_CPP
run: run-cpp
else
run: run-py
endif

run-py:
	@$(PYTHON) sol.py

run-cpp: $(BIN)
	@./$(BIN)

# --- 정리 ------------------------------------------------------------------

clean:
	@rm -rf $(BIN) $(DBGBIN) $(BIN).dSYM $(DBGBIN).dSYM __pycache__
