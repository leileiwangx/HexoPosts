---
title: merge sort
date: 2021-06-23 10:46:47
tags:
  - sort algorithm
---

```python
class MergeSort:
    def __init__(self, nums):
        self.nums = nums
        self.temp = [-1] * len(self.nums)

    def merge(self, lo, mid, hi):
        i, j = lo, mid + 1
        k = lo
        while i <= mid and j <= hi:
            if self.nums[i] < self.nums[j]:
                self.temp[k] = self.nums[i]
                i += 1
            else:
                self.temp[k] = self.nums[j]
                j += 1
            k += 1
        while i <= mid:
            self.temp[k] = self.nums[i]
            i += 1
            k += 1
        while j <= hi:
            self.temp[k] = self.nums[j]
            j += 1
            k += 1
        self.nums[lo : hi + 1] = self.temp[lo : hi + 1]

    def sort(self, lo, hi):
        if lo >= hi:
            return
        # bottom up
        mid = lo + ((hi - lo) >> 1)
        self.sort(lo, mid)
        self.sort(mid + 1, hi) # mid + 1
        self.merge(lo, mid, hi)

nums = [1,23,45,2,5,8,1,29]
mergesort = MergerSort(nums)
mergesort.sort(0, len(nums) - 1)
print(mergesort.nums)
```
