# problems/

문제 폴더는 `problems/<챕터>/<문제ID>/` 두 단계로 둔다.

```
problems/
├── 06-brute-force/
│   ├── PICNIC/
│   └── CLOCKSYNC/
└── 08-dp/
    ├── JUMPGAME/
    └── WILDCARD/
```

폴더는 직접 만들지 말고 루트에서 `make new` 로 만든다 — `_template/` 이 복사되고
`{{PROBLEM}}` / `{{CHAPTER}}` 자리표시자가 채워진다.

```sh
make new P=08-dp/WILDCARD
```

## 챕터 폴더 이름

이름은 자유지만, 아래처럼 `번호-영문슬러그`로 두면 정렬도 되고 `make test CH=08-dp`
처럼 치기도 편하다. (공백과 한글이 섞인 경로는 make 인자로 넘길 때 번거롭다.)

| 장 | 제목 | 슬러그 |
|----|------|--------|
| 06 | 무식하게 풀기 | `06-brute-force` |
| 07 | 분할 정복 | `07-divide-conquer` |
| 08 | 동적 계획법 | `08-dp` |
| 09 | 동적 계획법 테크닉 | `09-dp-techniques` |
| 10 | 탐욕법 | `10-greedy` |
| 11 | 조합 탐색 | `11-combinatorial-search` |
| 12 | 최적화 문제 결정 문제로 바꿔 풀기 | `12-decision-problem` |
| 13 | 수치 해석 | `13-numerical` |
| 14 | 정수론 | `14-number-theory` |
| 15 | 계산 기하 | `15-geometry` |
| 16 | 비트마스크 | `16-bitmask` |
| 17 | 부분 합 | `17-partial-sum` |
| 18 | 선형 자료 구조 | `18-linear-ds` |
| 19 | 큐와 스택, 데크 | `19-queue-stack-deque` |
| 20 | 문자열 | `20-string` |
| 21 | 트리의 구현과 순회 | `21-tree` |
| 22 | 이진 검색 트리 | `22-bst` |
| 23 | 우선순위 큐와 힙 | `23-heap` |
| 24 | 구간 트리 | `24-segment-tree` |
| 25 | 상호 배타적 집합 | `25-disjoint-set` |
| 26 | 트라이 | `26-trie` |
| 27 | 그래프의 표현과 정의 | `27-graph` |
| 28 | 그래프의 깊이 우선 탐색 | `28-dfs` |
| 29 | 그래프의 너비 우선 탐색 | `29-bfs` |
| 30 | 최단 경로 알고리즘 | `30-shortest-path` |
| 31 | 최소 비용 신장 트리 | `31-mst` |
| 32 | 네트워크 유량 | `32-network-flow` |

## 문제 폴더 이름

algospot 의 문제 ID 를 그대로 대문자로 쓴다 — `WILDCARD`, `PICNIC`, `QUADTREE`.
전역에서 유일하므로 나중에 찾기 쉽다.
