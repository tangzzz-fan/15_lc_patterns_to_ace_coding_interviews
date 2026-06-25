/// ---------------------------------------------------------------------------
/// 模式：动态规划（Dynamic Programming）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 动态规划（DP）是一种将问题分解为重叠子问题，并通过记忆化（Memoization，自顶向下）
/// 或制表（Tabulation，自底向上）的方式避免重复计算的方法。
///
/// DP 的两大要素：
/// 1. **最优子结构**：问题的最优解包含其子问题的最优解。
/// 2. **重叠子问题**：同一个子问题会被反复计算。
///
/// DP 解题五步法：
/// 1. 定义 dp 数组/函数的含义。
/// 2. 推导状态转移方程（递推公式）。
/// 3. 确定 base case（初始条件）。
/// 4. 确定遍历顺序。
/// 5. 写出代码（或进一步优化空间）。
///
/// ## 常用子模式
/// - **Fibonacci Numbers**：dp[i] = dp[i-1] + dp[i-2]
/// - **0/1 Knapsack**：物品选或不选，dp[i][w] = max(dp[i-1][w], dp[i-1][w-wt[i]] + val[i])
/// - **Longest Common Subsequence (LCS)**：text1[i]==text2[j] → 1+dp[i-1][j-1] 否则 max(dp[i-1][j], dp[i][j-1])
/// - **Longest Increasing Subsequence (LIS)**：dp[i] = 1 + max(dp[j]) for all j < i and nums[j] < nums[i]
/// - **Subset Sum**：能否选出和为 target 的子集，dp[i] = dp[i] || dp[i-num]
/// - **Matrix Chain Multiplication**：最优加括号方式
///
/// ## 时间复杂度
/// - 通常为 O(n)、O(n²)、O(n×m)，取决于状态数量和每个状态的计算复杂度。
///
/// ## 空间复杂度
/// - 通常为 O(n) 或 O(n×m)。可通过滚动数组等方式优化。

// ============================================================================
// LeetCode #70: Climbing Stairs（Fibonacci 子模式）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - Fibonacci）
// 难度：Easy
// 题目描述：
//   假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
//   每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
//
// 核心考点：
//   - DP 入门：状态转移方程 dp[i] = dp[i-1] + dp[i-2]。
//   - base case：dp[1]=1, dp[2]=2。
//   - 空间优化：只用两个变量滚动。
//
// 解题思路推导：
//   到达第 i 阶有两种方式：
//   - 从第 i-1 阶走 1 步上来。
//   - 从第 i-2 阶走 2 步上来。
//   因此 dp[i] = dp[i-1] + dp[i-2]，这正是 Fibonacci 数列。
//
//   举例：n = 4
//   dp[1] = 1（1步）
//   dp[2] = 2（1+1 或 2）
//   dp[3] = dp[2] + dp[1] = 2 + 1 = 3
//   dp[4] = dp[3] + dp[2] = 3 + 2 = 5
//
// 实现步骤：
//   1. 如果 n <= 2，返回 n。
//   2. 初始化 prev2 = 1（dp[1]），prev1 = 2（dp[2]）。
//   3. 循环 i 从 3 到 n：
//      a. current = prev1 + prev2。
//      b. prev2 = prev1。
//      c. prev1 = current。
//   4. 返回 prev1。

int climbStairs(int n) {
  if (n <= 2) return n;

  int prev2 = 1; // dp[1]
  int prev1 = 2; // dp[2]

  for (int i = 3; i <= n; i++) {
    int current = prev1 + prev2; // dp[i] = dp[i-1] + dp[i-2]
    prev2 = prev1; // 滚动更新
    prev1 = current;
  }

  return prev1;
}

