/// ---------------------------------------------------------------------------
/// 模式：动态规划（Dynamic Programming，DP）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 动态规划将问题分解为重叠子问题，通过记忆化（Memoization）或制表（Tabulation）
/// 避免重复计算。两大要素：
/// 1. **最优子结构**：问题的最优解包含子问题的最优解。
/// 2. **重叠子问题**：同一子问题被反复计算。
///
/// DP 解题五步法：
/// 1. 定义 dp 数组/函数的含义。
/// 2. 推导状态转移方程（递推公式）。
/// 3. 确定 base case（初始条件）。
/// 4. 确定遍历顺序。
/// 5. 写出代码（或进一步空间优化）。
///
/// ## 常用子模式
/// - **Fibonacci Numbers**：dp[i] = dp[i-1] + dp[i-2]
/// - **0/1 Knapsack**：物品选或不选；倒序遍历防止重复使用
/// - **完全背包**：物品可无限选；正序遍历
/// - **LCS**：dp[i][j] = text1[i]==text2[j] ? 1+dp[i-1][j-1] : max(dp[i-1][j], dp[i][j-1])
/// - **LIS**：dp[i] = 1 + max(dp[j]) for all j < i and nums[j] < nums[i]
/// - **Subset Sum**：dp[i] = dp[i] || dp[i-num]（0/1 背包变体）
///
/// ## 时间复杂度
/// - O(n)、O(n²)、O(n×m)，取决于状态数和每个状态的计算量。
///
/// ## 空间复杂度
/// - O(n) 或 O(n×m)，可通过滚动数组优化。

// ============================================================================
// LeetCode #70: Climbing Stairs（Easy - Fibonacci 子模式）
// ============================================================================
// 题目描述：
//   爬 n 阶楼梯，每次可爬 1 或 2 阶。有多少种不同的方法爬到楼顶？
//
// 解题思路：
//   到达第 i 阶 = 从 i-1 走 1 步 + 从 i-2 走 2 步
//   dp[i] = dp[i-1] + dp[i-2]（Fibonacci 数列）
//   base case：dp[1]=1, dp[2]=2
//   空间优化：只用两个变量滚动（prev2, prev1）
//
// 实现步骤：
//   1. 如果 n <= 2 → 返回 n
//   2. prev2 = 1（dp[1]）, prev1 = 2（dp[2]）
//   3. 循环 i 从 3 到 n：
//      current = prev1 + prev2
//      prev2 = prev1; prev1 = current
//   4. 返回 prev1

