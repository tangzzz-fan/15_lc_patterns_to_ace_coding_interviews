# LeetCodeList — Dart 算法解题练习仓库

按**算法模式**分类的 LeetCode 练习框架，基于 Dart 语言。每个模式提供完整的解题思路注释 + 空代码骨架 + 配套测试用例。

> 15 种模式源自 [Ashish Pratap Singh](https://blog.algomaster.io) 的博文 **[15 LeetCode Patterns to Ace Coding Interviews](https://blog.algomaster.io/p/15-leetcode-patterns)**，这是一个广受好评的技术面试刷题框架。本文对该框架进行了中文翻译与总结，并构建了可直接使用的 Dart 练习环境。

## 15 种算法模式

| # | 模式 | 难度 | 面试频率 | 核心思想 | 推荐题 |
|---|------|------|----------|----------|--------|
| 1 | **Prefix Sum** 前缀和 | ⭐ | 高 | 预处理前缀和数组，区间查询 O(1) | #303, #525, #560 |
| 2 | **Two Pointers** 双指针 | ⭐ | 极高 | 两端/同向指针遍历，O(n²)→O(n) | #167, #15, #11 |
| 3 | **Sliding Window** 滑动窗口 | ⭐⭐ | 极高 | 维护窗口，只更新进出元素 | #643, #3, #76 |
| 4 | **Fast & Slow Pointers** 快慢指针 | ⭐ | 中 | slow 走 1 步，fast 走 2 步，判环 | #141, #202, #287 |
| 5 | **Linked List Reversal** 链表原地反转 | ⭐⭐ | 中 | 三指针迭代反转 next 方向 | #206, #92, #24 |
| 6 | **Monotonic Stack** 单调栈 | ⭐⭐⭐ | 中高 | 栈内维持单调性，找下一个更大/更小 | #496, #739, #84 |
| 7 | **Top K Elements** 前 K 个元素 | ⭐⭐ | 高 | 大小为 K 的堆，O(n log K) | #215, #347, #373 |
| 8 | **Overlapping Intervals** 重叠区间 | ⭐⭐ | 高 | 按 start 排序，线性合并重叠部分 | #56, #57, #435 |
| 9 | **Modified Binary Search** 变形二分 | ⭐⭐ | 高 | 旋转数组/二维矩阵的二分适配 | #33, #153, #240 |
| 10 | **Binary Tree Traversal** 二叉树遍历 | ⭐⭐ | 高 | 前序(根左右)、中序(左根右)、后序(左右根) | #257, #230, #124 |
| 11 | **DFS** 深度优先搜索 | ⭐⭐ | 极高 | 递归/栈深入探索，回溯/拓扑排序 | #133, #113, #210 |
| 12 | **BFS** 广度优先搜索 | ⭐⭐ | 极高 | 队列按层扩展，天然求最短路径 | #102, #994, #127 |
| 13 | **Matrix Traversal** 矩阵遍历 | ⭐⭐ | 中高 | 二维网格 DFS/BFS，4 方向 + 边界检查 | #733, #200, #130 |
| 14 | **Backtracking** 回溯 | ⭐⭐⭐ | 中高 | 选择→递归→撤销，排列/组合/N皇后 | #46, #78, #51 |
| 15 | **Dynamic Programming** 动态规划 | ⭐⭐⭐ | 极高 | 重叠子问题 + 最优子结构，fib/背包/LCS/LIS | #70, #198, #322, #1143, #300, #416 |

> 共 **15 个模式，45 道核心题**。掌握一个模式就能解决一类问题，而非孤立地刷题。

## 建议扩展的模式

以下模式不在原文 15 种框架中，但同样是面试高频考点。如果备考时间充足（4 周以上），可以根据优先级逐步补充：

| 优先级 | 模式 | 面试频率 | 核心思想 | 建议题 |
|--------|------|----------|----------|--------|
| 🔴 高 | **Union Find** 并查集 | 高 | 连通分量、快速合并与查找，路径压缩 | #547, #684, #323 |
| 🔴 高 | **Greedy** 贪心 | 高 | 每步取局部最优，推导全局最优 | #55, #134, #135 |
| 🟡 中 | **Bit Manipulation** 位运算 | 中高 | 异或找唯一数、位掩码枚举子集 | #136, #191, #338 |
| 🟡 中 | **Trie** 字典树 | 中 | 前缀匹配、自动补全、词频统计 | #208, #211, #677 |
| 🟡 中 | **Design** 设计题 | 中高 | LRU Cache、Min Stack，考察工程思维 | #146, #155, #380 |
| 🟢 低 | **Line Sweep** 扫描线 | 中 | 会议室 II、天际线，区间处理进阶 | #253, #218 |

> **建议**：备考时间 ≤ 3 周先把核心 15 个模式吃透（45 题）；时间 4 周以上优先补充 🔴 高优先级 2 个模式（+6 题），可按需再补 🟡 中优先级。

## 项目结构

```
dart_solutions/
├── pubspec.yaml                   # Dart 项目配置
├── lib/
│   └── shared.dart                # 共享数据结构（ListNode / TreeNode / GraphNode）
├── prefix_sum/
│   └── prefix_sum.dart            # 前缀和 — 注释引导 + 空代码骨架
├── two_pointers/
│   └── two_pointers.dart          # 双指针
├── sliding_window/
│   └── sliding_window.dart        # 滑动窗口
├── fast_slow_pointers/
│   └── fast_slow_pointers.dart    # 快慢指针
├── linked_list_reversal/
│   └── linked_list_reversal.dart  # 链表反转
├── monotonic_stack/
│   └── monotonic_stack.dart       # 单调栈
├── top_k_elements/
│   └── top_k_elements.dart        # 前 K 个元素
├── overlapping_intervals/
│   └── overlapping_intervals.dart # 重叠区间
├── modified_binary_search/
│   └── modified_binary_search.dart# 变形二分查找
├── binary_tree_traversal/
│   └── binary_tree_traversal.dart # 二叉树遍历
├── dfs/
│   └── dfs.dart                   # 深度优先搜索
├── bfs/
│   └── bfs.dart                   # 广度优先搜索
├── matrix_traversal/
│   └── matrix_traversal.dart      # 矩阵遍历
├── backtracking/
│   └── backtracking.dart          # 回溯
├── dynamic_programming/
│   └── dynamic_programming.dart   # 动态规划
└── test/                          # 133 个测试用例
    ├── prefix_sum_test.dart
    ├── two_pointers_test.dart
    ├── sliding_window_test.dart
    ├── fast_slow_pointers_test.dart
    ├── linked_list_reversal_test.dart
    ├── monotonic_stack_test.dart
    ├── top_k_elements_test.dart
    ├── overlapping_intervals_test.dart
    ├── modified_binary_search_test.dart
    ├── binary_tree_traversal_test.dart
    ├── dfs_test.dart
    ├── bfs_test.dart
    ├── matrix_traversal_test.dart
    ├── backtracking_test.dart
    └── dynamic_programming_test.dart
```

## 使用方法

### 1. 环境要求

- Dart SDK ≥ 3.9

```bash
dart --version
```

### 2. 安装依赖

```bash
cd dart_solutions
dart pub get
```

### 3. 解题流程

```
读注释 → 理解思路 → 编写实现 → 运行测试 → 全部通过 ✅
```

以 **前缀和** 为例：

```bash
# 步骤 1：打开源文件，阅读注释和解题步骤
#    dart_solutions/prefix_sum/prefix_sum.dart
#
# 步骤 2：找到以 "// TODO:" 开头的标注，替换 throw UnimplementedError()
#    写出你的实现代码
#
# 步骤 3：运行对应测试
dart test test/prefix_sum_test.dart

# 步骤 4：查看结果
#    全部绿色 → 进入下一题
#    有红色   → 检查失败信息，修正代码后重跑
```

### 4. 单个模式

```bash
# 只跑一个模式的测试（比如动态规划）
dart test test/dynamic_programming_test.dart
```

### 5. 单个题目

```bash
# 只跑某道题
dart test test/two_pointers_test.dart --plain-name '#15 3Sum'
```

### 6. 全部测试

```bash
dart test
```

## 源文件格式说明

每个模式源文件采用统一格式：

```
/// 模式概述（核心原理 / 适用场景 / 复杂度）
/// ================================

// ============================================================================
// LeetCode #XXX: 题目名称（难度 — 子模式）
// ============================================================================
// 题目描述：...
//
// 解题思路：推导过程 + 举例
//
// 实现步骤：分步指引
//   1. ...
//   2. ...
//
// 代码骨架 + TODO 标注
返回值类型 函数名(参数) {
  // TODO: 具体的实现指引
  throw UnimplementedError(); // ← 替换为你的实现
}
```

- 所有 `throw UnimplementedError()` 位置都有 `// TODO:` 引导注释
- 阅读注释即可知道每一步做什么
- 不依赖任何文件之外的资料即可完成编写

## 建议学习路径

```
第 1 轮（模式广度）：每天 2 个模式，读注释 → 写代码 → 跑测试
第 2 轮（模式深度）：重刷卡住的题，不看注释直接写
第 3 轮（随机模拟）：1-2 题/天，计时 30 分钟，不借助资料
```

核心原则：

- **不要跳过注释直接写代码**——理解"为什么"比写出来重要得多
- 卡住超过 20 分钟就去看注释里的思路，死磕浪费时间
- 写完立刻跑 `dart test`，反馈越快记得越牢

## 许可

MIT