// ============================================================================
// LeetCode #198: House Robber（Fibonacci 变体）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - 一维 DP）
// 难度：Medium
// 题目描述：
//   你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金。
//   影响偷窃的唯一制约因素就是相邻的房屋之间有防盗系统，如果两间相邻的房屋在同一夜
//   被闯入，系统会自动报警。给定 nums 代表每个房屋的金额，返回不触动警报装置的情况下，
//   一夜之内能偷窃到的最高金额。
//
// 核心考点：
//   - 一维 DP：dp[i] = max(dp[i-1], dp[i-2] + nums[i])。
//   - 状态转移的含义：对于第 i 个房子，"不偷"→ dp[i-1] 和 "偷"→ dp[i-2] + nums[i]。
//
// 解题思路推导：
//   对于第 i 间房，有两种选择：
//   - 不偷第 i 间房：最高金额 = dp[i-1]（上一间的最优解）。
//   - 偷第 i 间房：意味着不能偷第 i-1 间，最高金额 = dp[i-2] + nums[i]。
//   dp[i] = max(dp[i-1], dp[i-2] + nums[i])
//
//   举例：nums = [2,7,9,3,1]
//   dp[0] = 2
//   dp[1] = max(2, 7) = 7
//   dp[2] = max(7, 2+9) = 11
//   dp[3] = max(11, 7+3) = 11
//   dp[4] = max(11, 11+1) = 12
//
// 实现步骤：
//   1. 如果 nums 为空，返回 0；长度为 1，返回 nums[0]。
//   2. 初始化 prev2 = nums[0]（dp[0]），prev1 = max(nums[0], nums[1])（dp[1]）。
//   3. 循环 i 从 2 到 n-1：
//      a. current = max(prev1, prev2 + nums[i])。
//      b. prev2 = prev1。
//      c. prev1 = current。
//   4. 返回 prev1。

int rob(List<int> nums) {
  if (nums.isEmpty) return 0;
  if (nums.length == 1) return nums[0];

  int prev2 = nums[0]; // dp[0]：只偷第一间
  int prev1 = nums[0] > nums[1] ? nums[0] : nums[1]; // dp[1]：max(偷0, 偷1)

  for (int i = 2; i < nums.length; i++) {
    int current = prev1 > (prev2 + nums[i]) ? prev1 : (prev2 + nums[i]);
    // dp[i] = max(dp[i-1], dp[i-2] + nums[i])
    prev2 = prev1;
    prev1 = current;
  }

  return prev1;
}

// ============================================================================
// LeetCode #322: Coin Change（完全背包子模式）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - 完全背包）
// 难度：Medium
// 题目描述：
//   给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额
//   所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。
//   你可以认为每种硬币的数量是无限的。
//
// 核心考点：
//   - 完全背包问题：每种物品可选无限次。
//   - dp[amount] = min(dp[amount], dp[amount - coin] + 1)。
//   - 初始化技巧：dp[0] = 0，其余为无穷大。
//
// 解题思路推导：
//   dp[i] 表示凑成金额 i 所需的最少硬币数。
//   对于每个金额 i，尝试用每种硬币 coin：
//   - 如果 i >= coin，可以用 1 枚 coin + dp[i - coin]。
//   - dp[i] = min(dp[i], dp[i - coin] + 1)。
//
//   与 0/1 背包的区别：硬币可重复使用 → 正序遍历（正序允许重复选）。
//
//   举例：coins = [1,2,5], amount = 11
//   dp[0] = 0
//   dp[1] = 1（用 1）
//   dp[2] = min(dp[2], dp[2-1]+1=2, dp[2-2]+1=1) = 1（用 2）
//   dp[5] = 1（用 5）
//   dp[11] = dp[6] + 1 = dp[5] + 1 + 1 = 1 + 1 + 1 = 3
//   结果：3（5+5+1 或 5+2+2+2）
//
// 实现步骤：
//   1. 初始化 dp 数组，长度 amount + 1，全部填 amount + 1（代表无穷大）。
//   2. dp[0] = 0（凑成 0 元不需要硬币）。
//   3. 遍历 i 从 1 到 amount：
//      a. 遍历每种硬币 coin：
//         - 如果 i >= coin：dp[i] = min(dp[i], dp[i - coin] + 1)。
//   4. 返回 dp[amount] > amount ？ -1 ： dp[amount]。

int coinChange(List<int> coins, int amount) {
  // dp[i] 代表凑成金额 i 所需的最少硬币数
  List<int> dp = List<int>.filled(amount + 1, amount + 1); // 初始化为极大值

  dp[0] = 0; // base case：凑成 0 元不需要硬币

  // 外层遍历金额（正序，允许重复使用硬币）
  for (int i = 1; i <= amount; i++) {
    for (int coin in coins) {
      if (i >= coin) {
        int candidate = dp[i - coin] + 1; // 用 1 枚 coin + 剩余金额的最优解
        if (candidate < dp[i]) {
          dp[i] = candidate; // 更新最少硬币数
        }
      }
    }
  }

  // 如果 dp[amount] 仍为初始极大值，说明无法凑成
  return dp[amount] > amount ? -1 : dp[amount];
}

