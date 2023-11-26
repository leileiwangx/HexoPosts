---
title: merge sort
date: 2021-06-23 10:46:47
tags:
  - sort
---

```python
def mergesort(nums):
    def merge_sort(lo, hi):
        if lo >= hi:
            return
        mid = lo + ((hi - lo) >> 1)
        merge_sort(lo, mid)
        merge_sort(mid + 1, hi)
        merge(lo, mid, hi)

    def merge(lo, mid, hi):
        i, j = lo, mid + 1
        k = lo
        while i <= mid and j <= hi:
            if nums[i] < nums[j]:
                temp[k] = nums[i]
                i += 1
            else:
                temp[k] = nums[j]
                j += 1
            k += 1
        while i <= mid:
            temp[k] = nums[i]
            i += 1
            k += 1
        while j <= hi:
            temp[k] = nums[j]
            j += 1
            k += 1
        nums[lo: hi + 1] = temp[lo: hi + 1]

    n = len(nums)
    temp = [-1] * n
    lo, hi = 0, n - 1
    merge_sort(lo, hi)


nums = [1, 23, 45, 2, 5, 8, 1, 29]
mergesort(nums)
print(nums)
```

```python
def merge_sort(nums):
    n = len(nums)
    dst = nums[:]
    length = 1
    while length < n:
        start = 0
        while start < n:
            mid = min(start + length, n)
            end = min(start + length * 2, n)
            i, j, k = start, mid, start
            while i < mid or j < end:
                if j == end or (i < mid and  nums[i] < nums[j]):
                    dst[k] = nums[i]
                    i += 1
                else:
                    dst[k] = nums[j]
                    j += 1
                k += 1
            start += length * 2

        nums = dst[:]  
        length += length
```


