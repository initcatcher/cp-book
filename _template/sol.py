"""{{CHAPTER}} / {{PROBLEM}}

링크: https://algospot.com/judge/problem/read/{{PROBLEM}}

이 문제를 C++ 로만 풀 거면 이 파일을 지우면 된다 — make test 가 조용히 건너뛴다.
"""

import sys


def solve(read):
    """테스트 케이스 하나를 풀어서 출력할 값을 돌려준다.

    read() 를 부를 때마다 입력 토큰이 문자열로 하나씩 나온다.
    예)  n = int(read())
         arr = [int(read()) for _ in range(n)]
    """
    # TODO
    return ""


def main():
    sys.setrecursionlimit(10**6)

    tokens = iter(sys.stdin.buffer.read().split())
    read = lambda: next(tokens).decode()  # noqa: E731

    # 종만북/algospot 은 첫 줄이 테스트 케이스 개수 C.
    results = [solve(read) for _ in range(int(read()))]
    sys.stdout.write("\n".join(str(r) for r in results) + "\n")


if __name__ == "__main__":
    main()