// ============================================================================
// LeetCode #1143: Longest Common Subsequence（LCS 子模式）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - 最长公共子序列）
// 难度：Medium
// 题目描述：
//   给定两个字符串 text1 和 text2，返回它们的最长公共子序列的长度。
//   子序列是指在不改变剩余字符顺序的情况下删除某些字符（或不删除）得到的序列。
//
// 核心考点：
//   - 二维 DP 经典模板。
//   - 状态转移：匹配 → dp[i-1][j-1] + 1；不匹配 → max(dp[i-1][j], dp[i][j-1])。
//   - 可优化为一维数组（滚动数组）。
//
// 解题思路推导：
//   dp[i][j] 表示 text1[0..i-1] 和 text2[0..j-1] 的 LCS 长度。
//
//   对于 text1[i-1] 和 text2[j-1]：
//   - 如果相等：这两个字符必然在 LCS 中，dp[i][j] = dp[i-1][j-1] + 1。
//   - 如果不相等：至少有一个字符不在 LCS 中，
//     dp[i][j] = max(dp[i-1][j], dp[i][j-1])。
//
//   举例：text1 = "abcde", text2 = "ace"
//   dp 表格：
//       "" a c e
//    ""  0 0 0 0
//    a   0 1 1 1
//    b   0 1 1 1
//    c   0 1 2 2
//    d   0 1 2 2
//    e   0 1 2 3
//   结果：3 ("ace")
//
// 实现步骤：
//   1. m = text1.length, n = text2.length。
//   2. 创建 (m+1)×(n+1) 的 dp 数组，初始化为 0。
//   3. 遍历 i 从 1 到 m，j 从 1 到 n：
//      a. 如果 text1[i-1] == text2[j-1]：
//         dp[i][j] = dp[i-1][j-1] + 1。
//      b. 否则：dp[i][j] = max(dp[i-1][j], dp[i][j-1])。
//   4. 返回 dp[m][n]。

int longestCommonSubsequence(String text1, String text2) {
  int m = text1.length;
  int n = text2.length;

  // dp[i][j] = text1[0..i-1] 与 text2[0..j-1] 的 LCS 长度
  List<List<int>> dp = List.generate(
    m + 1,
    (_) => List<int>.filled(n + 1, 0),
  );

  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (text1[i - 1] == text2[j - 1]) {
        // 当前字符匹配，LCS 长度 +1
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        // 当前字符不匹配，取两种情况的最大值
        dp[i][j] = dp[i - 1][j] > dp[i][j - 1]
            ? dp[i - 1][j]
            : dp[i][j - 1]; // max(dp[i-1][j], dp[i][j-1])
      }
    }
  }

  return dp[m][n];
}

// ============================================================================
// LeetCode #300: Longest Increasing Subsequence（LIS 子模式）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - 最长递增子序列）
// 难度：Medium
// 题目描述：
//   给定一个整数数组 nums，找到其中最长的严格递增子序列的长度。
//   子序列不需要在原数组中连续。
//
// 核心考点：
//   - LIS 的一维 DP 解法：O(n²)。
//   - 耐心排序（Patience Sorting）二分优化：O(n log n)。
//   - dp[i] = 1 + max(dp[j]) for j < i and nums[j] < nums[i]。
//
// 解题思路推导：
//   O(n²) 解法：dp[i] 表示以 nums[i] 结尾的最长递增子序列长度。
//   对于每个 i，检查前面所有 j < i 且 nums[j] < nums[i] 的位置，
//   dp[i] = max(dp[i], dp[j] + 1)。
//   最终答案是 max(dp[0...n-1])。
//
//   O(n log n) 解法（耐心排序）：
//   维护一个 tails 数组，tails[k] 表示长度为 k+1 的递增子序列的最小尾部元素。
//   遍历 nums，用二分查找在 tails 中找到第一个 >= nums[i] 的位置：
//   - 如果找到，替换之（保持尾部最小）。
//   - 如果没找到（nums[i] 比所有 tails 都大），追加到 tails 末尾。
//   tails 的长度就是 LIS 的长度。
//
//   举例：nums = [10,9,2,5,3,7,101,18]
//   O(n²):
//   dp[0]=1, dp[1]=1(9前无更小), dp[2]=1(2前无更小)
//   dp[3]=dp[2]+1=2(5>2), dp[4]=dp[2]+1=2(3>2), dp[5]=max(dp[3],dp[4])+1=3
//   dp[6]=dp[5]+1=4(101>3 or 7), dp[7]=dp[5]+1=3(18>7)
//   max = 4
//
// 实现步骤（O(n²)）：
//   1. dp 数组初始化为 1（每个元素自身长度为 1）。
//   2. 遍历 i 从 1 到 n-1：
//      a. 遍历 j 从 0 到 i-1：
//         - 如果 nums[j] < nums[i]：dp[i] = max(dp[i], dp[j] + 1)。
//   3. 返回 max(dp)。

