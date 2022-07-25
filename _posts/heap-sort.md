---
title: heap sort
date: 2021-06-08 14:23:01
tags:
  - CLRS
---

```python
def heap_sort(nums):
    def heapify(n, i):
        # find largest among root and children
        while True:
            largest = i
            left = 2 * i + 1
            right = 2 * i + 2
            if left < n and nums[i] < nums[left]:
                largest = left
            if right < n and nums[largest] < nums[right]:
                largest = right
            if largest == i:
                break
            nums[i], nums[largest] = nums[largest], nums[i]
            i = largest

    n = len(nums)
    # build max heap (n)
    for i in range(n // 2 - 1, -1, -1):
        heapify(n, i)
    # heap sort (nlogn)
    for i in range(n-1, 0, -1):
        nums[i], nums[0] = nums[0], nums[i]
        heapify(i, 0)
```

```python
class HeapSort:
    def __init__(self, nums):
        self.nums = nums

    def heapify(self, n, i):
        # find largest among root and children
        largest = i
        left = 2 * i + 1
        right = 2 * i + 2
        if left < n and self.nums[i] < self.nums[left]:
            largest = left
        if right < n and self.nums[largest] < self.nums[right]:
            largest = right
        if largest != i:
            self.nums[i], self.nums[largest] = self.nums[largest], self.nums[i]
            self.heapify(n, largest)

    def sort(self):
        n = len(self.nums)
        # build max heap (n)
        for i in range(n // 2 - 1, -1, -1):
            self.heapify(n, i)
        # heap sort (nlogn)
        for i in range(n-1, 0, -1):
            self.nums[i], self.nums[0] = self.nums[0], self.nums[i]
            self.heapify(i, 0)
            
```

> 非递归实现 空间复杂度 o(1)
```python
class HeapSort:
    def __init__(self, nums):
        self.nums = nums

    def heapify(self, n, i):
        left = i * 2 + 1
        right = i * 2 + 2
        largest = i
        while left < n:
            if self.nums[left] > self.nums[i]:
                largest = left
            if right < n and self.nums[right] > self.nums[largest]:
                largest = right
            if largest != i:
                self.nums[i], self.nums[largest] = self.nums[largest], self.nums[i]
            else:  ##
                break ##  
            i = largest
            left = 2 * i + 1
            right = 2 * i + 2

    def heapInsert(self, i):
        parent = 0
        while i != 0:
            parent = (i - 1) // 2
            if self.nums[parent] < self.nums[i]:
                self.nums[parent], self.nums[i] = self.nums[i], self.nums[parent]
                i = parent
            else:
                break

    def sort(self):
        n = len(self.nums)
        for i in range(n):
            self.heapInsert(i)
        # for i in range(n // 2 - 1, -1, -1):
        #     self.heapify(n, i)
        for i in range(n - 1, 0, -1):
            self.nums[0], self.nums[i] = self.nums[i], self.nums[0]
            self.heapify(i, 0)
```