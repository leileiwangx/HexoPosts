---
title: bit manipulation
date: 2021-06-08 22:56:05
tags:
  - bit manipulation
---

## Tips:

remove rightest 1:
    n = n & (n - 1)
    n -= (~ n + 1) & n

get the rightest 1:
    (~ n + 1) & n


