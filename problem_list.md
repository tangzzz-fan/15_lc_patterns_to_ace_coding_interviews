## 1. Prefix Sum（前缀和）
**核心思想**：预处理数组，构建前缀和数组，将区间求和查询优化到 O(1)。

**何时使用**：需要多次查询子数组和，或计算累积和。

**示例**：求 `nums = [1,2,3,4,5,6]` 中索引 `[1,3]` 的和 → 前缀和数组 `P = [1,3,6,10,15,21]`，结果 `P[3] - P[0] = 9`

**推荐题**：
- #303 Range Sum Query - Immutable
- #525 Contiguous Array
- #560 Subarray Sum Equals K

---

## 2. Two Pointers（双指针）
**核心思想**：使用两个指针从数组两端或同向遍历，将 O(n²) 优化到 O(n)。

**何时使用**：处理有序数组，寻找满足特定条件的数对。

**示例**：在有序数组 `[1,2,3,4,6]` 中找到和为 6 的两个数 → `left` 从 0 开始，`right` 从末尾开始，根据和的大小移动指针。

**推荐题**：
- #167 Two Sum II - Input Array is Sorted
- #15 3Sum
- #11 Container With Most Water

---

## 3. Sliding Window（滑动窗口）
**核心思想**：维护一个可变或固定大小的窗口，滑动时只更新边界元素，避免重复计算。

**何时使用**：涉及连续子数组/子串的问题。

**示例**：求大小为 3 的子数组最大和 → 先算前 3 个元素之和，然后每次右移窗口，减去左边出窗元素，加上右边入窗元素。

**推荐题**：
- #643 Maximum Average Subarray I
- #3 Longest Substring Without Repeating Characters
- #76 Minimum Window Substring

---

## 4. Fast & Slow Pointers（快慢指针 / 龟兔赛跑）
**核心思想**：慢指针每次走 1 步，快指针每次走 2 步，用于检测循环。

**何时使用**：链表判环、寻找重复数等问题。

**示例**：检测链表是否有环 → 快指针最终会追上慢指针（相遇则有环），或到达末尾（无环）。

**推荐题**：
- #141 Linked List Cycle
- #202 Happy Number
- #287 Find the Duplicate Number

---

## 5. Linked List In-place Reversal（链表原地反转）
**核心思想**：通过调整指针方向，在不使用额外空间的情况下反转链表局部或全部。

**何时使用**：需要反转链表的某一段。

**示例**：反转链表从位置 m 到 n 的子链表 → 逐步调整 `next` 指针指向。

**推荐题**：
- #206 Reverse Linked List
- #92 Reverse Linked List II
- #24 Swap Nodes in Pairs

---

## 6. Monotonic Stack（单调栈）
**核心思想**：使用栈维护递增或递减序列，快速找到下一个更大/更小元素。

**何时使用**：需要找「下一个更大元素」或「下一个更小元素」。

**示例**：`nums = [2,1,2,4,3]` 的下一个更大元素 → `[4,2,4,-1,-1]`

**推荐题**：
- #496 Next Greater Element I
- #739 Daily Temperatures
- #84 Largest Rectangle in Histogram

---

## 7. Top 'K' Elements（前 K 个元素）
**核心思想**：使用大小为 K 的 Min-Heap（找最大 K 个）或 Max-Heap（找最小 K 个）。

**何时使用**：从数据流或数组中找到前 K 大/小的元素。

**示例**：找第 K 大的元素 → 维护大小为 K 的最小堆，堆顶即为第 K 大。

**推荐题**：
- #215 Kth Largest Element in an Array
- #347 Top K Frequent Elements
- #373 Find K Pairs with Smallest Sums

---

## 8. Overlapping Intervals（重叠区间）
**核心思想**：先按开始时间排序，然后合并或处理重叠区间。

**何时使用**：涉及区间合并、插入、最少删除等。

**示例**：`[[1,3],[2,6],[8,10],[15,18]]` → 合并为 `[[1,6],[8,10],[15,18]]`

**推荐题**：
- #56 Merge Intervals
- #57 Insert Interval
- #435 Non-Overlapping Intervals

---

## 9. Modified Binary Search（变形二分查找）
**核心思想**：在标准二分查找基础上，增加对旋转数组、二维矩阵等场景的适配。

