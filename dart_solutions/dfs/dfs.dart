/// ---------------------------------------------------------------------------
/// 模式：深度优先搜索（DFS，Depth-First Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// DFS 是一种沿着图的深度尽可能深入探索的算法。从起始节点开始，访问某个相邻节点，
/// 然后递归地深入，直到无法继续（死胡同），再回溯到上一个分支点继续探索。
/// 实现方式：
/// - 递归（系统隐式栈）：代码简洁。
/// - 迭代（显式栈）：避免递归深度过大导致的栈溢出。
///
/// ## 适用场景
/// - 图的遍历与连通分量查找。
/// - 寻找所有路径（回溯问题也属于 DFS 的应用）。
/// - 拓扑排序（DFS 后序遍历的逆序）。
/// - 树的深度相关问题。
/// - 检测环。
///
/// ## 时间复杂度
/// - O(V + E)，V 为顶点数，E 为边数。
///
/// ## 空间复杂度
/// - O(V)，递归栈或显式栈的深度。

class Node {
  int val;
  List<Node> neighbors;
  Node(this.val, [List<Node>? neighbors]) : neighbors = neighbors ?? [];
}

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// ============================================================================
// LeetCode #133: Clone Graph
// ============================================================================
// 所属模式：DFS（深度优先搜索 - 图的深拷贝）
// 难度：Medium
// 题目描述：
//   给定一个无向连通图中的一个节点的引用，返回该图的深拷贝。
//   图中的每个节点都包含它的值 val（int）和其邻居的列表（List[Node]）。
//
// 核心考点：
//   - DFS 遍历图。
//   - 用 HashMap 存储"原节点 → 克隆节点"的映射，避免重复克隆。
//   - 图的深拷贝（处理循环引用）。
//
// 解题思路推导：
//   图的深拷贝关键：每个节点只能被创建一次，但因图中可能存在环，
//   需要记录哪些节点已经被访问/克隆过。使用 HashMap 追踪。
//
//   DFS 递归思路：
//   - 如果当前节点已在 map 中，直接返回其克隆节点（处理重复访问/环）。
//   - 否则：创建新节点，放入 map。
//   - 遍历当前节点的所有邻居，递归克隆每个邻居，并建立连接。
//
// 实现步骤：
//   1. 如果 node 为 null，返回 null。
//   2. 初始化 map = {}（原节点 → 克隆节点）。
//   3. 定义递归函数 dfs(node) → Node?：
//      a. 如果 map.containsKey(node)，返回 map[node]（已克隆）。
//      b. 创建 clone = Node(node.val)。
//      c. map[node] = clone（先放入 map 再递归，防止死循环）。
//      d. 对于 node.neighbors 中的每个邻居 neighbor：
//         - clone.neighbors.add(dfs(neighbor))。
//      e. 返回 clone。
//   4. 调用 dfs(node)，返回结果。

Node? cloneGraph(Node? node) {
  if (node == null) return null;

  // 映射：原节点 → 克隆节点
  final Map<Node, Node> map = {};

  Node dfs(Node original) {
    // 如果该节点已经被克隆，直接返回其克隆
    if (map.containsKey(original)) {
      return map[original]!;
    }

    // 创建新节点（先放入 map 再处理邻居，防止无限递归）
    Node clone = Node(original.val);
    map[original] = clone;

    // 递归克隆每个邻居并建立连接
    for (Node neighbor in original.neighbors) {
      clone.neighbors.add(dfs(neighbor));
    }

    return clone;
  }

  return dfs(node);
}

// ============================================================================
// LeetCode #113: Path Sum II
// ============================================================================
// 所属模式：DFS（深度优先搜索 - 根到叶子的路径和）
// 难度：Medium
// 题目描述：
//   给定一个二叉树的根节点 root 和一个整数 targetSum，找出所有从根节点到叶子节点
//   路径总和等于 targetSum 的路径。
//   叶子节点是指没有子节点的节点。
//
// 核心考点：
//   - DFS 遍历二叉树。
//   - 路径回溯（path 的添加与撤销）。
//   - 到达叶子节点时判断路径和。
//
// 解题思路推导：
//   使用 DFS 从根节点一直走到叶子节点，沿途维护当前路径 path 和剩余需要的和。
//   到达叶子节点时，如果当前节点的值 == 剩余的 targetSum，则 path 是一条有效路径。
//   注意：需要回溯，即递归返回后将刚加入路径的节点移除。
//
// 实现步骤：
//   1. 初始化 result = [], path = []。
//   2. 定义递归函数 dfs(node, remaining)：
//      a. 如果 node 为 null，返回。
//      b. 将 node.val 加入 path。
//      c. 如果 node 是叶子节点（无左右子树）且 remaining == node.val：
//         - 将 path 的拷贝加入 result。
//      d. 递归处理左子树：dfs(node.left, remaining - node.val)。
//      e. 递归处理右子树：dfs(node.right, remaining - node.val)。
//      f. 回溯：从 path 中移除最后一个元素（node.val）。
//   3. 调用 dfs(root, targetSum)。
//   4. 返回 result。

