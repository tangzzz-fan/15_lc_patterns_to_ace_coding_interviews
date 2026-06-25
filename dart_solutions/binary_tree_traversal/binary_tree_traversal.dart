/// ---------------------------------------------------------------------------
/// 模式：二叉树遍历（Binary Tree Traversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 二叉树有三种基本遍历顺序，每种遍历决定"何时处理当前节点"：
/// - **前序遍历**（Preorder）：根 → 左子树 → 右子树。适合"自顶向下"传递信息。
/// - **中序遍历**（Inorder）：左子树 → 根 → 右子树。BST 的中序遍历产生有序序列。
/// - **后序遍历**（Postorder）：左子树 → 右子树 → 根。适合"自底向上"收集信息。
///
/// ## 适用场景
/// - 前序：根到叶子的路径问题、树的序列化。
/// - 中序：BST 的排序输出、第 K 小元素。
/// - 后序：需要子节点信息后再决定父节点（最大路径和、树的高度）。
///
/// ## 时间复杂度
/// - O(n)，每个节点访问一次。
///
/// ## 空间复杂度
/// - 递归：O(h) 递归栈深度；迭代：O(n) 显式栈。

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// ============================================================================
// LeetCode #257: Binary Tree Paths（Easy - 前序遍历）
// ============================================================================
// 题目描述：
//   给定二叉树的根节点 root，返回所有从根节点到叶子节点的路径。
//
// 解题思路（前序遍历 + 回溯）：
//   前序遍历天然适合"根到叶子"路径：先访问根，再递归左右子树。
//   维护当前路径字符串 path。
//   到达叶子节点（左右都为空）时，将 path 加入结果。
//   非叶子节点：递归前拼接 "->"。
//
// 实现步骤：
//   1. 初始化 result = []
//   2. 定义 dfs(node, path)：
//      a. 如果 node == null → 返回
//      b. 构造 newPath：
//         - 如果 path 为空 → '${node.val}'
//         - 否则 → '$path->${node.val}'
//      c. 如果 node 是叶子节点 → result.add(newPath); return
//      d. 递归：dfs(node.left, newPath); dfs(node.right, newPath)
//   3. dfs(root, '')
//   4. 返回 result

List<String> binaryTreePaths(TreeNode? root) {
  // TODO: result = []
  // TODO: 定义 dfs(node, path)
  // TODO: 叶子节点时收集路径，非叶子继续递归
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #230: Kth Smallest Element in a BST（Medium - 中序遍历）
// ============================================================================
// 题目描述：
//   给定 BST 的根节点 root 和整数 k，找出 BST 中第 k 小的元素。
//
// 解题思路（中序遍历 = 升序序列）：
//   BST 中序遍历（左 → 根 → 右）产生严格升序序列。
//   用迭代法中序遍历，遍历到第 k 个节点时直接返回，不需要遍历完整棵树。
//
// 实现步骤：
//   1. 初始化 stack = [], count = 0, curr = root
//   2. while stack 非空 || curr != null：
//      a. while curr != null → stack.add(curr); curr = curr.left
//      b. node = stack.removeLast(); count++
//      c. 如果 count == k → 返回 node.val
//      d. curr = node.right
//   3. 返回 -1（不会走到这里）

int kthSmallest(TreeNode? root, int k) {
  // TODO: 迭代法中序遍历（stack）
  // TODO: 遍历到第 k 个节点时直接返回
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #124: Binary Tree Maximum Path Sum（Hard - 后序遍历）
// ============================================================================
// 题目描述：
//   二叉树中的路径和是路径中各节点值的总和。路径至少包含一个节点，不一定经过根。
//   返回最大路径和。
//
// 解题思路（后序遍历 + 全局最大值）：
//   每个节点考虑两种路径：
//   - "单边路径"（向上贡献）：node.val + max(leftMax, rightMax, 0)
//   - "完整路径"（以该节点为桥，同时连左右）：node.val + max(0,leftMax) + max(0,rightMax)
//   递归返回"单边路径"给父节点，同时用"完整路径"更新全局最大值。
//   如果子树贡献为负，则不选（取 0）。
//
// 实现步骤：
//   1. 全局变量 maxSum = 最小整数值
//   2. 定义 dfs(node) → int（返回单边最大路径和）：
//      a. 如果 node == null → 返回 0
//      b. leftMax = max(dfs(node.left), 0)
//      c. rightMax = max(dfs(node.right), 0)
//      d. fullPath = node.val + leftMax + rightMax
//      e. 更新 maxSum = max(maxSum, fullPath)
//      f. 返回 node.val + max(leftMax, rightMax)
//   3. dfs(root)
//   4. 返回 maxSum

int maxPathSum(TreeNode? root) {
  // TODO: maxSum = 最小整数值
  // TODO: dfs(node) → 返回单边最大路径和
  // TODO: 递归中更新全局 maxSum（完整路径）
  // TODO: 返回 maxSum
  throw UnimplementedError(); // 请替换为你的实现
}
