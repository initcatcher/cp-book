# 이 파일은 건드릴 일이 거의 없다.
# 실제 빌드/테스트 규칙은 레포 루트의 rules.mk 한 곳에 있다.
#
#   make        빌드        make test      전체 검증
#   make dbg    asan+ubsan  make test-py   파이썬만
#   make run    stdin 실행  make test-cpp  C++만

ROOT := $(shell d="$$PWD"; while [ "$$d" != / ]; do if [ -f "$$d/rules.mk" ]; then echo "$$d"; break; fi; d=$$(dirname "$$d"); done)

ifeq ($(ROOT),)
$(error 상위 디렉터리에서 rules.mk 를 찾을 수 없습니다 — 이 폴더가 레포 안에 있는지 확인하세요)
endif

include $(ROOT)/rules.mk