**何时使用**：在有序或旋转数组中查找特定元素。

**示例**：在旋转数组 `[4,5,6,7,0,1,2]` 中找 0 → 先判断哪一半是有序的，再决定搜索方向。

**推荐题**：
- #33 Search in Rotated Sorted Array
- #153 Find Minimum in Rotated Sorted Array
- #240 Search a 2D Matrix II

---

## 10. Binary Tree Traversal（二叉树遍历）
**核心思想**：掌握前序、中序、后序三种遍历方式（递归或迭代）。

**何时使用**：所有二叉树相关问题。

**推荐题**：
- #257 Binary Tree Paths（前序）
- #230 Kth Smallest Element in a BST（中序）
- #124 Binary Tree Maximum Path Sum（后序）

---

## 11. Depth-First Search（DFS，深度优先搜索）
**核心思想**：递归或栈实现，尽可能深入探索每条分支后再回溯。

**何时使用**：探索所有路径、连通分量、图/树的遍历。

**推荐题**：
- #133 Clone Graph
- #113 Path Sum II
- #210 Course Schedule II

---

## 12. Breadth-First Search（BFS，广度优先搜索）
**核心思想**：使用队列按层遍历，适合找最短路径。

**何时使用**：无权图最短路径、树的层序遍历。

**推荐题**：
- #102 Binary Tree Level Order Traversal
- #994 Rotting Oranges
- #127 Word Ladder

---

## 13. Matrix Traversal（矩阵遍历）
**核心思想**：在二维网格上使用 DFS 或 BFS，注意 4 方向/8 方向移动和边界检查。

**何时使用**：岛屿、区域、迷宫等网格问题。

**示例**：Flood Fill 算法，从起始点出发，将连通区域填充为新颜色。

**推荐题**：
- #733 Flood Fill
- #200 Number of Islands
- #130 Surrounded Regions

---

## 14. Backtracking（回溯）
**核心思想**：递归探索所有可能的解，当某条路径不满足条件时回退。

**何时使用**：排列、组合、子集、N 皇后等组合问题。

**示例**：生成 `[1,2,3]` 的所有排列 → 递归选择每个元素，回溯时撤销选择。

**推荐题**：
- #46 Permutations
- #78 Subsets
- #51 N-Queens

---

## 15. Dynamic Programming（动态规划）
**核心思想**：将问题分解为重叠子问题，使用自底向上或记忆化搜索求解。

**常用子模式**：
- Fibonacci Numbers
- 0/1 Knapsack
- Longest Common Subsequence (LCS)
- Longest Increasing Subsequence (LIS)
- Subset Sum
- Matrix Chain Multiplication

**推荐题**：
- #70 Climbing Stairs
- #198 House Robber
- #322 Coin Change
- #1143 Longest Common Subsequence
- #300 Longest Increasing Subsequence
- #416 Partition Equal Subset Sum

---

## 总结与建议

| 模式 | 难度 | 面试频率 | 核心数据结构 |
|------|------|----------|-------------|
| Prefix Sum | ⭐ | 高 | 数组 |
| Two Pointers | ⭐ | 极高 | 数组 |
| Sliding Window | ⭐⭐ | 极高 | 数组/字符串 |
| Fast & Slow Pointers | ⭐ | 中 | 链表 |
| Linked List Reversal | ⭐⭐ | 中 | 链表 |
| Monotonic Stack | ⭐⭐⭐ | 中高 | 栈 |
| Top K Elements | ⭐⭐ | 高 | 堆 |
| Overlapping Intervals | ⭐⭐ | 高 | 数组 |
| Modified Binary Search | ⭐⭐ | 高 | 数组 |
| Binary Tree Traversal | ⭐⭐ | 高 | 树 |
| DFS | ⭐⭐ | 极高 | 树/图 |
| BFS | ⭐⭐ | 极高 | 树/图 |
| Matrix Traversal | ⭐⭐ | 中高 | 二维数组 |
| Backtracking | ⭐⭐⭐ | 中高 | 递归树 |
| Dynamic Programming | ⭐⭐⭐ | 极高 | 数组/矩阵 |

**核心学习策略**：不要追求题量，而是按模式分类刷题。每掌握一个模式，就能解决一类问题。作者建议深度理解 300 道高质量题目，比 superficially 刷 500 道更有效。