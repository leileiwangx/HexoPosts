---
title: Binary Index Tree
date: 2022-06-12 02:36:36
tags:
---


[树状数组](https://oi-wiki.org/ds/fenwick/)

```
# 怎么知道  管理的数组  中的哪个区间呢？ 这时，我们引入一个函数——lowbit
def lowbit(x):
    """
    x 的二进制表示中，最低位的 1 的位置。
    lowbit(0b10110000) == 0b00010000
             ~~~^~~~~
    lowbit(0b11100100) == 0b00000100
             ~~~~~^~~
    """
    return x & -x

def add(x, k):
    while x <= n: # 不能越界
        c[x] = c[x] + k
        x = x + lowbit(x)

def getsum(x): # a[1]..a[x]的和
    ans = 0
    while x >= 1:
        ans = ans + c[x]
        x = x - lowbit(x)
    return ans
```


```
class NumArray:

    def __init__(self, nums: List[int]):
        n = len(nums)
        self.nums = [0] * (n)
        self.sums = [0] * (n + 1)
        for i in range(n):
            self.update(i, nums[i])


    def update(self, index: int, val: int) -> None:
        delta = val - self.nums[index]
        i = index + 1
        self.nums[index] = val
        while i < len(self.sums): # i: index of sums
            self.sums[i] += delta
            i += self.lowbit(i)

    def lowbit(self, x):
        return x & (-x)
    
    def getSum(self, i):
        ans = 0
        while i >= 1: # index of sums, >= 1
            ans += self.sums[i]
            i -= self.lowbit(i)
        return ans

    def sumRange(self, left: int, right: int) -> int:
        return self.getSum(right + 1) - self.getSum(left)

```


[307. 区域和检索 - 数组可修改](https://leetcode.cn/problems/range-sum-query-mutable/)







