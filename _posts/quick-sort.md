---
title: quick sort
date: 2021-06-23 01:15:07
tags:
  - CLRS
---

```python
class QuickSort:
    def __init__(self, nums):
        self.nums = nums

    def partition(self, lo, hi):
        pivot = self.nums[hi]
        i = lo
        for j in range(lo, hi):
            if self.nums[j] < pivot:
                # i停留在大于pivot的数， 等到j找到下一个小于pivot的数交换
                self.nums[i], self.nums[j] = self.nums[j], self.nums[i]
                i += 1
        self.nums[i], self.nums[hi] = self.nums[hi], self.nums[i]
        return i

    def sort(self, lo, hi):
        if lo >= hi:
            return
        idx = self.partition(lo, hi)
        self.sort(lo, idx - 1)
        self.sort(idx + 1, hi)

nums=[1,2,5,9,3,5,10,11,7]
quicksort = QuickSort(nums)
quicksort.sort(0, len(nums) - 1)
print(quicksort.nums)
```


```python
def quick_sort(nums):
    def partition(lo, hi):
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

nums=[1,2,5,9,3,5,10,11,7]
quick_sort(nums)
print(nums)
```