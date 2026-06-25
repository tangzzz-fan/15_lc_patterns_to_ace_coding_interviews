/// ---------------------------------------------------------------------------
/// 模式：深度优先搜索（DFS，Depth-First Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// DFS 沿着图的深度尽可能深入探索。从起始节点开始，访问相邻节点，递归深入，
/// 直到无法继续（死胡同），再回溯到上一个分支点。实现方式：
/// - 递归（系统隐式栈）：代码简洁。
/// - 迭代（显式栈）：避免递归过深导致栈溢出。
///
/// ## 适用场景
/// - 图的遍历与连通分量查找。
/// - 寻找所有路径（回溯也是 DFS 的应用）。
/// - 拓扑排序（DFS 后序遍历的逆序）。
/// - 检测环（三色标记法）。
///
/// ## 时间复杂度
/// - O(V + E)，V = 顶点数，E = 边数。
///
/// ## 空间复杂度
/// - O(V)，递归栈/显式栈深度。

import '../lib/shared.dart';

// ============================================================================
// LeetCode #133: Clone Graph（Medium）
// ============================================================================
// 题目描述：
//   给定无向连通图中的一个节点引用，返回该图的深拷贝。每个节点有 val 和 neighbors。
//
// 解题思路（DFS + HashMap 防止重复克隆）：
//   用 HashMap<原节点, 克隆节点> 追踪已克隆节点，避免重复克隆和死循环。
//   DFS 递归：
//   - 如果节点已在 map 中 → 直接返回克隆节点
//   - 否则：创建新节点，放入 map，递归克隆所有邻居并建立连接
//
// 实现步骤：
//   1. 如果 node == null → 返回 null
//   2. 初始化 map<原节点, 克隆节点>
//   3. 定义 dfs(original)：
//      a. 如果 map.containsKey(original) → return map[original]!
//      b. clone = GraphNode(original.val); map[original] = clone
//      c. 遍历 original.neighbors：clone.neighbors.add(dfs(neighbor))
//      d. return clone
//   4. 返回 dfs(node)

GraphNode? cloneGraph(GraphNode? node) {
  // TODO: 边界检查
  // TODO: 创建 HashMap 映射原节点 → 克隆节点
  // TODO: DFS 递归克隆每个节点和邻居
  // TODO: 返回克隆后的起始节点
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #113: Path Sum II（Medium）
// ============================================================================
// 题目描述：
//   给定二叉树 root 和目标整数 targetSum。找出所有从根到叶子节点路径和等于
//   targetSum 的路径。返回所有路径列表。
//
// 解题思路（DFS + 回溯）：
//   DFS 从根走到叶子，维护当前路径 path 和剩余需要的和。
//   到达叶子时，若剩余和 == 当前节点值，path 为一有效路径。
//   回溯：递归返回后移除 path 最后一个元素。
//
// 实现步骤：
//   1. result = [], path = []
//   2. 定义 dfs(node, remaining)：
//      a. 如果 node == null → return
//      b. path.add(node.val)
//      c. 如果 node 是叶子 且 remaining == node.val → result.add(path 拷贝)
//      d. 递归：dfs(node.left, remaining - node.val)
//               dfs(node.right, remaining - node.val)
//      e. 回溯：path.removeLast()
//   3. dfs(root, targetSum)
//   4. 返回 result

List<List<int>> pathSum(TreeNode? root, int targetSum) {
  // TODO: result = [], path = []
  // TODO: dfs(node, remaining)
  // TODO: 叶子节点检查，回溯撤销
  // TODO: 返回 result
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #210: Course Schedule II（Medium）
// ============================================================================
// 题目描述：
//   共 numCourses 门课（0 到 n-1）。prerequisites[i] = [ai, bi] 表示选修 ai 前
//   必须先修 bi。返回学完所有课程的学习顺序。如果无法完成（有环），返回空数组。
//
// 解题思路（DFS 拓扑排序 + 三色标记法）：
//   - 构建邻接表（先修课 bi → 后续课 ai）
//   - 三色标记：
//     0 = WHITE（未访问）
//     1 = GRAY（访问中 / 在递归栈中）
//     2 = BLACK（已完成）
//   - DFS 时遇到 GRAY → 有环（反向边）
//   - 拓扑序 = DFS 后序遍历的逆序
//
// 实现步骤：
//   1. 构建邻接表 graph：graph[bi] 包含所有以 bi 为先修课的后续课程
//   2. colors = [0]*n, result = []
//   3. 定义 dfs(course) → bool：
//      a. 如果 colors[course] == 1 → return false（有环）
//      b. 如果 colors[course] == 2 → return true（已处理）
//      c. colors[course] = 1
//      d. 遍历 graph[course] 的后续课 next → 如果 !dfs(next) → return false
//      e. colors[course] = 2
//      f. result.add(course)（后序收集）
//      g. return true
//   4. 遍历 0..n-1，调用 dfs → 有环则返回 []
//   5. 返回 result.reversed.toList()

List<int> findOrder(int numCourses, List<List<int>> prerequisites) {
  // TODO: 构建邻接表
  // TODO: 三色标记法 DFS 检测环
  // TODO: 后序遍历收集拓扑序
  // TODO: 反转得到最终顺序
  throw UnimplementedError(); // 请替换为你的实现
}
