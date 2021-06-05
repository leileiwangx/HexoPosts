---
title: LFU
date: 2021-06-05 00:33:05
tags:
  - CodingInterviews
---

Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the LFUCache class:

LFUCache(int capacity) Initializes the object with the capacity of the data structure.
int get(int key) Gets the value of the key if the key exists in the cache. Otherwise, returns -1.
void put(int key, int value) Update the value of the key if present, or inserts the key if not already present. When the cache reaches its capacity, it should invalidate and remove the least frequently used key before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used key would be invalidated.
To determine the least frequently used key, a use counter is maintained for each key in the cache. The key with the smallest use counter is the least frequently used key.
When a key is first inserted into the cache, its use counter is set to 1 (due to the put operation). The use counter for a key in the cache is incremented either a get or put operation is called on it.

Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is  most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[3,4], cnt(4)=2, cnt(3)=3


```python
class Node:
    def __init__(self, key = None, val = None):
        self.key = key
        self.val = val
        self.freq = 1
        self.prev = None
        self.next = None

class DLinkedList:
    def __init__(self):
        self.head = Node()
        self.tail = Node()
        self.head.next = self.tail
        self.tail.prev = self.head
        self.size = 0

    def addToHead(self, node):
        self.head.next.prev = node
        node.next= self.head.next
        node.prev = self.head
        self.head.next = node
        self.size += 1

    def removeTail(self):
        node = self.tail.prev
        self.removeNode(node)
        return node

    def removeNode(self, node):
        node.next.prev = node.prev
        node.prev.next = node.next
        self.size -= 1


class LFUCache:
    def __init__(self, capacity):
        self.key_node = dict()
        self.freq_DLinkedList = dict()
        self.capacity = capacity
        self.minFreq = 0 #

    def get(self, key):
        if key in self.key_node:
            node = self.key_node[key]
            self.increase_key_freq(key)
            return node.val
        return -1

    def put(self, key, val):
        if not self.capacity:
            return
        if key in self.key_node:
            node = self.key_node[key]
            node.val = val
            self.increase_key_freq(key)
        else:
            # remove first
            if len(self.key_node) >= self.capacity:  # >
                # self.freq_DLinkedList[self.minFreq].removeTail()
                # self.key_node.pop(node.key) #
                self.remove_Min_freq()
            node = Node(key, val)
            if node.freq not in self.freq_DLinkedList:
                self.freq_DLinkedList[node.freq] = DLinkedList()
            self.key_node[key] = node
            self.freq_DLinkedList[node.freq].addToHead(node)
            self.minFreq = 1

    def increase_key_freq(self, key):
        node = self.key_node[key]
        freq = node.freq
        self.freq_DLinkedList[freq].removeNode(node)
        node.freq += 1
        if node.freq not in self.freq_DLinkedList:
            self.freq_DLinkedList[node.freq] = DLinkedList()
        self.freq_DLinkedList[node.freq].addToHead(node)
        # self.key_node[key] = node
        if self.minFreq == freq and self.freq_DLinkedList[freq].size == 0:
            self.minFreq +=1
    
    def remove_Min_freq(self):
        node = self.freq_DLinkedList[self.minFreq].removeTail()
        self.key_node.pop(node.key)
```