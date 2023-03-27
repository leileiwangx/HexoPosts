---
title: Algorithm Templates
date: 2023-03-14 23:07:26
tags:
- CLRS

---

# bisect

```python
# 第一个大于等于target的index     
# 返回x插入a后所在位置的index（如果a中存在与x等值的元素，则插入到左侧）
def bisect_left(nums, target):
    lo, hi = 0, len(nums) ## hi = len(nums)
    while lo < hi:
        mi = lo + ((hi - lo) >> 1)
        if nums[mi] >= target:
            hi = mi
        else:
            lo = mi + 1
    return lo                
```

```python
# 返回x插入a后所在位置的index（如果a中存在与x等值的元素，则插入到右侧）
def bisect_right(nums, target):
    lo, hi = 0, len(nums) ## hi = len(nums)
    while lo < hi:
        mi = lo + ((hi - lo) >> 1)
        if nums[mi] > target:
            hi = mi
        else:
            lo = mi + 1
    return lo                
```

# trie
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

# quick sort

```python
from random import randint
def quick_sort(nums):
    def partition(lo, hi):
        rand_idx = randint(lo, hi)
        nums[rand_idx], nums[hi] = nums[hi], nums[rand_idx]
        pivot = nums[hi]
        i = lo
        for j in range(lo, hi):
            if nums[j] < pivot:
                # i停留在大于pivot的数， 等到j找到下一个小于pivot的数交换
                nums[i], nums[j] = nums[j], nums[i]
                i += 1
        nums[i], nums[hi] = nums[hi], nums[i]
        return i

    def sort(lo, hi):
        if lo >= hi:
            return
        idx = partition(lo, hi)
        sort(lo, idx - 1) ### idx - 1
        sort(idx + 1, hi)

    sort(0, len(nums) - 1) 



```