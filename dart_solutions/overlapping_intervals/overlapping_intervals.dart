/// ---------------------------------------------------------------------------
/// 模式：重叠区间（Overlapping Intervals）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 处理所有涉及区间合并、插入、去重的问题。核心步骤：
/// 1. 按区间的开始时间排序（不排序则无法一次性遍历处理）。
/// 2. 遍历排序后的区间列表，判断当前区间与"已合并区间"是否有重叠。
/// 3. 如果有重叠，更新已合并区间的结束时间（取较大值）；否则，将当前区间作为新的独立区间。
///
/// ## 适用场景
/// - 合并重叠区间。
/// - 插入新区间到有序区间列表。
/// - 计算最少需要删除多少区间使剩余区间不重叠。
/// - 会议室安排问题。
/// - 区间交集计算。
///
/// ## 时间复杂度
/// - O(n log n)，排序最耗时；遍历区间 O(n)。
///
/// ## 空间复杂度
/// - O(n) 用于存储结果，或 O(1) 若原地修改。

// ============================================================================
// LeetCode #56: Merge Intervals
// ============================================================================
// 所属模式：Overlapping Intervals（重叠区间合并）
// 难度：Medium
// 题目描述：
//   以数组 intervals 表示若干个区间的集合，其中 intervals[i] = [start_i, end_i]。
//   请合并所有重叠的区间，返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。
//
// 核心考点：
//   - 按 start 排序。
//   - 判断区间是否重叠：当前区间的 start <= 已合并区间的 end。
//   - 合并：end = max(已合并区间的 end, 当前区间的 end)。
//
// 解题思路推导：
//   1. 按开始时间排序，保证可以线性扫描。
//   2. 用一个列表 merged 存储合并结果。
//   3. 遍历每个区间：
//      - 如果 merged 为空，或当前区间 start > merged[-1].end → 不重叠，直接加入。
//      - 否则（重叠）→ 更新 merged[-1].end = max(merged[-1].end, 当前.end)。
//
//   举例：[[1,3],[2,6],[8,10],[15,18]]
//   排序后（已有序）：同上
//   [1,3]：merged=[[1,3]]
//   [2,6]：2<=3，重叠 → merged[-1].end = max(3,6)=6 → merged=[[1,6]]
//   [8,10]：8>6，不重叠 → merged=[[1,6],[8,10]]
//   [15,18]：15>10，不重叠 → merged=[[1,6],[8,10],[15,18]]
//
// 实现步骤：
//   1. 按照 intervals[i][0] 升序排序。
//   2. 初始化 merged = []。
//   3. 遍历 intervals 中的每个区间：
//      a. 若 merged 为空 或 interval[0] > merged.last[1] → merged.add(interval)。
//      b. 否则 → merged.last[1] = max(merged.last[1], interval[1])。
//   4. 返回 merged。

List<List<int>> merge(List<List<int>> intervals) {
  if (intervals.isEmpty) return [];

  // 按区间开始时间升序排序
  intervals.sort((a, b) => a[0].compareTo(b[0]));

  List<List<int>> merged = [];
  for (List<int> interval in intervals) {
    // 如果结果列表为空，或当前区间与上一个不重叠，直接加入
    if (merged.isEmpty || interval[0] > merged.last[1]) {
      merged.add([interval[0], interval[1]]); // 不重叠，独立加入
    } else {
      // 重叠：扩展上一个区间的结束时间
      if (interval[1] > merged.last[1]) {
        merged.last[1] = interval[1]; // 取较大结束时间
      }
    }
  }

  return merged;
}

// ============================================================================
// LeetCode #57: Insert Interval
// ============================================================================
// 所属模式：Overlapping Intervals（重叠区间 - 插入新区间）
// 难度：Medium
// 题目描述：
//   给定一个无重叠的、按区间起始端点排序的区间列表 intervals，插入一个新的区间
//   newInterval，合并所有重叠的区间，返回新的区间列表。
//
// 核心考点：
//   - 分类讨论：新区间与已有区间的关系（左侧、重叠、右侧）。
//   - 利用区间已排序的性质，线性遍历一次完成。
//   - 不需要排序（输入已有序）。
//
// 解题思路推导：
//   将遍历过程分为三个阶段：
//   - 阶段 1（左侧）：当前区间 end < newStart → 无交集，直接加入结果。
//   - 阶段 2（重叠）：当前区间 start <= newEnd → 有交集，合并（动态更新 newStart/newEnd）。
//   - 阶段 3（右侧）：当前区间 start > newEnd → 后面的都不会重叠了。
//
//   举例：intervals=[[1,3],[6,9]], newInterval=[2,5]
//   [1,3]：end=3 >= newStart=2 → 进入重叠阶段，合并为 [min(1,2), max(3,5)]=[1,5]
//   [6,9]：start=6 > newEnd=5 → 结束重叠，加入结果
//   结果：[[1,5],[6,9]]
//
// 实现步骤：
//   1. 初始化 result = [], i = 0。
//   2. 阶段 1：while i < n 且 intervals[i][1] < newInterval[0]：
//      - result.add(intervals[i]), i++。
//   3. 阶段 2：while i < n 且 intervals[i][0] <= newInterval[1]：
//      - newInterval[0] = min(newInterval[0], intervals[i][0])
//      - newInterval[1] = max(newInterval[1], intervals[i][1]), i++
//   4. result.add(newInterval)（合并后的区间加入）。
//   5. 阶段 3：while i < n → result.add(intervals[i]), i++。
//   6. 返回 result。

