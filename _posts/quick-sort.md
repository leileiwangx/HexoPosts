---
title: quick sort
date: 2021-06-23 01:15:07
tags:
  - CLRS
---

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
