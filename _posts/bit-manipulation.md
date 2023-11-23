---
title: bit manipulation
date: 2021-06-08 22:56:05
tags:
  - bit
---

## Tips:
remove rightest 1:
    n = n & (n - 1)
    n -= (~ n + 1) & n

get the rightest 1:
    (~ n + 1) & n

##
补码的意义
超出 最大 正数表示范围 就是负数了
return majority if majority <= (1 << 31) - 1 else majority - (1 << 32)

##
    hibit = (a&0x80000000)>>31
    if hibit==1:
         return -(((~a)+1)&0xffffffff)
     else:
         return a&0xffffffff

    return res if counts[31] % m == 0 else ~(res ^ 0xffffffff)

```python
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        ans = 0
        for i in range(32):
            total = sum((num >> i) & 1 for num in nums)
            if total % 3:
                # Python 这里对于最高位需要特殊判断  
                if i == 31:
                    ans -= (1 << i)
                else:
                    ans |= (1 << i)
        return ans
```

```python
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        counts = [0] * 32
        for num in nums:
            for j in range(32):
                counts[j] += num & 1
                num >>= 1
        res, m = 0, 3
        for i in range(32):
            res <<= 1
            res |= counts[31 - i] % m
        return res if counts[31] % m == 0 else ~(res ^ 0xffffffff)
```