List<List<int>> insert(List<List<int>> intervals, List<int> newInterval) {
  List<List<int>> result = [];
  int i = 0;
  int n = intervals.length;
  int newStart = newInterval[0];
  int newEnd = newInterval[1];

  // 阶段 1：添加所有完全在新区间左侧的区间（end < newStart）
  while (i < n && intervals[i][1] < newStart) {
    result.add(intervals[i]);
    i++;
  }

  // 阶段 2：合并所有与新区间重叠的区间
  while (i < n && intervals[i][0] <= newEnd) {
    newStart = newStart < intervals[i][0] ? newStart : intervals[i][0]; // min
    newEnd = newEnd > intervals[i][1] ? newEnd : intervals[i][1]; // max
    i++;
  }
  result.add([newStart, newEnd]); // 加入合并后的新区间

  // 阶段 3：添加所有剩余区间（start > newEnd）
  while (i < n) {
    result.add(intervals[i]);
    i++;
  }

  return result;
}

// ============================================================================
// LeetCode #435: Non-Overlapping Intervals
// ============================================================================
// 所属模式：Overlapping Intervals（重叠区间 - 删除最少区间）
// 难度：Medium
// 题目描述：
//   给定一个区间的集合，找出需要移除的最小区间数量，使剩余区间互不重叠。
//   注意：边界接触（[1,2] 和 [2,3]）不算重叠。
//
// 核心考点：
//   - 贪心策略：按结束时间排序。
//   - 每次选择结束时间最早的区间，可以保留最多的不重叠区间。
//   - 最终结果 = 总区间数 - 最多不重叠区间数。
//
// 解题思路推导：
//   这是经典的"活动选择问题"（区间调度问题）。
//   贪心策略：按 end 升序排序。每次选择结束时间最早的区间，
//   这样留给后续区间的空间最大，能容纳最多的区间。
//
//   为什么按 end 排序而不是 start？
//   按 start 排序可能导致选了很长但开始早的区间，错过后面的短区间。
//   按 end 排序确保每次选的都是"结束最早"的，给后面留出最多空间。
//
//   举例：[[1,2],[2,3],[3,4],[1,3]]
//   按 end 排序：[[1,2],[2,3],[1,3],[3,4]]
//   选 [1,2], lastEnd=2 → 选 [2,3], lastEnd=3 → 跳过 [1,3]（重叠）
//   → 选 [3,4], lastEnd=4
//   最多保留 3 个 → 最少移除 1 个
//
// 实现步骤：
//   1. 按 intervals[i][1]（结束时间）升序排序。
//   2. 初始化 count = 1（第一个区间一定选），lastEnd = intervals[0][1]。
//   3. 遍历 i 从 1 到 n-1：
//      a. 若 intervals[i][0] >= lastEnd（不重叠）：
//         - count++（保留此区间）。
//         - lastEnd = intervals[i][1]。
//   4. 返回 n - count（需要移除的区间数）。

int eraseOverlapIntervals(List<List<int>> intervals) {
  if (intervals.isEmpty) return 0;

  // 按结束时间升序排序（贪心策略的关键）
  intervals.sort((a, b) => a[1].compareTo(b[1]));

  int count = 1; // 至少可以保留 1 个区间
  int lastEnd = intervals[0][1]; // 第一个选中的区间的结束时间

  for (int i = 1; i < intervals.length; i++) {
    // 当前区间开始时间 >= 上一个选中区间的结束时间 → 不重叠
    if (intervals[i][0] >= lastEnd) {
      count++; // 保留此区间
      lastEnd = intervals[i][1]; // 更新最近结束时间
    }
    // 否则重叠，需要移除当前区间（什么都不做，计数隐含地被跳过了）
  }

  return intervals.length - count; // 移除的区间数 = 总数 - 保留数
}
