/// ---------------------------------------------------------------------------
/// 模式：回溯（Backtracking）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 回溯是一种系统地搜索所有可能解的算法。它通过"试错"的方式构建候选解：
/// - 做选择 → 递归探索 → 撤销选择（回溯）。
/// - 核心在于 3 个关键操作：选择、递归、撤销。
/// - 可以看作是在解空间树上的 DFS，一旦发现当前分支不可能产生有效解，立即回退。
///
/// ## 适用场景
/// - 全排列 / 组合 / 子集问题。
/// - N 皇后问题。
/// - 数独求解器。
/// - 括号生成。
/// - 分割回文串。
/// - 任何需要"尝试所有可能性"然后"撤销"的场景。
///
/// ## 常见剪枝优化
/// - 排序后跳过重复元素。
/// - 限制搜索范围（比如组合中只能选择后面的元素）。
/// - 可行性剪枝（N 皇后中检查攻击范围）。
///
/// ## 时间复杂度
/// - 通常为 O(n!)（排列）或 O(2^n)（子集/组合），具体取决于搜索空间。
///
/// ## 空间复杂度
/// - O(n)，递归栈深度 + 当前路径存储。

// ============================================================================
// LeetCode #46: Permutations
// ============================================================================
// 所属模式：Backtracking（回溯 - 全排列）
// 难度：Medium
// 题目描述：
//   给定一个不含重复数字的数组 nums，返回其所有可能的全排列。可以按任意顺序返回答案。
//
// 核心考点：
//   - 回溯的标准模板：选择 → 递归 → 撤销。
//   - 使用 visited 数组或用交换法标记已选元素。
//   - 排列问题：每次可以从所有未选元素中选择。
//
// 解题思路推导：
//   全排列的回溯树：第一层有 n 个选择，第二层 n-1 个，依此类推。
//   维护一个 path 列表存储当前排列，visited 布尔数组标记已使用的元素。
//   当 path 长度 == nums.length 时，找到一个全排列，加入结果。
//
//   举例：nums = [1,2,3]
//   第 1 层选 1 → path=[1]
//       第 2 层选 2 → path=[1,2]
//           第 3 层选 3 → path=[1,2,3] ✓ 收集
//       第 2 层选 3 → path=[1,3]
//           第 3 层选 2 → path=[1,3,2] ✓ 收集
//   第 1 层选 2 → ...
//
// 实现步骤：
//   1. 初始化 result = [], path = [], visited = [false] * n。
//   2. 定义 backtrack()：
//      a. 如果 path.length == nums.length → result.add(path.copy()), 返回。
//      b. 遍历 i 从 0 到 n-1：
//         - 如果 visited[i] == true，跳过（已选择）。
//         - 做选择：visited[i] = true, path.add(nums[i])。
//         - 递归：backtrack()。
//         - 撤销选择：path.removeLast(), visited[i] = false。
//   3. 调用 backtrack()。
//   4. 返回 result。

List<List<int>> permute(List<int> nums) {
  List<List<int>> result = [];
  List<int> path = [];
  List<bool> visited = List<bool>.filled(nums.length, false);

  void backtrack() {
    // 到达叶子节点：path 长度 == nums 长度，找到一个排列
    if (path.length == nums.length) {
      result.add(List<int>.from(path)); // 拷贝当前路径
      return;
    }

    // 遍历所有未使用的元素
    for (int i = 0; i < nums.length; i++) {
      if (visited[i]) continue; // 已经使用过的跳过

      // 做选择
      visited[i] = true;
      path.add(nums[i]);

      // 递归进入下一层
      backtrack();

      // 撤销选择（回溯）
      path.removeLast();
      visited[i] = false;
    }
  }

  backtrack();
  return result;
}

// ============================================================================
// LeetCode #78: Subsets
// ============================================================================
// 所属模式：Backtracking（回溯 - 子集）
// 难度：Medium
// 题目描述：
//   给定一个不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。
//   解集不能包含重复的子集。
//
// 核心考点：
//   - 子集问题的回溯模板（与排列不同：通过 start 参数限制选择范围）。
//   - 每个节点都是有效解（不限于叶子节点）。
//   - 与排列的区别：子集不需要全选，且顺序不重要。
//
// 解题思路推导：
//   子集问题中，每个元素有"选"和"不选"两种可能。
//   回溯树：从 start 开始，每次选择一个元素（避免重复），start 之后的不选就对应跳过。
//   关键：每个递归节点都将当前路径加入结果（因为任何子集都是有效解）。
//
//   当然也可以使用迭代法（二进制位掩码），但回溯更通用。
//
//   举例：nums = [1,2,3]
//   [] → 选1:[1] → 选2:[1,2] → 选3:[1,2,3]
//                → 选3:[1,3]
//   → 选2:[2] → 选3:[2,3]
//   → 选3:[3]
//   结果：[[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]]
//
// 实现步骤：
//   1. 初始化 result = [], path = []。
//   2. 定义 backtrack(start)：
//      a. result.add(List.from(path))（⚠ 每个节点都是有效子集，直接收集）。
//      b. 遍历 i 从 start 到 n-1：
//         - 做选择：path.add(nums[i])。
//         - 递归：backtrack(i + 1)（从 i+1 开始，避免重复和逆序）。
//         - 撤销选择：path.removeLast()。
//   3. 调用 backtrack(0)。
//   4. 返回 result。

