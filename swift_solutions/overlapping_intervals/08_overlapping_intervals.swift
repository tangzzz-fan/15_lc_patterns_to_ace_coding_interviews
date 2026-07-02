import Foundation

/// ---------------------------------------------------------------------------
/// 模式：重叠区间（Overlapping Intervals）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 区间题的第一反应通常是“先排序，再线性扫描”。排序之后，是否重叠只需要看相邻区间。
///
/// ## 适用场景
/// - 合并区间。
/// - 插入新区间。
/// - 删除最少区间使其互不重叠。
///
/// ## 时间复杂度
/// - 排序 O(n log n)
/// - 扫描 O(n)
///
/// ## 空间复杂度
/// - O(1) 到 O(n)，取决于是否新建结果数组。
///
/// ## Swift 语法提示
/// - `intervals.sorted { $0[0] < $1[0] }` 使用闭包按起点排序。
enum OverlappingIntervalsSolutions {
    // ============================================================================
    // LeetCode #56: Merge Intervals
    // ============================================================================
    // 所属模式：Overlapping Intervals（排序 + 合并）
    // 难度：Medium
    // 题目描述：
    //   合并所有重叠区间。
    //
    // 核心考点：
    //   - 排序后只需要与结果数组的最后一个区间比较。
    static func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard !intervals.isEmpty else { return [] }
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
        var answer: [[Int]] = [sortedIntervals[0]]

        for interval in sortedIntervals.dropFirst() {
            if interval[0] <= answer[answer.count - 1][1] {
                answer[answer.count - 1][1] = max(answer[answer.count - 1][1], interval[1])
            } else {
                answer.append(interval)
            }
        }

        return answer
    }

    // ============================================================================
    // LeetCode #57: Insert Interval
    // ============================================================================
    // 所属模式：Overlapping Intervals（插入并合并）
    // 难度：Medium
    // 题目描述：
    //   向有序且互不重叠的区间列表中插入一个新区间，并保持结果有序且无重叠。
    //
    // 核心考点：
    //   - 先收集左侧完全不重叠区间。
    //   - 中间重叠部分和 newInterval 合并。
    //   - 最后拼接右侧区间。
    static func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var answer: [[Int]] = []
        var index = 0
        var merged = newInterval

        while index < intervals.count && intervals[index][1] < merged[0] {
            answer.append(intervals[index])
            index += 1
        }

        while index < intervals.count && intervals[index][0] <= merged[1] {
            merged[0] = min(merged[0], intervals[index][0])
            merged[1] = max(merged[1], intervals[index][1])
            index += 1
        }
        answer.append(merged)

        while index < intervals.count {
            answer.append(intervals[index])
            index += 1
        }

        return answer
    }

    // ============================================================================
    // LeetCode #435: Non-Overlapping Intervals
    // ============================================================================
    // 所属模式：Overlapping Intervals（贪心）
    // 难度：Medium
    // 题目描述：
    //   删除最少数量的区间，使剩余区间互不重叠。
    //
    // 核心考点：
    //   - 经典区间贪心：优先保留结束更早的区间。
    //
    // 解题思路推导：
    //   一旦发生重叠，结束更早的区间为后续留下的空间更大，因此更值得保留。
    static func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 1 else { return 0 }
        let sortedIntervals = intervals.sorted { $0[1] < $1[1] }
        var count = 0
        var end = sortedIntervals[0][1]

        for interval in sortedIntervals.dropFirst() {
            if interval[0] < end {
                count += 1
            } else {
                end = interval[1]
            }
        }

        return count
    }
}

