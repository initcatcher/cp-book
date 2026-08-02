# cp-book

종만북 (알고리즘 문제 해결 전략) 문제 풀이 — Python + C++.

## 요구사항

`make`, `g++`, `python3`. 이 WSL 환경에는 `make` 가 아직 없으니 한 번만 설치하면 된다:

```sh
sudo apt install make
```

## 빠른 시작

```sh
make new P=08-dp/WILDCARD     # 문제 폴더 생성
cd problems/08-dp/WILDCARD
# tests/01.in, tests/01.out 에 문제의 예제 입출력을 붙여넣고
make test                     # py / cpp 둘 다 검증
```

## 구조

```
cp-book/
├── Makefile              루트 자동화 (new / test / run / list / clean)
├── rules.mk              빌드·테스트 규칙 — 고칠 곳은 여기 한 곳뿐
├── _template/            make new 이 복사하는 원본
│   ├── Makefile          rules.mk 를 include 하는 한 줄짜리
│   ├── sol.py
│   ├── sol.cpp
│   ├── note.md           풀이 메모
│   └── tests/01.in|.out
└── problems/
    └── <챕터>/<문제ID>/   ← make new 으로 생성
```

## 명령

루트에서:

| 명령 | 하는 일 |
|------|---------|
| `make new P=08-dp/WILDCARD` | `_template/` 을 복사해 문제 폴더 생성 |
| `make test` | 전체 문제 테스트 |
| `make test CH=08-dp` | 챕터 일괄 |
| `make test P=08-dp/WILDCARD` | 문제 하나 |
| `make run P=08-dp/WILDCARD` | stdin 으로 실행 |
| `make list` | 문제 목록 + 각 문제에 있는 언어 |
| `make clean` | 빌드 산출물 삭제 |

문제 폴더 안에서 (푸는 동안은 이쪽이 편하다):

| 명령 | 하는 일 |
|------|---------|
| `make` | 빌드 |
| `make test` | `tests/*.in` 전부 실행해 `tests/*.out` 과 비교 |
| `make test-py` / `make test-cpp` | 한 언어만 |
| `make run` | stdin 으로 실행 (`make run < tests/01.in`) |
| `make dbg` | asan + ubsan + `-g` 로 C++ 빌드 |
| `make clean` | 정리 |

## 규칙 몇 가지

- **테스트 데이터**는 `tests/01.in` ↔ `tests/01.out` 짝. 케이스를 더 붙이고 싶으면
  `02.in`/`02.out`, `03.in`/`03.out` … 을 추가하면 자동으로 잡힌다.
- **비교**는 공백과 빈 줄을 무시하는 diff. 실패하면 expected/actual 을 보여준다.
- **언어**는 파일이 있는 쪽만 돌린다. 한 언어로만 풀 거면 반대쪽 `sol.*` 를 지우면
  조용히 건너뛴다.
- **C++** 은 `g++ -std=c++17 -O2 -Wall -Wextra`. 바꾸려면 `rules.mk` 의 변수만
  고치거나 `make CXXSTD=c++20 test` 처럼 덮어쓰면 된다.

## 참고

- 책 공식 소스: `algosrc.zip` (문제별 폴더 + 2줄짜리 Makefile 구조를 여기서 따왔다)
- 비슷한 레포: [conankun/jmbook](https://github.com/conankun/jmbook) (챕터 중첩 구조 참고)
