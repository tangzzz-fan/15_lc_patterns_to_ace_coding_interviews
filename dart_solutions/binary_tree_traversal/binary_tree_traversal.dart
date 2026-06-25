/// ---------------------------------------------------------------------------
/// 模式：二叉树遍历（Binary Tree Traversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 二叉树有三种基本遍历顺序：
/// - **前序遍历（Preorder）**：根 → 左子树 → 右子树。适用于"自顶向下"传递信息。
/// - **中序遍历（Inorder）**：左子树 → 根 → 右子树。BST 的中序遍历产生有序序列。
/// - **后序遍历（Postorder）**：左子树 → 右子树 → 根。适用于"自底向上"收集信息。
///
/// 每种遍历都有递归和迭代两种实现方式。递归代码简洁，迭代需要手动模拟调用栈。
///
/// ## 适用场景
/// - 前序：路径问题（根到叶子）、树的序列化。
/// - 中序：BST 的排序输出、第 K 小元素。
/// - 后序：需要子节点信息后再处理父节点（最大路径和、树的高度）。
///
/// ## 时间复杂度
/// - O(n)，每个节点访问一次。
///
/// ## 空间复杂度
/// - 递归：O(h)（递归栈深度，h 为树高），最坏 O(n)。
/// - 迭代：O(n)，需要显式栈。

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// ============================================================================
// LeetCode #257: Binary Tree Paths（前序遍历）
// ============================================================================
// 所属模式：Binary Tree Traversal（前序遍历 - 根到叶子的路径）
// 难度：Easy
// 题目描述：
//   给定一个二叉树的根节点 root，按任意顺序返回所有从根节点到叶子节点的路径。
//
// 核心考点：
//   - 前序遍历（根→左→右）传递路径信息。
//   - 递归回溯：到达叶子时收集路径。
//   - 字符串拼接路径。
//
// 解题思路推导：
//   前序遍历天然适合"根到叶子"的路径问题，因为先访问根。
//   递归过程中维护当前路径字符串 path。
//   当到达叶子节点（左右子树都为空），将 path 加入结果集。
//   若非叶节点，递归处理子树前拼接 "->"。
//
// 实现步骤：
//   1. 初始化 result = []。
//   2. 定义递归函数 dfs(node, path)：
//      a. 如果 node 为 null，返回。
//      b. 构造新路径：如果 path 为空，newPath = node.val.toString()；
//         否则 newPath = "$path->${node.val}"。
//      c. 如果 node 是叶子节点（无左右子树）：
//         - result.add(newPath)，返回。
//      d. 否则：
//         - dfs(node.left, newPath)。
//         - dfs(node.right, newPath)。
//   3. 调用 dfs(root, "")。
//   4. 返回 result。

List<String> binaryTreePaths(TreeNode? root) {
  List<String> result = [];

  void dfs(TreeNode? node, String path) {
    if (node == null) return;

    // 构造从根到当前节点的路径字符串
    String newPath = path.isEmpty
        ? node.val.toString()
        : '$path->${node.val}';

    // 如果是叶子节点，收集路径
    if (node.left == null && node.right == null) {
      result.add(newPath);
      return;
    }

    // 非叶节点，继续递归遍历左右子树
    dfs(node.left, newPath);
    dfs(node.right, newPath);
  }

  dfs(root, ''); // 从根节点开始
  return result;
}

// ============================================================================
// LeetCode #230: Kth Smallest Element in a BST（中序遍历）
// ============================================================================
// 所属模式：Binary Tree Traversal（中序遍历 - BST 的第 K 小元素）
// 难度：Medium
// 题目描述：
//   给定一个二叉搜索树的根节点 root 和一个整数 k，请找出 BST 中第 k 小的元素。
//
// 核心考点：
//   - BST 的中序遍历产生升序序列。
//   - 遍历到第 k 个节点时停止（提前终止优化）。
//   - 迭代中序遍历 vs 递归中序遍历。
//
// 解题思路推导：
//   BST 的性质：左子树 < 根 < 右子树。
//   因此中序遍历（左→根→右）得到的是严格升序序列。
//   遍历到第 k 个节点时返回该节点的值。
//
//   迭代法中序遍历可以方便地在找到第 k 个后退出，避免遍历整棵树。
//
// 实现步骤：
//   1. 初始化 stack = [], count = 0, curr = root。
//   2. while stack 非空 或 curr != null：
//      a. 不断将 left 节点入栈（while curr != null：stack.add(curr), curr = curr.left）。
//      b. 弹出栈顶 node = stack.removeLast()。
//      c. count++。
//      d. 如果 count == k，返回 node.val。
//      e. curr = node.right（遍历右子树）。
//   3. 返回 -1（不会走到这里，题目保证 k 有效）。

