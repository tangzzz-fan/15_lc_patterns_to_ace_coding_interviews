import Foundation

/// ---------------------------------------------------------------------------
/// 模式：动态规划（Dynamic Programming）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 动态规划解决的是“重叠子问题 + 最优子结构”。
/// 写 DP 时不要直接背模板，先把下面四件事写清楚：
/// 1. `dp` 的定义是什么。
/// 2. 状态转移从哪里来。
/// 3. base case 是什么。
/// 4. 遍历顺序为什么正确。
///
/// ## 适用场景
/// - Fibonacci 型递推。
/// - 背包、子序列、划分问题。
/// - 区间与二维网格状态。
///
/// ## 时间复杂度
/// - 常见为 O(n)、O(n^2)、O(mn)。
///
/// ## 空间复杂度
/// - 常见为 O(n) 或 O(mn)，有时可压缩。
///
/// ## Swift 语法提示
/// - `Array(repeating: value, count: n)` 是 DP 初始化最常见的 Swift 写法。
/// - `stride(from:through:by:)` 支持倒序遍历，常用于 0/1 背包。
enum DynamicProgrammingSolutions {
    // ============================================================================
    // LeetCode #70: Climbing Stairs
    // ============================================================================
    // 所属模式：Dynamic Programming（Fibonacci）
    // 难度：Easy
    // 题目描述：
    //   每次爬 1 阶或 2 阶，求到达第 n 阶的方法数。
    static func climbStairs(_ n: Int) -> Int {
        if n <= 2 { return n }
        var prev2 = 1
        var prev1 = 2
        for _ in 3...n {
            let current = prev1 + prev2
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }

    // ============================================================================
    // LeetCode #198: House Robber
    // ============================================================================
    // 所属模式：Dynamic Programming（一维 DP）
    // 难度：Medium
    // 题目描述：
    //   相邻房屋不能同时偷，返回最大金额。
    static func rob(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        guard nums.count > 1 else { return nums[0] }

        var prev2 = nums[0]
        var prev1 = max(nums[0], nums[1])
        if nums.count == 2 { return prev1 }

        for index in 2..<nums.count {
            let current = max(prev1, prev2 + nums[index])
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }

    // ============================================================================
    // LeetCode #322: Coin Change
    // ============================================================================
    // 所属模式：Dynamic Programming（完全背包）
    // 难度：Medium
    // 题目描述：
    //   求凑成 amount 的最少硬币数。
    static func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        if amount == 0 { return 0 }

        for value in 1...amount {
            for coin in coins where value >= coin {
                dp[value] = min(dp[value], dp[value - coin] + 1)
            }
        }

        return dp[amount] > amount ? -1 : dp[amount]
    }

    // ============================================================================
    // LeetCode #1143: Longest Common Subsequence
    // ============================================================================
    // 所属模式：Dynamic Programming（二维 DP）
    // 难度：Medium
    // 题目描述：
    //   返回两个字符串的最长公共子序列长度。
    static func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let a = Array(text1)
        let b = Array(text2)
        var dp = Array(repeating: Array(repeating: 0, count: b.count + 1), count: a.count + 1)

        for i in 1...a.count {
            for j in 1...b.count {
                if a[i - 1] == b[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }

        return dp[a.count][b.count]
    }

    // ============================================================================
    // LeetCode #300: Longest Increasing Subsequence
    // ============================================================================
    // 所属模式：Dynamic Programming（一维 DP）
    // 难度：Medium
    // 题目描述：
    //   返回最长严格递增子序列长度。
    static func lengthOfLIS(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var dp = Array(repeating: 1, count: nums.count)
        var answer = 1

        for i in 1..<nums.count {
            for j in 0..<i where nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
            answer = max(answer, dp[i])
        }

        return answer
    }

    // ============================================================================
    // LeetCode #416: Partition Equal Subset Sum
    // ============================================================================
    // 所属模式：Dynamic Programming（0/1 背包）
    // 难度：Medium
    // 题目描述：
    //   判断数组能否被分成两个和相等的子集。
    //
    // 核心考点：
    //   - 先转化为“能否选出一些数使和为总和的一半”。
    //   - 0/1 背包必须倒序遍历，避免一个数被重复使用。
    static func canPartition(_ nums: [Int]) -> Bool {
        let total = nums.reduce(0, +)
        if total % 2 != 0 { return false }

        let target = total / 2
        var dp = Array(repeating: false, count: target + 1)
        dp[0] = true

        for num in nums {
            for value in stride(from: target, through: num, by: -1) {
                dp[value] = dp[value] || dp[value - num]
            }
        }

        return dp[target]
    }
}