int lengthOfLIS(List<int> nums) {
  if (nums.isEmpty) return 0;

  int n = nums.length;
  // dp[i] = 以 nums[i] 结尾的 LIS 长度
  List<int> dp = List<int>.filled(n, 1); // 每个元素自身构成 LIS 长度为 1

  int maxLen = 1;

  for (int i = 1; i < n; i++) {
    for (int j = 0; j < i; j++) {
      if (nums[j] < nums[i]) {
        // 可以将 nums[i] 接在以 nums[j] 结尾的递增序列后面
        int candidate = dp[j] + 1;
        if (candidate > dp[i]) {
          dp[i] = candidate; // 更新 dp[i]
        }
      }
    }
    if (dp[i] > maxLen) {
      maxLen = dp[i]; // 更新全局最大值
    }
  }

  return maxLen;
}

// ============================================================================
// LeetCode #416: Partition Equal Subset Sum（Subset Sum 子模式）
// ============================================================================
// 所属模式：Dynamic Programming（动态规划 - 子集和 / 0/1 背包）
// 难度：Medium
// 题目描述：
//   给定一个只包含正整数的非空数组 nums。判断是否可以将这个数组分割成两个子集，
//   使得两个子集的元素和相等。
//
// 核心考点：
//   - 问题转化：如果 sum 是奇数，直接 false；否则转化为"能否选出若干元素和为 sum/2"。
//   - 0/1 背包：每个元素只能选一次。
//   - 一维布尔 DP 优化：dp[i] = dp[i] || dp[i - num]（倒序遍历）。
//
// 解题思路推导：
//   如果总和 sum 是奇数，不可能平分 → 返回 false。
//   问题转化为：是否存在子集的和为 target = sum / 2？
//   对于每个元素 num，可以选或不选：
//   - 不选：dp[i] 保持不变。
//   - 选：dp[i] = dp[i] || dp[i - num]（之前能否凑成 i - num）。
//
//   倒序遍历的原因：0/1 背包每个物品只能用一次，正序会导致物品被重复使用。
//
//   举例：nums = [1,5,11,5], sum = 22, target = 11
//   初始化 dp[0]=true
//   num=1: dp[1]=dp[1]||dp[0]=true
//   num=5: dp[5]=dp[5]||dp[0]=true, dp[6]=dp[6]||dp[1]=true
//   num=11: dp[11]=dp[11]||dp[0]=true → 找到！
//   结果：true（[1,5,5] 和 [11]）
//
// 实现步骤：
//   1. 计算总和 sum。
//   2. 如果 sum 是奇数，返回 false。
//   3. target = sum ~/ 2。
//   4. 初始化 dp = [true, false, false, ...]（长度 target + 1）。
//   5. 遍历每个 num in nums：
//      a. 倒序遍历 i 从 target 到 num：
//         - dp[i] = dp[i] || dp[i - num]。
//   6. 返回 dp[target]。

bool canPartition(List<int> nums) {
  int sum = nums.reduce((a, b) => a + b);

  // 总和为奇数，不可能平分
  if (sum % 2 != 0) return false;

  int target = sum ~/ 2;

  // dp[i] = 能否选出若干元素，使其和为 i
  List<bool> dp = List<bool>.filled(target + 1, false);
  dp[0] = true; // 和为 0 的子集始终存在（空集）

  // 0/1 背包：每个元素只能选一次
  for (int num in nums) {
    // 倒序遍历，防止同一元素被重复使用
    for (int i = target; i >= num; i--) {
      dp[i] = dp[i] || dp[i - num]; // 不选 or 选
    }
  }

  return dp[target];
}
