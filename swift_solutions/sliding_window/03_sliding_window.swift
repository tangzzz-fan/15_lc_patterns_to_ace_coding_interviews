import Foundation

/// ---------------------------------------------------------------------------
/// 模式：滑动窗口（Sliding Window）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 滑动窗口的本质是维护一个连续区间，只处理“新进入窗口”和“离开窗口”的元素，
/// 从而避免重复计算整个区间。
///
/// ## 适用场景
/// - 固定长度窗口的最大值、平均值、总和。
/// - 可变长度窗口的最短覆盖、最长无重复子串。
/// - 连续子数组、连续子串问题。
///
/// ## 时间复杂度
/// - 大多数题可以做到 O(n)，因为每个元素最多进窗口一次、出窗口一次。
///
/// ## 空间复杂度
/// - O(k)，k 通常是字符集或窗口中不同元素的数量。
///
/// ## Swift 语法提示
/// - Swift 的 `String` 不支持直接整数下标，所以字符串题常先转成 `[Character]`。
/// - `guard` 是 Swift 常用的提前返回语法，适合处理边界情况。
enum SlidingWindowSolutions {
    // ============================================================================
    // LeetCode #643: Maximum Average Subarray I
    // ============================================================================
    // 所属模式：Sliding Window（固定窗口）
    // 难度：Easy
    // 题目描述：
    //   求长度恰好为 k 的连续子数组的最大平均值。
    //
    // 核心考点：
    //   - 固定窗口模板。
    //   - 窗口右移时只减去出窗元素、加上入窗元素。
    //
    // 解题思路推导：
    //   初始先算前 k 个元素的和。之后每次右移一格，新窗口和可以在 O(1) 更新。
    //
    // 实现步骤：
    //   1. 先算第一个窗口的和。
    //   2. 从第 k 个元素开始右移。
    //   3. 维护最大窗口和，最后除以 k。
    static func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var windowSum = 0
        for i in 0..<k {
            windowSum += nums[i]
        }

        var maxSum = windowSum
        guard nums.count > k else { return Double(maxSum) / Double(k) }

        for i in k..<nums.count {
            windowSum += nums[i] - nums[i - k]
            maxSum = max(maxSum, windowSum)
        }

        return Double(maxSum) / Double(k)
    }

    // ============================================================================
    // LeetCode #3: Longest Substring Without Repeating Characters
    // ============================================================================
    // 所属模式：Sliding Window（可变窗口）
    // 难度：Medium
    // 题目描述：
    //   返回不包含重复字符的最长子串长度。
    //
    // 核心考点：
    //   - 用 Set 维护窗口内是否存在重复字符。
    //   - 右指针扩张，左指针按需收缩。
    //
    // 解题思路推导：
    //   右指针每加入一个字符，如果导致重复，就不断移动 left，直到重复字符被移出窗口。
    //
    // 实现步骤：
    //   1. 把字符串转成字符数组，便于用整数下标访问。
    //   2. 用 Set 记录当前窗口字符。
    //   3. 遇到重复字符时收缩窗口。
    //   4. 更新最大长度。
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var window = Set<Character>()
        var left = 0
        var answer = 0

        for right in 0..<chars.count {
            let current = chars[right]
            while window.contains(current) {
                window.remove(chars[left])
                left += 1
            }
            window.insert(current)
            answer = max(answer, right - left + 1)
        }

        return answer
    }

    // ============================================================================
    // LeetCode #76: Minimum Window Substring
    // ============================================================================
    // 所属模式：Sliding Window（可变窗口）
    // 难度：Hard
    // 题目描述：
    //   返回字符串 s 中覆盖字符串 t 所有字符的最短子串。
    //
    // 核心考点：
    //   - need / window 两张频率表。
    //   - 用 matched 统计“已经满足需求的字符种类数”。
    //   - Swift 字符串需要先转 `[Character]` 再做双指针。
    //
    // 解题思路推导：
    //   右指针扩张直到窗口有效，再收缩左边界把无用字符去掉。
    //   每次窗口有效时都尝试更新最短答案。
    //
    // 实现步骤：
    //   1. 统计 t 中每个字符需要的数量 need。
    //   2. 扩张 right，把字符放入 window。
    //   3. 当 matched == need.count 时，说明窗口有效，开始收缩 left。
    //   4. 在收缩过程中持续更新最短区间。
    static func minWindow(_ s: String, _ t: String) -> String {
        let source = Array(s)
        let target = Array(t)
        guard !source.isEmpty, !target.isEmpty, source.count >= target.count else {
            return ""
        }

        var need: [Character: Int] = [:]
        for ch in target {
            need[ch, default: 0] += 1
        }

        var window: [Character: Int] = [:]
        var matched = 0
        var left = 0
        var bestStart = 0
        var bestLength = Int.max

        for right in 0..<source.count {
            let current = source[right]
            window[current, default: 0] += 1

            if let expected = need[current], window[current] == expected {
                matched += 1
            }

            while matched == need.count {
                if right - left + 1 < bestLength {
                    bestLength = right - left + 1
                    bestStart = left
                }

                let leftChar = source[left]
                window[leftChar, default: 0] -= 1
                if let expected = need[leftChar], window[leftChar, default: 0] < expected {
                    matched -= 1
                }
                left += 1
            }
        }

        guard bestLength != Int.max else { return "" }
        return String(source[bestStart..<(bestStart + bestLength)])
    }
}

