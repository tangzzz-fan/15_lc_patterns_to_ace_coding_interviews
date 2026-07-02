import Foundation

/// ---------------------------------------------------------------------------
/// 模式：变形二分查找（Modified Binary Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 标准二分只适用于整体单调的数据。变形二分的关键，是在每一轮判断中识别出哪一半仍然有序，
/// 再只保留可能包含答案的那一半。
///
/// ## 适用场景
/// - 旋转有序数组。
/// - 局部有序结构。
/// - 二维矩阵的阶梯式搜索。
///
/// ## 时间复杂度
/// - 常见为 O(log n)；二维阶梯搜索为 O(m + n)。
///
/// ## 空间复杂度
/// - O(1)
///
/// ## Swift 语法提示
/// - `left + (right - left) / 2` 是更稳妥的中点写法。
enum ModifiedBinarySearchSolutions {
    // ============================================================================
    // LeetCode #33: Search in Rotated Sorted Array
    // ============================================================================
    // 所属模式：Modified Binary Search（旋转数组）
    // 难度：Medium
    // 题目描述：
    //   在旋转升序数组中查找 target，存在则返回下标，不存在返回 -1。
    //
    // 核心考点：
    //   - 每轮都能确认至少一半区间有序。
    //   - 根据 target 是否位于有序区间，决定保留哪一边。
    static func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1

        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target { return mid }

            if nums[left] <= nums[mid] {
                if nums[left] <= target && target < nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                if nums[mid] < target && target <= nums[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }

        return -1
    }

    // ============================================================================
    // LeetCode #153: Find Minimum in Rotated Sorted Array
    // ============================================================================
    // 所属模式：Modified Binary Search（找旋转点）
    // 难度：Medium
    // 题目描述：
    //   在无重复元素的旋转升序数组中找最小值。
    //
    // 核心考点：
    //   - 与右端点比较，判断最小值在哪一侧。
    static func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1

        while left < right {
            let mid = left + (right - left) / 2
            if nums[mid] > nums[right] {
                left = mid + 1
            } else {
                right = mid
            }
        }

        return nums[left]
    }

    // ============================================================================
    // LeetCode #240: Search a 2D Matrix II
    // ============================================================================
    // 所属模式：Modified Binary Search（二维阶梯搜索）
    // 难度：Medium
    // 题目描述：
    //   矩阵每行递增、每列递增，判断 target 是否存在。
    //
    // 核心考点：
    //   - 从右上角开始，大了往左，小了往下。
    static func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return false }

        var row = 0
        var col = matrix[0].count - 1
        while row < matrix.count && col >= 0 {
            let value = matrix[row][col]
            if value == target { return true }
            if value > target {
                col -= 1
            } else {
                row += 1
            }
        }

        return false
    }
}