List<List<int>> subsets(List<int> nums) {
  List<List<int>> result = [];
  List<int> path = [];

  void backtrack(int start) {
    // 每个节点都代表一个有效子集，直接收集
    result.add(List<int>.from(path));

    // 从 start 开始遍历，保证不重复、不逆序
    for (int i = start; i < nums.length; i++) {
      // 做选择
      path.add(nums[i]);

      // 递归（从 i+1 开始，不能重复选择）
      backtrack(i + 1);

      // 撤销选择（回溯）
      path.removeLast();
    }
  }

  backtrack(0);
  return result;
}

// ============================================================================
// LeetCode #51: N-Queens
// ============================================================================
// 所属模式：Backtracking（回溯 - N 皇后剪枝优化）
// 难度：Hard
// 题目描述：
//   按照国际象棋的规则，皇后可以攻击与之处在同一行或同一列或同一斜线上的棋子。
//   n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能
//   相互攻击。给定整数 n，返回所有不同的 n 皇后问题的解决方案。
//   每一种解法包含一个不同的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.'
//   分别代表了皇后和空位。
//
// 核心考点：
//   - 回溯 + 剪枝优化。
//   - 对角线冲突判断：row - col 标识「主对角线」，row + col 标识「副对角线」。
//   - 按行放置皇后，每行只有一个选择。
//   - 使用集合快速判断列/对角线是否已被占用。
//
// 解题思路推导：
//   逐行放置皇后（因为每行只能放一个）。
//   对于第 row 行，尝试每一列 col 是否可以放置：
//   - 列 col 是否已被占用？
//   - 主对角线（左上→右下，行-列为常数）是否已被占用？
//   - 副对角线（右上→左下，行+列为常数）是否已被占用？
//   如果都不冲突，放置皇后，递归处理下一行。
//   放置完所有 n 行后，收集一个有效方案。
//
//   举例：n = 4，一种解：
//   . Q . .
//   . . . Q
//   Q . . .
//   . . Q .
//
// 实现步骤：
//   1. 初始化 result = [], board = ['.' * n 的 n 行]。
//   2. 初始化三个 Set：cols, diag1, diag2。
//   3. 定义 backtrack(row)：
//      a. 如果 row == n → 将当前棋盘拷贝入 result，返回。
//      b. 遍历 col 从 0 到 n-1：
//         - 如果 col 在 cols 中，或 row-col 在 diag1 中，或 row+col 在 diag2 中
//           → 冲突，跳过。
//         - 放置皇后：board[row][col] = 'Q'，更新三个 Set。
//         - 递归：backtrack(row + 1)。
//         - 撤销：board[row][col] = '.'，从三个 Set 中移除。
//   4. 调用 backtrack(0)。
//   5. 返回 result。

List<List<String>> solveNQueens(int n) {
  List<List<String>> result = [];
  // 初始棋盘：每行都是 n 个 '.'
  List<String> board = List<String>.generate(n, (_) => '.' * n);

  // 记录被占用的列、主对角线、副对角线
  Set<int> cols = {};
  Set<int> diag1 = {}; // 主对角线：row - col
  Set<int> diag2 = {}; // 副对角线：row + col

  // 将棋盘的一行第 col 列替换为 Q
  String setQueen(String rowStr, int col) {
    List<String> chars = rowStr.split('');
    chars[col] = 'Q';
    return chars.join('');
  }

  // 将棋盘的一行第 col 列恢复为 .
  String removeQueen(String rowStr, int col) {
    List<String> chars = rowStr.split('');
    chars[col] = '.';
    return chars.join('');
  }

  void backtrack(int row) {
    // 所有行都放好了皇后，收集解
    if (row == n) {
      result.add(List<String>.from(board));
      return;
    }

    for (int col = 0; col < n; col++) {
      // 冲突检查
      if (cols.contains(col)) continue;
      if (diag1.contains(row - col)) continue; // 主对角线冲突
      if (diag2.contains(row + col)) continue; // 副对角线冲突

      // 做选择：放置皇后
      board[row] = setQueen(board[row], col);
      cols.add(col);
      diag1.add(row - col);
      diag2.add(row + col);

      // 递归处理下一行
      backtrack(row + 1);

      // 撤销选择（回溯）
      board[row] = removeQueen(board[row], col);
      cols.remove(col);
      diag1.remove(row - col);
      diag2.remove(row + col);
    }
  }

  backtrack(0);
  return result;
}
