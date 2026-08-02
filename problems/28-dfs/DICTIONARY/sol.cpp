// 28 / DICTIONARY
//
// 링크: https://algospot.com/judge/problem/read/DICTIONARY
//
// 사전순으로 정렬됐다고 주장하는 단어 목록에서 알파벳 순서를 복원한다(위상정렬).
// 모순이 있으면 "INVALID HYPOTHESIS".

#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int C;
    // if (!(cin >> C)) return 0;
    // while (C--) {
    //     int n;
    //     cin >> n;
    //     vector<string> words(n);
    //     for (auto& w : words) cin >> w;

    //     // 인접한 두 단어에서 처음 갈리는 글자가 순서 제약 하나를 준다.
    //     vector<vector<bool>> adj(26, vector<bool>(26, false));
    //     vector<int> indeg(26, 0);
    //     for (int i = 0; i + 1 < n; i++) {
    //         const string& a = words[i];
    //         const string& b = words[i + 1];
    //         for (size_t j = 0; j < min(a.size(), b.size()); j++) {
    //             if (a[j] != b[j]) {
    //                 int u = a[j] - 'a', v = b[j] - 'a';
    //                 if (!adj[u][v]) { adj[u][v] = true; indeg[v]++; }
    //                 break;
    //             }
    //         }
    //     }

    //     // 후보가 여럿이면 사전순으로 작은 글자를 먼저 — 답이 하나로 정해진다.
    //     priority_queue<int, vector<int>, greater<int>> pq;
    //     for (int i = 0; i < 26; i++) if (indeg[i] == 0) pq.push(i);

    //     string order;
    //     while (!pq.empty()) {
    //         int u = pq.top(); pq.pop();
    //         order += char('a' + u);
    //         for (int v = 0; v < 26; v++)
    //             if (adj[u][v] && --indeg[v] == 0) pq.push(v);
    //     }

    //     if (order.size() < 26) cout << "INVALID HYPOTHESIS\n";
    //     else cout << order << '\n';
    // }
    // return 0;
}
