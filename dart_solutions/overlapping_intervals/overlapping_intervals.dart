/// ---------------------------------------------------------------------------
/// 模式：重叠区间（Overlapping Intervals）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 处理所有涉及区间合并、插入、去重的问题。核心步骤：
/// 1. 按区间的开始时间排序（关键前提）。
/// 2. 遍历排序后的区间列表，判断当前区间是否与"已合并区间"重叠。
/// 3. 重叠 → 合并（取较大结束时间）；不重叠 → 作为新区间加入结果。
///
/// ## 适用场景
/// - 合并重叠区间。
/// - 插入新区间到有序区间列表。
/// - 计算最少需要删除多少区间使剩余互不重叠。
/// - 会议室安排问题。
/// - 区间交集计算。
///
/// ## 时间复杂度
/// - O(n log n)，排序最耗时；遍历 O(n)。
///
/// ## 空间复杂度
/// - O(n) 存储结果，或 O(1) 原地修改。

// ============================================================================
// LeetCode #56: Merge Intervals（Medium）
// ============================================================================
// 题目描述：
//   以数组 intervals 表示若干个区间，其中 intervals[i] = [start_i, end_i]。
//   合并所有重叠的区间，返回一个不重叠的区间数组。
//
// 解题思路：
//   1. 按 start 升序排序
//   2. 遍历区间，维护 merged 列表：
//      - 当前区间 start > merged 最后一个的 end → 不重叠，直接加入
//      - 否则 → 重叠，扩展 merged 最后一个的 end = max(end, 当前.end)
//
// 实现步骤：
//   1. 如果 intervals 为空，返回 []
//   2. intervals.sort((a, b) => a[0].compareTo(b[0]))
//   3. 初始化 merged = []
//   4. 遍历 intervals：
//      a. 若 merged 为空或 interval[0] > merged.last[1] → merged.add(拷贝)
//      b. 否则 → merged.last[1] = max(merged.last[1], interval[1])
//   5. 返回 merged

List<List<int>> merge(List<List<int>> intervals) {
  // TODO: 边界检查（空数组）
  // TODO: 按 start 排序
  // TODO: 遍历区间，判断重叠并合并
  // TODO: 返回 merged
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #57: Insert Interval（Medium）
// ============================================================================
// 题目描述：
//   给定一个无重叠的、按起始端点排序的区间列表，插入新区间 newInterval，
//   合并所有重叠区间后返回新区间列表。
//
// 解题思路（三阶段遍历）：
//   阶段 1：所有 end < newStart 的区间 → 直接加入
//   阶段 2：所有 start <= newEnd 的区间 → 与新区间合并（动态更新 newStart/newEnd）
//   阶段 3：剩余区间 → 直接加入
//
// 实现步骤：
//   1. 初始化 result = [], i = 0
//   2. 阶段 1：while i < n && intervals[i][1] < newStart → result.add(), i++
//   3. 阶段 2：while i < n && intervals[i][0] <= newEnd → 合并 newStart/newEnd, i++
//   4. result.add([newStart, newEnd])
//   5. 阶段 3：while i < n → result.add(), i++
//   6. 返回 result

List<List<int>> insert(List<List<int>> intervals, List<int> newInterval) {
  // TODO: 阶段 1：加入所有完全在新区间左侧的区间
  // TODO: 阶段 2：合并所有重叠区间
  // TODO: 加入合并后的新区间
  // TODO: 阶段 3：加入剩余区间
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #435: Non-Overlapping Intervals（Medium）
// ============================================================================
// 题目描述：
//   给定区间集合，找出需要移除的最小区间数量，使剩余区间互不重叠。
//   注意：[1,2] 和 [2,3] 不算重叠（边界接触可接受）。
//
// 解题思路（贪心 - 按 end 排序）：
//   这是"活动选择问题"。贪心策略：每次选择结束时间最早的区间，
//   留给后面的空间最大，可容纳最多区间。
//   为什么按 end 而不是 start 排序？
//   按 start 可能选了开始早但很长的区间，挤占了后面的多个短区间。
//   按 end 排序保证每次选"最早结束"的，给后面留出最多空间。
//
// 实现步骤：
//   1. 如果 intervals 为空，返回 0
//   2. 按 intervals[i][1]（结束时间）升序排序
//   3. count = 1（第一个区间一定选），lastEnd = intervals[0][1]
//   4. 遍历 i 从 1 到 n-1：
//      a. 如果 intervals[i][0] >= lastEnd → count++, lastEnd = intervals[i][1]
//      b. 否则 → 需要移除当前区间（跳过，不计入 count）
//   5. 返回 n - count

int eraseOverlapIntervals(List<List<int>> intervals) {
  // TODO: 边界检查
  // TODO: 按 end 升序排序
  // TODO: 贪心：每次选结束时间最早的区间
  // TODO: 返回 总数 - 最多能保留的区间数
  throw UnimplementedError(); // 请替换为你的实现
}