List<List<int>> pathSum(TreeNode? root, int targetSum) {
  List<List<int>> result = [];
  List<int> path = [];

  void dfs(TreeNode? node, int remaining) {
    if (node == null) return;

    // 将当前节点加入路径
    path.add(node.val);

    // 如果是叶子节点且剩余和等于当前节点的值，找到一条有效路径
    if (node.left == null && node.right == null && remaining == node.val) {
      result.add(List<int>.from(path)); // 拷贝当前路径到结果
    } else {
      // 非叶子节点，继续 DFS
      dfs(node.left, remaining - node.val);
      dfs(node.right, remaining - node.val);
    }

    // 回溯：撤销当前节点的选择
    path.removeLast();
  }

  dfs(root, targetSum);
  return result;
}

// ============================================================================
// LeetCode #210: Course Schedule II
// ============================================================================
// 所属模式：DFS（深度优先搜索 - 拓扑排序）
// 难度：Medium
// 题目描述：
//   现在你总共有 numCourses 门课需要选修，记为 0 到 numCourses - 1。
//   给定一个二维数组 prerequisites，其中 prerequisites[i] = [ai, bi] 表示
//   在选修课程 ai 之前必须先选修 bi。返回你为了学完所有课程所安排的学习顺序。
//   如果无法完成所有课程（存在环），返回一个空数组。
//
// 核心考点：
//   - DFS 检测有向图环。
//   - 拓扑排序 = DFS 后序遍历的逆序。
//   - 三色标记法：0=未访问, 1=访问中, 2=已完成。
//
// 解题思路推导：
//   课程依赖关系构成有向图：先修课程 bi → 后续课程 ai。
//   问题本质：图是否有拓扑排序（是否有环）。
//
//   DFS 三色标记法检测环：
//   - WHITE (0)：节点未被访问。
//   - GRAY (1)：节点正在被访问（在递归栈中）。
//   - BLACK (2)：节点已完成访问（所有邻居已处理）。
//   如果在 DFS 过程中遇到 GRAY 节点，说明存在环（反向边）。
//
//   拓扑排序：在 DFS 后序遍历时收集节点，最后反转得到拓扑序。
//
// 实现步骤：
//   1. 构建邻接表 graph：graph[bi] = [所有以 bi 为先修课的后续课程]。
//   2. 初始化 colors = [0] * n, result = []。
//   3. 定义 dfs(course) → bool（是否无环）：
//      a. 如果 colors[course] == 1（GRAY），存在环，返回 false。
//      b. 如果 colors[course] == 2（BLACK），已处理，返回 true。
//      c. colors[course] = 1（标记为访问中）。
//      d. 遍历 graph[course] 的所有后续课程 next：
//         - 如果 !dfs(next)，返回 false。
//      e. colors[course] = 2（标记为已完成）。
//      f. result.add(course)（后序收集）。
//      g. 返回 true。
//   4. 遍历 0 到 n-1 的每门课，如果 !dfs(i)，返回 []。
//   5. 反转 result（后序的逆 = 拓扑序），返回 result。

List<int> findOrder(int numCourses, List<List<int>> prerequisites) {
  // 构建邻接表：先修课 → 后续课
  List<List<int>> graph = List.generate(numCourses, (_) => []);
  for (List<int> prereq in prerequisites) {
    int ai = prereq[0]; // 后续课
    int bi = prereq[1]; // 先修课
    graph[bi].add(ai); // bi → ai
  }

  // 三色标记：0 = WHITE（未访问）, 1 = GRAY（访问中）, 2 = BLACK（已完成）
  List<int> colors = List<int>.filled(numCourses, 0);
  List<int> result = [];

  // DFS 返回 false 表示检测到环
  bool dfs(int course) {
    if (colors[course] == 1) return false; // 遇到访问中的节点 → 存在环
    if (colors[course] == 2) return true; // 已完成访问，无需重复处理

    colors[course] = 1; // 标记为访问中

    // 遍历所有后继课程
    for (int next in graph[course]) {
      if (!dfs(next)) return false; // 子图有环，向上传播失败
    }

    colors[course] = 2; // 标记为已完成
    result.add(course); // 后序遍历收集（逆拓扑序）
    return true;
  }

  // 对每门课进行 DFS
  for (int i = 0; i < numCourses; i++) {
    if (!dfs(i)) return []; // 存在环，无法完成
  }

  // 后序遍历的逆序 = 拓扑排序
  return result.reversed.toList();
}
