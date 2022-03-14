---
title: UnionFindSet
date: 2021-06-05 18:16:06
tags:
  - UnionFind
---

```python
from collections import defaultdict

def find(x, parent):
    r = x
    while r != parent[r]:
        r = parent[r]
    return r

def union(x, y, parent,size):
    x_root = find(x, parent)
    y_root = find(y, parent)
    if x_root != y_root:
        if size[x_root] > size[y_root]:
            parent[y_root] = x_root
            size[x_root] += size[y_root]
        else:
            parent[x_root] = y_root
            size[y_root] += size[x_root]


class Solution(object):
    def findCircleNum(self, M):
        parent = defaultdict(int)
        size = defaultdict(int)
        ans = set()
        if not M:
            return 0
        for i in range(len(M)):
            parent[i] = i
            size[i] = 1
        for i in range(len(M)):
            for j in range(i, len(M[0])):
                if M[i][j] == 1:
                    union(i, j, parent,size)

        for i in parent:
            ans.add(find(i, parent))
        return len(ans)
```






## LeetCode
[778. Swim in Rising Water](https://leetcode-cn.com/problems/swim-in-rising-water/)
[200. Number of Islands](https://leetcode-cn.com/problems/number-of-islands/)
