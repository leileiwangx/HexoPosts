---
title: Trie
date: 2021-06-08 14:36:26
tags:
  - CodingInterviews
---

```python
from collections import defaultdict
# TreeNode can search children and determine whether it's end or not
class TrieNode:
    def __init__(self):
        self.children = defaultdict(TrieNode)
        self.is_word = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for w in word:
            # use defaultdict without declaring value
            node = node.children[w]
        node.is_word = True

    def search(self, word):
        node = self.root
        for w in word:
            node = node.children.get(w)
            if not node:
                return False
        return node.is_word

    def startsWith(self, prefix):
        node = self.root
        for w in prefix:
            node = node.children.get(w)
            if not node:
                return False
        # search prefix/word is different
        return True
```