int climbStairs(int n) {
  // TODO: n <= 2 时直接返回 n
  // TODO: 滚动变量 prev2, prev1
  // TODO: 循环计算 dp[i] = dp[i-1] + dp[i-2]
  // TODO: 返回 prev1
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #198: House Robber（Medium）
// ============================================================================
// 题目描述：
//   盗窃沿街房屋，相邻房屋有防盗系统不能同时闯入。nums[i] 代表每个房屋的金额。
//   返回一夜之内能偷窃到的最高金额。
//
// 解题思路（一维 DP）：
//   对于第 i 间房：
//   - 不偷：最高金额 = dp[i-1]
//   - 偷：最高金额 = dp[i-2] + nums[i]
//   dp[i] = max(dp[i-1], dp[i-2] + nums[i])
//
// 实现步骤：
//   1. 如果 nums 为空 → 返回 0；长度为 1 → 返回 nums[0]
//   2. prev2 = nums[0]（dp[0]）
//   3. prev1 = max(nums[0], nums[1])（dp[1]）
//   4. 循环 i 从 2 到 n-1：
//      current = max(prev1, prev2 + nums[i])
//      prev2 = prev1; prev1 = current
//   5. 返回 prev1

int rob(List<int> nums) {
  // TODO: 边界检查（空/单元素）
  // TODO: prev2 = dp[0], prev1 = dp[1]
  // TODO: 循环计算 dp[i] = max(dp[i-1], dp[i-2]+nums[i])
  // TODO: 返回 prev1
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #322: Coin Change（Medium - 完全背包）
// ============================================================================
// 题目描述：
//   给定不同面额硬币 coins 和总金额 amount。计算凑成 amount 所需的最少硬币数。
//   每种硬币无限使用。若无法凑成，返回 -1。
//
// 解题思路（完全背包）：
//   dp[i] = 凑成金额 i 所需的最少硬币数
//   对于每个金额 i，尝试每种硬币 coin：
//   dp[i] = min(dp[i], dp[i - coin] + 1)
//   正序遍历金额（因为硬币可重复使用）
//
// 实现步骤：
//   1. dp = [amount+1] * (amount+1)（初始化为极大值）
//   2. dp[0] = 0（base case）
//   3. 遍历 i 从 1 到 amount：
//      遍历每种硬币 coin：
//        如果 i >= coin：dp[i] = min(dp[i], dp[i-coin] + 1)
//   4. 返回 dp[amount] > amount ? -1 : dp[amount]

int coinChange(List<int> coins, int amount) {
  // TODO: 初始化 dp 数组（长度 amount+1，填充极大值）
  // TODO: dp[0] = 0
  // TODO: 双重循环（外层金额正序，内层硬币）
  // TODO: 返回 dp[amount] 或 -1
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #1143: Longest Common Subsequence（Medium - LCS）
// ============================================================================
// 题目描述：
//   给定 text1 和 text2，返回它们的最长公共子序列的长度。
//   子序列可以不连续，但顺序必须保持。
//
// 解题思路（二维 DP）：
//   dp[i][j] = text1[0..i-1] 与 text2[0..j-1] 的 LCS 长度
//   - 如果 text1[i-1] == text2[j-1]：dp[i][j] = dp[i-1][j-1] + 1
//   - 否则：dp[i][j] = max(dp[i-1][j], dp[i][j-1])
//
// 实现步骤：
//   1. m = text1.length, n = text2.length
//   2. 创建 (m+1)×(n+1) 的 dp 数组，初始化为 0
//   3. 遍历 i 从 1 到 m, j 从 1 到 n：
//      a. 如果 text1[i-1] == text2[j-1] → dp[i][j] = dp[i-1][j-1] + 1
//      b. 否则 → dp[i][j] = max(dp[i-1][j], dp[i][j-1])
//   4. 返回 dp[m][n]

int longestCommonSubsequence(String text1, String text2) {
  // TODO: 创建 (m+1)×(n+1) 的二维 dp 数组
  // TODO: 双重循环填表
  // TODO: 返回 dp[m][n]
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #300: Longest Increasing Subsequence（Medium - LIS）
// ============================================================================
// 题目描述：
//   给定整数数组 nums，返回其中最长的严格递增子序列的长度。子序列不需要连续。
//
// 解题思路（O(n²) DP）：
//   dp[i] = 以 nums[i] 结尾的最长递增子序列长度
//   对于每个 i，检查前面所有 j < i 且 nums[j] < nums[i]：
//   dp[i] = max(dp[i], dp[j] + 1)
//   最终答案是 max(dp[0..n-1])
//
// 实现步骤：
//   1. 如果 nums 为空 → 返回 0
//   2. dp = [1] * n（每个元素自身构成长度为 1 的 LIS）
//   3. maxLen = 1
//   4. 遍历 i 从 1 到 n-1：
//      遍历 j 从 0 到 i-1：
//        如果 nums[j] < nums[i]：dp[i] = max(dp[i], dp[j] + 1)
//      更新 maxLen
//   5. 返回 maxLen

int lengthOfLIS(List<int> nums) {
  // TODO: 空数组检查
  // TODO: dp = [1]*n
  // TODO: 双重循环：dp[i] = max(dp[i], dp[j]+1) for j < i && nums[j] < nums[i]
  // TODO: 返回 max(dp)
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #416: Partition Equal Subset Sum（Medium - Subset Sum / 0/1 背包）
// ============================================================================
// 题目描述：
//   给定只含正整数的非空数组 nums。判断是否可以分割成两个子集，使元素和相等。
//
// 解题思路（问题转化 + 0/1 背包）：
//   1. 计算 sum；如果 sum 是奇数 → 直接 false
//   2. 问题转为：能否选出若干元素和为 target = sum/2？
//   3. 0/1 背包布尔 DP：
//      dp[i] = 能否选出元素和为 i
//      对每个元素 num：dp[i] = dp[i] || dp[i-num]（倒序遍历！）
//
//   为什么倒序？因为 0/1 背包每个元素只能选一次。
//   正序遍历会导致同一元素被重复使用（变成完全背包）。
//
// 实现步骤：
//   1. sum = nums.sum；如果 sum % 2 != 0 → 返回 false
//   2. target = sum ~/ 2
//   3. dp = [true, false, ...]（长度 target + 1），dp[0] = true
//   4. 遍历每个 num in nums：
//      倒序遍历 i 从 target 到 num：
//        dp[i] = dp[i] || dp[i - num]
//   5. 返回 dp[target]

bool canPartition(List<int> nums) {
  // TODO: 计算总和，检查奇偶
  // TODO: target = sum / 2
  // TODO: 初始化 dp 数组（布尔类型）
  // TODO: 0/1 背包：外层物品，内层 target 倒序
  // TODO: 返回 dp[target]
  throw UnimplementedError(); // 请替换为你的实现
}
