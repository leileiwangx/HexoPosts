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


### Decorator MyCache

```python
import time

def timeit(func):
    def inner(*args):
        start = time.time()
        func(*args)
        end = time.time()
        print(f'{func.__name__} finished in {end - start} seconds')
    return inner

@timeit
def sleep_method():
    time.sleep(2)
    print('Done')

sleep_method()


class MyCache:
  def __init__(self, func):
    self.func = func
    self.cache = dict()

  def __call__(self, *args):
    if args not in self.cache:
      self.cache[args] = self.func(*args)
    return self.cache[args]


@MyCache
def fib(n):
    if n <= 1: return 1
    return fib(n - 1) + fib(n - 2)

print(fib(34))
```

### sort dict
by key:
d = sorted(d.keys())
d = sorted(d.items(),key=lambda x:x[0],reverse=True)

by value:
d = sorted(d.values())
d = sorted(d.items(),key=lambda x:x[1],reverse=True)

