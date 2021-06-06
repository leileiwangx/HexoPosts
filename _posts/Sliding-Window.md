---
title: Sliding Window
date: 2021-06-06 20:02:28
tags:
  - Sliding Window
---


In many problems dealing with an array (or a LinkedList), we are asked to find or calculate something among all the contiguous subarrays (or sublists) of a given size. For example, take a look at this problem:
> Given an array, find the average of all contiguous subarrays of size "K" in it.

Let's understand this problem with a real input:
```python
Array: [1, 3, 2, 6, -1, 4, 1, 8, 2], K=5
```

Here, we are asked to find the average of all contiguous subarrays of size "5" in the given array. Let's solve this:
1. For the first 5 numbers (subarray from index 0~4), the average is: (1+3+2+6-1)/5 = 2.2;
2. The average of next 5 numbers (subarray from index 1~5) is: (3+2+6-1+4)/5 = 2.8;
3. For the next 5 numbers (subarray from index 2~6), the average is: (2+6-1+4+1)/5 = 2.4;
4. ...

Here is the final output containing the averages of all contiguous subarrays of size 5:
```python
Output: [2.2, 2.8, 2.4, 3.6, 2.8]
```
<!--more-->

A brute-force algorithm will calculate the sum of every 5-element contiguous subarray of the given array and divide the sum by "5" to find the average. This is what the algorithm will look like:
```python
def find_averages_of_subarrays(k, arr):
    result = []
    for i in range(len(arr) - k + 1):
        element_sum = 0.0
        # find sum of next `K` elements
        for j in range(i, i + k):
            element_sum += arr[j]
            # calculate average
            result.append(element_sum / k)
    return result
```

**Time Complexity**: Since for every element of the input array, we are calculating the sum of its next "K" elements, the time complexity of the above algorithm will be O(N\*K) where "N" is the number of elements in the input array.

The inefficiency is that for any two consecutive subarrays of size "5", the overlapping part (which will contain four elements) will be evaluated twice. For example, take the above-mentioned input:
![](https://github.com/wangleileichina/HexoPosts/raw/master/algorithm/sliding_window/00.png)


As you can see, there are four overlapping elements between the subarray (indexed from 0\~4) and the subarray (indexed from 1\~5). Can we somehow reuse the sum we have calculated for the overlapping elements?

The efficient way to solve this problem would be to visualize each contiguous subarray as a sliding window of "5" elements. This means that we will slide the window by one element when we move on to the next subarray. To reuse the sum from the previous subarray, we will subtract the element going out of the window and add the element now being included in the sliding window. This will save us from going through the whole subarray to find the sum and, as a result, the algorithm complexity will reduce to O(N):
![](https://github.com/wangleileichina/HexoPosts/raw/master/algorithm/sliding_window/01.png)


Here is the algorithm for the _Sliding Window_ approach:
```python
def find_averages_of_subarrays(k, arr):
    result = []
    window_sum, start = 0.0, 0
    for end in range(len(arr)):
        window_sum += arr[end]
        # shrink
        if end >= k - 1:
            result.append(window_sum / k)
            window_sum -= arr[start]
            start += 1
    return result
```

In some problems, the size of the sliding window is not fixed. We have to expand or shrink the window based on the problem constraints.


## LeetCode
[209. Minimum Size Subarray Sum](https://leetcode-cn.com/problems/minimum-size-subarray-sum/submissions/)
[904. Fruit Into Baskets](https://leetcode-cn.com/problems/fruit-into-baskets/)
[3. Longest Substring Without Repeating Characters](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/)
[424. Longest Repeating Character Replacement](https://leetcode-cn.com/problems/longest-repeating-character-replacement/)
[1004. Max Consecutive Ones III](https://leetcode-cn.com/problems/max-consecutive-ones-iii/)
[567. Permutation in String](https://leetcode-cn.com/problems/permutation-in-string/)
[76. Minimum Window Substring](https://leetcode-cn.com/problems/minimum-window-substring/)
[Find All Anagrams in a String](https://leetcode.com/problems/find-all-anagrams-in-a-string/)
[Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/)
[Substring with Concatenation of All Words](https://leetcode.com/problems/substring-with-concatenation-of-all-words/)