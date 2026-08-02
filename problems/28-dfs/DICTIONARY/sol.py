"""28 / DICTIONARY

링크: https://algospot.com/judge/problem/read/DICTIONARY

사전순으로 정렬됐다고 주장하는 단어 목록에서 알파벳 순서를 복원한다(위상정렬).
모순이 있으면 "INVALID HYPOTHESIS".
"""

import sys
import heapq


def input():
    """한 줄 읽어서 개행 없이 돌려준다. (빠른 입력, 개행 제거)"""
    return sys.stdin.readline().rstrip("\n")


def main():
    sys.setrecursionlimit(10**6)

    C = int(input())
    for _ in range(C):
        n = int(input())
        words = [input() for _ in range(n)]

        adj = [set() for _ in range(26)]
        indeg = [0] * 26
        for a,b in zip(words, words[1:]):
            for x,y in zip(a,b):
                if x != y:
                    u,v = ord(x) - 97, ord(y) - 97
                    if v not in adj[u]:
                        adj[u].add(v)
                        indeg[v] += 1
                    break
        heap = [i for i in range(26) if indeg[i] == 0]
        heapq.heapify(heap)
        order = []
        while heap:
            u = heapq.heappop(heap)
            order.append(u)
            for v in adj[u]:
                indeg[v] -= 1
                if indeg[v] == 0:
                    heapq.heappush(heap, v)
        print(''.join(chr(97+i) for i in order))
        if len(order) < 26:
            print("INVALID HYPOTHESIS")
        else:
            print(''.join(chr(97+i) for i in order))
            


        # # 인접한 두 단어에서 처음 갈리는 글자가 순서 제약 하나를 준다.
        # adj = [set() for _ in range(26)]
        # indeg = [0] * 26
        # for a, b in zip(words, words[1:]):
        #     for x, y in zip(a, b):
        #         if x != y:
        #             u, v = ord(x) - 97, ord(y) - 97
        #             if v not in adj[u]:
        #                 adj[u].add(v)
        #                 indeg[v] += 1
        #             break

        # # 위상정렬. 후보가 여럿이면 사전순으로 작은 글자를 먼저 — 답이 하나로 정해진다.
        # heap = [i for i in range(26) if indeg[i] == 0]
        # heapq.heapify(heap)
        # order = []
        # while heap:
        #     u = heapq.heappop(heap)
        #     order.append(u)
        #     for v in adj[u]:
        #         indeg[v] -= 1
        #         if indeg[v] == 0:
        #             heapq.heappush(heap, v)

        # if len(order) < 26:
        #     print("INVALID HYPOTHESIS")
        # else:
        #     print("".join(chr(97 + i) for i in order))


if __name__ == "__main__":
    main()
