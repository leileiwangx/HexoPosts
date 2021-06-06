---
title: UnionFindSet
date: 2021-06-05 18:16:06
tags:
  - UnionFind
---


```python
class UnionFind:
    def __init__(self, n):
        self.size = n
        self.p = [i for i in range(n)]
    
    def find(self, x):
        # 查找根节点，即当前元素所属的集合
        if self.p[x] != x:
            self.p[x] = self.find(self.p[x])

        
```