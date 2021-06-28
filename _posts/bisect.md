---
title: bisect
date: 2021-06-24 22:15:00
tags:
  - CLRS
---


```python
# 第一个大于等于target的indx
def bisect_left(nums, target):
    lo, hi = 0, len(nums) ## hi = len(nums)
    while lo < hi:
        mi = lo + ((hi - lo) >> 1)
        if nums[mi] >= target:
            hi = mi
        else:
            lo = mi + 1
    return lo                

nums=[7]
print(bisect_left(nums, 8))
print(bisect_left(nums, 7))
```

```python
import bisect
def bisect_right(nums, target):
    lo, hi = 0, len(nums) ## hi = len(nums)
    while lo < hi:
        mi = lo + ((hi - lo) >> 1)
        if nums[mi] > target:
            hi = mi
        else:
            lo = mi + 1
    return lo                

nums=[7,7,7,7,8,8,8,8,9]
print(bisect_right(nums, 8))
print(bisect_right(nums, 7))
print(bisect_right(nums, 10))

print(bisect.bisect_right(nums, 8))
print(bisect.bisect_right(nums, 7))
print(bisect.bisect_right(nums, 10))

8 4 9
```

```python
def bisect_left(a, x, lo=0, hi=None):
    """返回x插入a后所在位置的index（如果a中存在与x等值的元素，则插入到左侧）"""
    
    if lo < 0:
        raise ValueError('lo must be non-negative')
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        if a[mid] < x: lo = mid+1
        else: hi = mid
    return lo
```

```python
def bisect_right(a, x, lo=0, hi=None):
    """返回x插入a后所在位置的index（如果a中存在与x等值的元素，则插入到右侧）"""

    if lo < 0:
        raise ValueError('lo must be non-negative')
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        if x < a[mid]: hi = mid
        else: lo = mid+1
    return lo
```

```python
def insort_left(a, x, lo=0, hi=None):
    """将x插入a（如果a中存在与x等值的元素，则插入到左侧）"""

    if lo < 0:
        raise ValueError('lo must be non-negative')
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        if a[mid] < x: lo = mid+1
        else: hi = mid
    a.insert(lo, x)
```

```python
def insort_right(a, x, lo=0, hi=None):
    """将x插入a（如果a中存在与x等值的元素，则插入到右侧）"""
    
    if lo < 0:
        raise ValueError('lo must be non-negative')
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        if x < a[mid]: hi = mid
        else: lo = mid+1
    a.insert(lo, x)
```