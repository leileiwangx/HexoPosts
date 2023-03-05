---
title: Trie
date: 2021-06-08 14:36:26
tags:
  - CodingInterviews
---


```python
class Trie:
    def __init__(self) -> None:
        self.root = {}
    
    def insert(self, word):
        cur = self.root
        for c in word:
            if c not in cur:
                cur[c] = {}
            cur = cur[c]
        cur['#'] = True

    def search(self, word):
        cur = self.root
        for c in word:
            if c not in cur:
                return False
            cur = cur[c]
        # return cur['#']
        return True if cur and '#' in cur else False

    def startWith(self, prefix):
        cur = self.root
        for c in prefix:
            if c not in cur:
                return False
            cur = cur[c]
        return True   
```