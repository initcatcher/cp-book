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
| `make test T=02` | 그 케이스 하나만 |
| `make test-py` / `make test-cpp` | 한 언어만 |
| `make run` | stdin 으로 실행 (`make run < tests/01.in`) |
| `make dbg` | asan + ubsan + `-g` 로 C++ 빌드 |
| `make clean` | 정리 |

## 푸는 중에 중간 확인하기

**손으로 입력 넣어보기** — 아직 예제를 안 채웠거나 특정 입력만 던져보고 싶을 때:

```sh
printf '1\n5\n' | make run        # 즉석 입력
make run < tests/01.in            # 예제로 실행
make run-py / make run-cpp        # 언어 지정
```

**디버그 출력은 stderr 로** — 채점은 **stdout 만** 본다. 그래서 아래처럼 남긴
디버그 출력은 `make test` 를 깨뜨리지 않고, 실패한 케이스에서만 참고용으로 같이
보여준다.

```python
print(f"[debug] n={n}", file=sys.stderr)   # Python
```
```cpp
cerr << "[debug] x=" << x << '\n';          // C++
```

`cout`/`print` 로 디버그를 찍으면 당연히 출력에 섞여 오답이 된다.

**케이스를 좁혀서** — 예제가 여러 개일 때 하나만:

```sh
make test T=03
```

**작은 반례를 계속 추가하며** — `tests/02.in`/`02.out`, `03.in`/`03.out` … 을
직접 만들어 두면 이후 `make test` 가 전부 같이 돌린다. 손으로 만든 반례가
곧 회귀 테스트가 된다.

**C++ 이 이상하게 죽으면** — 배열 범위 초과나 미초기화 값은 `-O2` 빌드에서 조용히
넘어가기도 한다:

```sh
make dbg && ./sol.dbg.bin < tests/01.in     # asan + ubsan 이 정확한 줄을 짚어준다
```

크래시는 `FAIL … — exit 1` (파이썬 예외) 또는 `exit 139` (세그폴트) 로 표시되고
stderr 가 그대로 따라 나온다.

## 규칙 몇 가지

- **테스트 데이터**는 `tests/01.in` ↔ `tests/01.out` 짝. 케이스를 더 붙이고 싶으면
  `02.in`/`02.out`, `03.in`/`03.out` … 을 추가하면 자동으로 잡힌다.
- **비교**는 공백과 빈 줄을 무시하는 diff. 실패하면 expected/actual 을 보여준다.
- **언어**는 파일이 있는 쪽만 돌린다. 한 언어로만 풀 거면 반대쪽 `sol.*` 를 지우면
  조용히 건너뛴다.
- **C++** 은 `g++ -std=c++17 -O2 -Wall -Wextra`. 바꾸려면 `rules.mk` 의 변수만
  고치거나 `make CXXSTD=c++20 test` 처럼 덮어쓰면 된다.
- **템플릿은 `main()` 하나뿐이다.** 첫 줄의 테스트 케이스 개수를 읽고 그만큼
  도는 루프까지만 짜여 있고, 그 안을 채우면 된다. 케이스를 처리하는 별도 함수를
  강요하지 않으니, 필요하면 직접 함수로 빼면 된다. Python 과 C++ 이 같은 구조다.

  ```python
  C = int(input())
  for _ in range(C):
      n = int(input())
      words = [input() for _ in range(n)]
      print(answer)
  ```

- **답이 여러 개일 수 있는 문제를 조심하라.** 종만북에는 유효한 답이 하나가 아닌
  문제가 있다(위상정렬 결과, 임의의 최단 경로 등). 이때 공식 예제 출력은 그중
  하나일 뿐이라 **맞는 풀이도 정확 비교에서 오답**으로 나온다. 답을 하나로 고정하는
  규칙(예: 후보 중 사전순 최소)을 정한 뒤 `tests/*.out` 을 그 기준으로 두고,
  `note.md` 에 그 사실을 적어 두면 된다.

- **Python 입력**은 그냥 `input()` 을 쓰면 된다. 템플릿이 `sys.stdin.readline`
  기반으로 덮어써 두었고 개행도 떼 주므로, 문자열을 읽을 때 `.strip()` 을 빼먹어
  틀리는 일이 없다. `int(input())`, `map(int, input().split())`,
  `[input() for _ in range(n)]` 이 그대로 동작한다.

  드물게 한 줄에 들어와야 할 토큰이 여러 줄에 걸쳐 오는 문제라면 줄 단위 읽기가
  맞지 않는다. 그럴 때만 `main()` 위에 토큰 단위 리더를 두고 쓰면 된다:

  ```python
  _tok = (t for line in sys.stdin for t in line.split())
  read = lambda: next(_tok)
  ```

## 참고

- 책 공식 소스: `algosrc.zip` (문제별 폴더 + 2줄짜리 Makefile 구조를 여기서 따왔다)
- 비슷한 레포: [conankun/jmbook](https://github.com/conankun/jmbook) (챕터 중첩 구조 참고)
