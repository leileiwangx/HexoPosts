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

