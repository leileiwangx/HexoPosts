---
title: Min-Stack
date: 2021-05-31 23:15:01
tags:
  - leetcode
---


## Description
Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
Implement the MinStack class:
MinStack() initializes the stack object.
void push(val) pushes the element val onto the stack.
void pop() removes the element on the top of the stack.
int top() gets the top element of the stack.
int getMin() retrieves the minimum element in the stack.
## Example
### Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]
### Output
[null,null,null,null,-3,null,0,-2]
### Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2

### Constraints:
-231 <= val <= 231 - 1
Methods pop, top and getMin operations will always be called on non-empty stacks.
At most 3 * 104 calls will be made to push, pop, top, and getMin.

## Solution:

    class MinStack:

        def __init__(self):
            self.stack = []
            self.minStack = []

        def push(self, val: int) -> None:
            self.stack.append(val)
            if not self.minStack or val <= self.minStack[-1]:
                self.minStack.append(val)

        def pop(self) -> None:
            if self.stack:
                num = self.stack.pop()
                if self.minStack and num == self.minStack[-1]:
                    self.minStack.pop()

        def top(self) -> int:
            return self.stack[-1]

        def getMin(self) -> int:
            return self.minStack[-1]

One stack

    class MinStack:
        def __init__(self):
            self.stack = []
            self.min_value = -1

        def push(self, x: int) -> None:
            if not self.stack:
                self.stack.append(0)
                self.min_value = x
            else:
                diff = x-self.min_value
                self.stack.append(diff)
                self.min_value = self.min_value if diff > 0 else x

        def pop(self) -> None:
            if self.stack:
                diff = self.stack.pop()
                if diff < 0:
                    top = self.min_value
                    self.min_value = top - diff

        def top(self) -> int:
            return self.min_value if self.stack[-1] < 0 else self.stack[-1] + self.min_value

        def getMin(self) -> int:
            return self.min_value if self.stack else -1
