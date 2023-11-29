---
title: segment tree
date: 2021-06-20 00:03:24
tags:
  - tree
---

线段树是一种非常灵活的数据结构，它可以用于解决多种范围查询问题，比如在对数时间内从数组中找到最小值、最大值、总和、最大公约数、最小公倍数等。
线段树既可以用数组也可以用树来实现。对于数组实现，如果索引 i 处的元素不是一个叶节点，那么其左子节点和右子节点分别存储在索引为 2i 和 2i+1 的元素处。
我们从叶节点开始，用输入数组的元素 a[0,1,…,n−1] 初始化它们。然后我们逐步向上移动到更高一层来计算父节点的和，直到最后到达线段树的根节点。

```python3
class NumArray:
    def __init__(self, nums):
        n = len(nums)
        self.tree = [0] * 2 * n
        i, j = n, 0
        while i < 2 * n:
            self.tree[i] = nums[j]
            i += 1
            j += 1
        for i in range(n - 1, 0, -1): # 2n - 1个节点 所以 i 只用取到1
            self.tree[i] = self.tree[i * 2] + self.tree[i * 2 + 1]

    def  update(self, i, val):
        n = len(self.tree) // 2
        i += n
        self.tree[i] = val
        while i > 0:
            left, right = i, i
            if i & 1:
                left = i - 1 # i 为偶数就是左节点
            else:
                right = i + 1
            self.tree[i // 2] = self.tree[left] + self.tree[right]
            i //= 2

    def  sum_range(self, i, j):
        n = len(self.tree) // 2
        i += n
        j += n
        res = 0
        while i <= j:
            if i & 1:
                res += self.tree[i] # 奇数右节点直接加
                i += 1
            if not (j & 1):
                res += self.tree[j]
                j -= 1
            i //= 2
            j //= 2
        return res

nums = [1, 3, 5, 7, 9]
rangeSum = NumArray(nums)
print(rangeSum.sum_range(2, 3))
rangeSum.update(1, 6)
print(rangeSum.sum_range(1, 3))
```

因为我们在 for 循环的每次迭代中计算一个节点的和。而一个线段树中大约有 2n 个节点。
这可以通过以下方式证明：具有 n 个元素的数组线段树有 
n 个叶节点（数组元素本身）。每一层中的节点数是下面一层中节点数的一半。
因此，如果我们按层对节点数求和，我们将得到：n+n/2+n/4+n/8+…+1≈2n

空间复杂度：O(n)，我们用了 2n 的额外空间来存储整个线段树。

## LeetCode
[307. Range Sum Query - Mutable](https://leetcode-cn.com/problems/range-sum-query-mutable/)