int kthSmallest(TreeNode? root, int k) {
  List<TreeNode> stack = [];
  TreeNode? curr = root;
  int count = 0;

  // 迭代式中序遍历
  while (stack.isNotEmpty || curr != null) {
    // 一路向左，将所有左子节点入栈
    while (curr != null) {
      stack.add(curr);
      curr = curr.left; // 转到左子树
    }

    // 弹出栈顶（当前最小的未访问节点）
    TreeNode node = stack.removeLast();
    count++;

    if (count == k) {
      return node.val; // 找到第 k 小元素
    }

    // 转向右子树
    curr = node.right;
  }

  return -1; // 不会到这里（k 一定有效）
}

// ============================================================================
// LeetCode #124: Binary Tree Maximum Path Sum（后序遍历）
// ============================================================================
// 所属模式：Binary Tree Traversal（后序遍历 - 最大路径和）
// 难度：Hard
// 题目描述：
//   二叉树中的路径被定义为一条节点序列，序列中每对相邻节点之间都存在一条边。
//   同一个节点在一条路径序列中至多出现一次。该路径至少包含一个节点，且不一定经过根节点。
//   路径和是路径中各节点值的总和。给定一个二叉树的根节点 root，返回其最大路径和。
//
// 核心考点：
//   - 后序遍历：先获取子节点信息，再决定父节点的路径选择。
//   - 关键决策：每个节点可以选择"只连一个子树"或"作为路径的中心"。
//   - 负数处理：如果子树路径和为负，不选它（取 0）。
//
// 解题思路推导：
//   对于每个节点，考虑两种路径：
//   - "单边路径"（向上贡献）：node.val + max(leftMax, rightMax, 0)。
//     这是它可以提供给父节点的最大路径和。
//   - "经过该节点的完整路径"（全局最优候选）：
//     node.val + max(0, leftMax) + max(0, rightMax)。
//     这个值不能向上传递，因为它包括了左右两边。
//
//   在递归过程中，返回"单边路径"给父节点，同时用"完整路径"更新全局最大值。
//
//   举例：[-10,9,20,null,null,15,7]
//   叶子 9: 单边=9, 全局候选=9
//   叶子 15: 单边=15, 全局候选=15
//   叶子 7: 单边=7, 全局候选=7
//   节点 20: 单边=20+max(15,7)=35, 完整路径=20+15+7=42
//   节点 -10: 单边=-10+max(35,9)=25, 完整路径=-10+35+9=34
//   全局最大 = 42
//
// 实现步骤：
//   1. 初始化全局变量 maxSum = 负无穷。
//   2. 定义递归函数 dfs(node) → int（返回单边最大路径和）：
//      a. 如果 node 为 null，返回 0。
//      b. leftMax = max(dfs(node.left), 0)（负的子树不选）。
//      c. rightMax = max(dfs(node.right), 0)。
//      d. 计算经过该节点的完整路径和：node.val + leftMax + rightMax。
//      e. 更新全局 maxSum = max(maxSum, 完整路径和)。
//      f. 返回 node.val + max(leftMax, rightMax)（只能选一边向上贡献）。
//   3. 调用 dfs(root)。
//   4. 返回 maxSum。

int maxPathSum(TreeNode? root) {
  int maxSum = -1 << 63; // 初始化为最小整数值

  // 返回从该节点出发的单边最大路径和（能够向上贡献的部分）
  int dfs(TreeNode? node) {
    if (node == null) return 0;

    // 递归获取左右子树的最大贡献，负数则不选（取 0）
    int leftMax = dfs(node.left);
    if (leftMax < 0) leftMax = 0; // max(0, leftMax)
    int rightMax = dfs(node.right);
    if (rightMax < 0) rightMax = 0; // max(0, rightMax)

    // 以当前节点为"中心"的完整路径和（全局候选）
    int fullPath = node.val + leftMax + rightMax;
    if (fullPath > maxSum) {
      maxSum = fullPath; // 更新全局最大值
    }

    // 返回单边最大路径和（向上贡献给父节点）
    return node.val + (leftMax > rightMax ? leftMax : rightMax); // val + max(left, right)
  }

  dfs(root);
  return maxSum;
}
