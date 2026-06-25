/// ---------------------------------------------------------------------------
/// 模式：回溯（Backtracking）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 回溯是一种系统地搜索所有可能解的算法。通过"试错"方式构建候选解：
/// - 做选择 → 递归探索 → 撤销选择（回溯）
/// - 三个关键操作：**选择、递归、撤销**
/// - 本质上是在解空间树上做 DFS，一旦发现当前分支不可能产生有效解，立即回退。
///
/// ## 适用场景
/// - 全排列 / 组合 / 子集问题。
/// - N 皇后问题。
/// - 数独求解器。
/// - 括号生成。
/// - 分割回文串。
/// - 任何需要"尝试所有可能性"后"撤销"的场景。
///
/// ## 常见剪枝优化
/// - 排序后跳过重复元素。
/// - start 参数限制选择范围（组合问题的关键）。
/// - 可行性剪枝（N 皇后中检查攻击范围）。
///
/// ## 时间复杂度
/// - 通常 O(n!)（排列）或 O(2^n)（子集/组合）。
///
/// ## 空间复杂度
/// - O(n)，递归栈深度 + path 存储。

// ============================================================================
// LeetCode #46: Permutations（Medium）
// ============================================================================
// 题目描述：
//   给定不含重复数字的数组 nums，返回其所有可能的全排列。
//
// 解题思路（回溯标准模板）：
//   维护 path（当前排列）和 visited（标记已用元素）。
//   当 path 长度 == nums 长度 → 找到一个排列。
//   每次从未使用的元素中选择一个，递归，撤销。
//
// 实现步骤：
//   1. result = [], path = [], visited = [false] * n
//   2. 定义 backtrack()：
//      a. 如果 path.length == nums.length：
//         result.add(List.from(path)); return
//      b. 遍历 i 从 0 到 n-1：
//         - 如果 visited[i] → continue（跳过已使用的）
//         - visited[i] = true; path.add(nums[i])
//         - backtrack()
//         - path.removeLast(); visited[i] = false（回溯）
//   3. backtrack()
//   4. 返回 result

List<List<int>> permute(List<int> nums) {
  // TODO: result = [], path = [], visited = [false]*n
  // TODO: backtrack():
  //       - 收集条件：path.length == nums.length
  //       - 遍历可用元素
  //       - 选择→递归→撤销
  // TODO: 返回 result
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #78: Subsets（Medium）
// ============================================================================
// 题目描述：
//   给定不含重复元素的整数数组 nums，返回所有可能的子集（幂集）。
//
// 解题思路（回溯 + start 参数限制选择范围）：
//   与排列不同：子集不需要全选，且顺序不重要（[1,2] 和 [2,1] 是同一个子集）。
//   用 start 参数保证只选择当前元素及其后面的元素，避免重复。
//   关键：每个递归节点都是有效子集，直接收集（不限于叶子节点）。
//
// 实现步骤：
//   1. result = [], path = []
//   2. 定义 backtrack(start)：
//      a. result.add(List.from(path))（⚠ 每个节点都是有效子集）
//      b. 遍历 i 从 start 到 n-1：
//         - path.add(nums[i])
//         - backtrack(i + 1)（从 i+1 开始，不能重复选）
//         - path.removeLast()（回溯）
//   3. backtrack(0)
//   4. 返回 result

List<List<int>> subsets(List<int> nums) {
  // TODO: result = [], path = []
  // TODO: backtrack(start):
  //       - 直接收集当前 path 为有效子集
  //       - 从 start 开始遍历，选→递归(i+1)→撤销
  // TODO: 返回 result
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #51: N-Queens（Hard）
// ============================================================================
// 题目描述：
//   将 n 个皇后放在 n×n 棋盘上，使皇后之间不能互相攻击（同行、同列、同对角线）。
//   返回所有不同的放置方案。方案中 'Q' 代表皇后，'.' 代表空位。
//
// 解题思路（回溯 + 集合剪枝）：
//   逐行放置皇后（每行只能放一个）。
//   用三个 Set 快速判断列/对角线是否冲突：
//   - cols：已被占用的列
//   - diag1：主对角线（左上→右下），特征：row - col 为常数
//   - diag2：副对角线（右上→左下），特征：row + col 为常数
//
// 实现步骤：
//   1. result = [], board = ['....', '....', ...]（n 行都是 n 个 '.'）
//   2. cols={}, diag1={}, diag2={}（三个剪枝集合）
//   3. 定义 backtrack(row)：
//      a. 如果 row == n → result.add(board 拷贝); return
//      b. 遍历 col 从 0 到 n-1：
//         - 冲突检查：cols.has(col) || diag1.has(row-col) || diag2.has(row+col)
//         - 放置皇后：更新 board[row]，三个 Set add
//         - backtrack(row + 1)
//         - 撤销：恢复 board[row]，三个 Set remove
//   4. backtrack(0)
//   5. 返回 result

List<List<String>> solveNQueens(int n) {
  // TODO: 初始化棋盘（n 行全是 '.' 的字符串）
  // TODO: 三个 Set 用于列/对角线冲突检测
  // TODO: backtrack(row)：逐行放置皇后
  // TODO: 返回所有解
  throw UnimplementedError(); // 请替换为你的实现
}
