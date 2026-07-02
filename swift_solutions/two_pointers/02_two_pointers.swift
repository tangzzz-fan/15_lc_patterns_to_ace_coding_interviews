import Foundation

/// ---------------------------------------------------------------------------
/// 模式：双指针（Two Pointers）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 双指针通过两个位置的联动，把原本需要双重循环枚举的过程压缩为一次线性扫描。
/// 常见形式有：左右夹逼、同向滑动、快慢收缩。
///
/// ## 适用场景
/// - 有序数组中的两数之和。
/// - 去重、原地删除、稳定压缩。
/// - 通过左右边界逐步逼近最优解。
///
/// ## 时间复杂度
/// - 常见为 O(n) 或 O(n log n)（如果前面需要排序）。
///
/// ## 空间复杂度
/// - 常见为 O(1) 或 O(log n)（排序栈空间）。
///
/// ## Swift 语法提示
/// - `sort()` 会原地排序；如果不希望修改原数组，要先复制。
/// - 闭包排序 `array.sort { $0 < $1 }` 是 Swift 中很常见的高阶函数写法。
enum TwoPointersSolutions {
    // ============================================================================
    // LeetCode #167: Two Sum II - Input Array is Sorted
    // ============================================================================
    // 所属模式：Two Pointers（双指针 - 左右夹逼）
    // 难度：Medium
    // 题目描述：
    //   在升序数组中找到两个数，使得它们之和等于 target，返回 1-based 下标。
    //
    // 核心考点：
    //   - 有序数组上的左右指针移动策略。
    //   - 当前和小了就左指针右移，当前和大了就右指针左移。
    //
    // 解题思路推导：
    //   由于数组有序，指针每次移动都能确定性地让和变大或变小，
    //   因而不需要回退，也不需要哈希表。
    //
    // 实现步骤：
    //   1. left 指向头，right 指向尾。
    //   2. 计算 sum = numbers[left] + numbers[right]。
    //   3. sum == target 直接返回；sum < target 移动 left；否则移动 right。
    static func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1

        while left < right {
            let sum = numbers[left] + numbers[right]
            if sum == target {
                return [left + 1, right + 1]
            }
            if sum < target {
                left += 1
            } else {
                right -= 1
            }
        }

        return []
    }

    // ============================================================================
    // LeetCode #15: 3Sum
    // ============================================================================
    // 所属模式：Two Pointers（双指针 - 排序后夹逼）
    // 难度：Medium
    // 题目描述：
    //   返回所有和为 0 且不重复的三元组。
    //
    // 核心考点：
    //   - 固定一个数，把剩余问题转成 Two Sum。
    //   - 排序后通过跳过重复值完成去重。
    //
    // 解题思路推导：
    //   先排序。枚举第一个数 nums[i] 后，目标就变成在右侧找两数之和等于 -nums[i]。
    //   这一步可以用左右指针在线性时间完成。
    //
    // 实现步骤：
    //   1. 对数组排序。
    //   2. 枚举 i，跳过重复的 nums[i]。
    //   3. 在区间 [i + 1, end] 用左右指针寻找两数和。
    //   4. 找到后继续跳过重复的 left 和 right。
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        var nums = nums
        nums.sort()
        var answer: [[Int]] = []

        guard nums.count >= 3 else { return answer }

        for i in 0..<(nums.count - 2) {
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }

            var left = i + 1
            var right = nums.count - 1

            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                if sum == 0 {
                    answer.append([nums[i], nums[left], nums[right]])
                    left += 1
                    right -= 1

                    while left < right && nums[left] == nums[left - 1] {
                        left += 1
                    }
                    while left < right && nums[right] == nums[right + 1] {
                        right -= 1
                    }
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }

        return answer
    }

    // ============================================================================
    // LeetCode #11: Container With Most Water
    // ============================================================================
    // 所属模式：Two Pointers（双指针 - 贪心夹逼）
    // 难度：Medium
    // 题目描述：
    //   给定若干垂线高度，求两条线与 x 轴能围成的最大容器面积。
    //
    // 核心考点：
    //   - 面积 = 宽度 * 两边较短高度。
    //   - 为什么每次移动较短的一边才可能得到更优解。
    //
    // 解题思路推导：
    //   当前面积受短板限制。如果移动较高的一边，宽度变小，而短板高度不可能提高，
    //   因此没有收益。只有移动短板，才有机会得到更高的下界。
    //
    // 实现步骤：
    //   1. left 在左端，right 在右端。
    //   2. 计算当前面积并更新答案。
    //   3. 移动高度较小的一侧。
    static func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var answer = 0

        while left < right {
            let width = right - left
            let area = min(height[left], height[right]) * width
            answer = max(answer, area)

            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }

        return answer
    }
}

