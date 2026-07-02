import Foundation

/// ---------------------------------------------------------------------------
/// 模式：前缀和（Prefix Sum）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 前缀和先用一次线性扫描完成预处理，再把后续的区间求和查询压缩到 O(1)。
/// 如果 `prefix[i]` 表示前 `i` 个元素的和，那么闭区间 `[left, right]` 的和就是：
/// `prefix[right + 1] - prefix[left]`。
///
/// ## 适用场景
/// - 高频区间求和。
/// - 连续子数组的和、计数、最长长度问题。
/// - 前缀和结合哈希表，统计和为 `k` 的子数组个数。
///
/// ## 时间复杂度
/// - 预处理：O(n)
/// - 单次查询：O(1)
/// 
/// - `dict[key, default: value]` 是 Swift 字典的默认值下标语法，适合做计数。
enum PrefixSumSolutions {
    // 使用 enum 作为纯命名空间，避免不同文件中的同名类型冲突。

    // ============================================================================
    // LeetCode #303: Range Sum Query - Immutable
    // ============================================================================
    // 所属模式：Prefix Sum（前缀和）
    // 难度：Easy
    // 题目描述：
    //   设计一个类，支持多次查询数组闭区间 [left, right] 的元素和。
    //
    // 核心考点：
    //   - 前缀和数组如何定义。
    //   - 为什么把 prefix 设计成 n + 1 长度更容易统一边界。
    //
    // 解题思路推导：
    //   如果 prefix[i] 表示前 i 个元素的和，那么：
    //   区间 [left, right] 的和 = prefix[right + 1] - prefix[left]。
    //   这样 left = 0 时也不需要额外分支。
    //
    // 实现步骤：
    //   1. 构造 prefix，长度为 nums.count + 1。
    //   2. prefix[i + 1] = prefix[i] + nums[i]。
    //   3. 查询时直接返回 prefix[right + 1] - prefix[left]。
    final class NumArray {
        private var prefix: [Int]

        init(_ nums: [Int]) {
            prefix = Array(repeating: 0, count: nums.count + 1)
            for i in 0..<nums.count {
                prefix[i + 1] = prefix[i] + nums[i]
            }
        }

        func sumRange(_ left: Int, _ right: Int) -> Int {
            return prefix[right + 1] - prefix[left]
        }
    }

    // ============================================================================
    // LeetCode #525: Contiguous Array
    // ============================================================================
    // 所属模式：Prefix Sum（前缀和）+ HashMap
    // 难度：Medium
    // 题目描述：
    //   给定一个只包含 0 和 1 的数组，求 0 和 1 数量相同的最长连续子数组长度。
    //
    // 核心考点：
    //   - 把 0 转成 -1，把“0 和 1 数量相同”转成“区间和为 0”。
    //   - 哈希表记录某个前缀和第一次出现的位置。
    //
    // 解题思路推导：
    //   如果两个位置拥有相同的前缀和，说明它们之间的区间和为 0。
    //   因此第一次出现某个前缀和的位置最有价值，因为它能形成最长区间。
    //
    // 实现步骤：
    //   1. 用 count 表示当前前缀和，遇到 1 加 1，遇到 0 减 1。
    //   2. 用字典记录每个前缀和第一次出现的下标。
    //   3. 如果某个 count 再次出现，用当前下标减去第一次出现的位置更新答案。
    static func findMaxLength(_ nums: [Int]) -> Int {
        var firstIndex: [Int: Int] = [0: -1]
        var count = 0
        var answer = 0

        for (index, num) in nums.enumerated() {
            count += (num == 1 ? 1 : -1)
            if let first = firstIndex[count] {
                answer = max(answer, index - first)
            } else {
                firstIndex[count] = index
            }
        }

        return answer
    }

    // ============================================================================
    // LeetCode #560: Subarray Sum Equals K
    // ============================================================================
    // 所属模式：Prefix Sum（前缀和）+ HashMap
    // 难度：Medium
    // 题目描述：
    //   统计数组中和恰好等于 k 的连续子数组个数。
    //
    // 核心考点：
    //   - 公式：prefix[j] - prefix[i] = k。
    //   - 枚举右端点时，转化为“前面有多少个前缀和等于 current - k”。
    //
    // 解题思路推导：
    //   扫描到当前位置时，如果当前前缀和是 currentSum，
    //   那么所有值为 currentSum - k 的历史前缀和，都能和当前位置配对形成合法子数组。
    //
    // 实现步骤：
    //   1. 字典 frequency 记录每个前缀和出现次数。
    //   2. 初始化 frequency[0] = 1，表示空前缀。
    //   3. 每到一个位置，先累加 currentSum。
    //   4. 把 frequency[currentSum - k] 累加到答案中。
    //   5. 再把当前前缀和写回字典。
    static func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var frequency: [Int: Int] = [0: 1]
        var currentSum = 0
        var answer = 0

        for num in nums {
            currentSum += num
            answer += frequency[currentSum - k, default: 0]
            frequency[currentSum, default: 0] += 1
        }

        return answer
    }
}

