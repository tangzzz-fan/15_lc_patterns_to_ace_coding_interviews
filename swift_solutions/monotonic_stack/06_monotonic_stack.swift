import Foundation

/// ---------------------------------------------------------------------------
/// 模式：单调栈（Monotonic Stack）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 栈中始终保持单调递增或单调递减的性质。新元素进来时，把不再可能成为答案的元素弹出，
/// 于是每个元素只会入栈一次、出栈一次。
///
/// ## 适用场景
/// - 下一个更大元素。
/// - 下一个更小元素。
/// - 柱状图最大矩形。
///
/// ## 时间复杂度
/// - O(n)
///
/// ## 空间复杂度
/// - O(n)
///
/// ## Swift 语法提示
/// - Swift 的数组既可以当动态数组，也可以当栈，`append`/`removeLast` 就是常见栈操作。
enum MonotonicStackSolutions {
    // ============================================================================
    // LeetCode #496: Next Greater Element I
    // ============================================================================
    // 所属模式：Monotonic Stack（下一个更大元素）
    // 难度：Easy
    // 题目描述：
    //   对 nums1 中每个元素，找出它在 nums2 中右侧第一个更大的元素。
    //
    // 核心考点：
    //   - 先在 nums2 中一次性求出每个数的下一个更大值。
    //   - 单调递减栈：栈顶始终是最近且还没找到更大值的元素。
    static func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack: [Int] = []
        var nextMap: [Int: Int] = [:]

        for num in nums2 {
            while let last = stack.last, num > last {
                nextMap[last] = num
                stack.removeLast()
            }
            stack.append(num)
        }

        return nums1.map { nextMap[$0] ?? -1 }
    }

    // ============================================================================
    // LeetCode #739: Daily Temperatures
    // ============================================================================
    // 所属模式：Monotonic Stack（等待下一个更大值）
    // 难度：Medium
    // 题目描述：
    //   对每一天，返回还要等几天才会遇到更高温度。
    //
    // 核心考点：
    //   - 栈里存下标，不直接存温度。
    //   - 当前温度一旦更大，就可以结算之前较小温度的位置。
    static func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var answer = Array(repeating: 0, count: temperatures.count)
        var stack: [Int] = []

        for index in 0..<temperatures.count {
            while let lastIndex = stack.last, temperatures[index] > temperatures[lastIndex] {
                answer[lastIndex] = index - lastIndex
                stack.removeLast()
            }
            stack.append(index)
        }

        return answer
    }

    // ============================================================================
    // LeetCode #84: Largest Rectangle in Histogram
    // ============================================================================
    // 所属模式：Monotonic Stack（寻找左右边界）
    // 难度：Hard
    // 题目描述：
    //   给定柱状图高度，求能够形成的最大矩形面积。
    //
    // 核心考点：
    //   - 对每个柱子，找到左边和右边第一个比它低的位置。
    //   - 追加哨兵 0，统一清栈逻辑。
    //
    // 解题思路推导：
    //   某个柱子一旦出栈，说明当前元素就是它右边第一个更小值，
    //   出栈后新的栈顶就是它左边第一个更小值。
    static func largestRectangleArea(_ heights: [Int]) -> Int {
        var extended = heights
        extended.append(0)

        var stack: [Int] = []
        var answer = 0

        for index in 0..<extended.count {
            while let lastIndex = stack.last, extended[index] < extended[lastIndex] {
                let height = extended[lastIndex]
                stack.removeLast()
                let leftBoundary = stack.last ?? -1
                let width = index - leftBoundary - 1
                answer = max(answer, height * width)
            }
            stack.append(index)
        }

        return answer
    }
}

