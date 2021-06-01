---
title: Coding Interviews
date: 2021-06-01 23:25:57
tags:
  - CodingInterviews
---


### 16.Pow(x, n)

    def myPow(self, x: float, n: int) -> float:
        if x == 0.0: return 0.0
        res = 1
        if n < 0:
            x, n = 1 / x, -n
        while n:
            if n & 1 == 1:
                res *= x
            x *= x
            n >>= 1 # n >> 1
        return res