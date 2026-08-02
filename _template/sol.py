"""{{CHAPTER}} / {{PROBLEM}}

링크: https://algospot.com/judge/problem/read/{{PROBLEM}}

이 문제를 C++ 로만 풀 거면 이 파일을 지우면 된다 — make test 가 조용히 건너뛴다.
"""

import sys


def input():
    """한 줄 읽어서 개행 없이 돌려준다.

    빠른 입력이라 builtin input 을 덮어쓴다. 개행을 미리 떼 주므로
    문자열을 읽을 때 .strip() 을 빼먹어 틀리는 일이 없다.
    """
    return sys.stdin.readline().rstrip("\n")


def solve():
    """테스트 케이스 하나를 풀어서 답을 print 한다.

    예)  n = int(input())
         a, b = map(int, input().split())
         words = [input() for _ in range(n)]
         print(answer)

    디버그 출력은 print(..., file=sys.stderr) 로. stdout 은 채점 대상이다.
    """
    # TODO


def main():
    sys.setrecursionlimit(10**6)

    # 종만북/algospot 은 첫 줄이 테스트 케이스 개수.
    # 개수는 여기서만 읽는다 — solve() 안에서 또 읽으면 입력이 어긋난다.
    for _ in range(int(input())):
        solve()


if __name__ == "__main__":
    main()
