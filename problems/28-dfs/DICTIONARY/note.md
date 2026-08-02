# DICTIONARY

- 챕터: 28
- 링크: https://algospot.com/judge/problem/read/DICTIONARY

## 문제 요약

## 접근

## 시간/공간 복잡도

- 시간:
- 공간:

## 막혔던 곳 / 배운 것

## 주의: 답이 여러 개인 문제 (special judge)

유효한 알파벳 순서가 하나가 아니다. algospot 공식 예제 출력은 그중 하나일 뿐이라,
문자열 정확 비교로는 맞는 풀이도 오답으로 나온다. 실제로 확인한 예 (케이스 2):

- 공식 예제: `ogklhabcdefijmnpqrstuvwxyz`
- 이 풀이:   `abcdefijmnogklhpqrstuvwxyz`

둘 다 모든 순서 제약을 만족한다(독립 검증기로 확인). 케이스 1·3 은 공식 예제와 동일.

그래서 `tests/01.out` 은 **이 풀이의 출력**으로 두었다. 풀이는 후보가 여럿일 때
사전순으로 작은 글자를 먼저 뽑아 답을 하나로 고정한다(우선순위 큐). 회귀 테스트로는
의미가 있지만, 다른 유효한 순서를 내는 풀이로 바꾸면 이 파일도 같이 갱신해야 한다.

공식 예제 출력 원본은 `~/.claude/jobs/.../DICTIONARY-official-sample.out` 에 보관.
