---
title: preSum
date: 2021-06-02 11:10:15
tags:
  - preSum
---

        preSum = [0] + nums
        for i in range(1, len(preSum)):
            preSum[i] = preSum[i-1] + preSum[i]

## Continuous Subarray Sum
Given an integer array nums and an integer k, return true if nums has a continuous subarray of size at least two whose elements sum up to a multiple of k, or false otherwise.
An integer x is a multiple of k if there exists an integer n such that x = n * k. 0 is always a multiple of k.
nums = [23,2,4,6,7], k = 6 True
nums = [23,2,6,4,7], k = 13 False
TLE:

        preSum = [0] + nums
        for i in range(1, len(preSum)):
            preSum[i] = preSum[i-1] + preSum[i]
        for i in range(len(preSum) - 2):
            for j in range(i+2, len(preSum)):
                if (preSum[j] - preSum[i]) % k == 0:
                    return True
        return False

(presum[j] - presum[i]) % k == 0  => presum[j] % k == presum[i] % k


    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        preSum = [0] + nums
        for i in range(1, len(preSum)):
            preSum[i] = preSum[i-1] + preSum[i]
        modset = set()
        for i in range(len(preSum) - 2):
            modset.add(preSum[i] % k)
            if preSum[i + 2] % k  in modset:
                return True
        return False

Extend : the number of continuous subarray sum:

    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        preSum = [0] + nums
        for i in range(1, len(preSum)):
            preSum[i] = preSum[i-1] + preSum[i]
        modDict = dict()
        res = 0
        for i in range(len(preSum) - 2):
            cur = preSum[i] % k
            modDict[cur] = modDict.get(cur, 0) + 1
            nex = preSum[i + 2] % k
            if nex  in modDict:
                res += modDict[nex]
        return res



## LeetCode
[523. Continuous Subarray Sum](https://leetcode-cn.com/problems/continuous-subarray-sum/)




