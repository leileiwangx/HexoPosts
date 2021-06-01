---
title: Python Notes
date: 2021-06-01 15:44:24
tags:
  - python
---


### Rotating functions in Deque

```
import collections as col
my_deque = col.deque('AABCDDEFD')
print('Dequeue: ' + str(my_deque))
#rotate to the right, 3 elements
my_deque.rotate(3)
print('Deque after rotating:' + str(my_deque))
```

Deque after rotating:deque(['E', 'F', 'D', 'A', 'A', 'B', 'C', 'D', 'D'])

