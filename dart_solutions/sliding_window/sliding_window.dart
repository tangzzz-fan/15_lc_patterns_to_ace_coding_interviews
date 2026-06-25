/// ---------------------------------------------------------------------------
/// 模式：滑动窗口（Sliding Window）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 维护一个可变或固定大小的"窗口"，在数组或字符串上滑动。每次滑动时，
/// 只更新窗口边界的变化部分（新加入的元素和移除的元素），避免对整个窗口的重复计算。
///
/// ## 分类
/// - 固定窗口：窗口大小 k 不变，每次整体向右移一格。
/// - 可变窗口：右边界不断扩展，左边界根据条件收缩。
///
/// ## 适用场景
/// - 寻找满足特定条件的连续子数组/子串。
/// - 固定窗口：求最大平均值、最大和。
/// - 可变窗口：求最短/最长满足条件的子数组。
/// - 包含特定字符集的最小子串。
///
/// ## 时间复杂度
/// - O(n)，每个元素最多入窗一次、出窗一次。
///
/// ## 空间复杂度
/// - 通常 O(k)，k 为字符集大小。

// ============================================================================
// LeetCode #643: Maximum Average Subarray I（Easy）
// ============================================================================
// 题目描述：
//   给定整数数组 nums 和整数 k。找出长度为 k 的连续子数组，使其平均值最大。
//   返回最大平均值。
//
// 解题思路（固定大小窗口）：
//   - 初始窗口 [0, k-1] 的和
//   - 每次右移：windowSum = windowSum - nums[i - k] + nums[i]
//   - 最大平均值 = maxSum / k
//
// 实现步骤：
//   1. 计算初始窗口 [0, k-1] 的和 windowSum
//   2. maxSum = windowSum
//   3. 遍历 i 从 k 到 n-1：
//      windowSum = windowSum - nums[i - k] + nums[i]
//      更新 maxSum
//   4. 返回 maxSum / k

double findMaxAverage(List<int> nums, int k) {
  // TODO: 计算初始窗口 [0, k-1] 的和
  // TODO: maxSum = 初始窗口和
  // TODO: 滑动窗口 i 从 k 到 n-1：
  //       减去 nums[i-k]，加上 nums[i]
  //       更新 maxSum
  // TODO: 返回 maxSum / k
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #3: Longest Substring Without Repeating Characters（Medium）
// ============================================================================
// 题目描述：
//   给定一个字符串 s，找出其中不含有重复字符的最长子串的长度。
//
// 解题思路（可变大小窗口）：
//   - 右指针不断右移，拓展窗口
//   - 当遇到重复字符时，左指针右移直到窗口内无重复
//   - 用 Set 维护窗口内的字符集合
//
// 实现步骤：
//   1. left = 0, maxLen = 0, Set<char> window = {}
//   2. 遍历 right 从 0 到 s.length - 1：
//      a. while window.contains(s[right])：
//         - window.remove(s[left]); left++
//      b. window.add(s[right])
//      c. maxLen = max(maxLen, right - left + 1)
//   3. 返回 maxLen

int lengthOfLongestSubstring(String s) {
  // TODO: 创建 Set 维护窗口字符
  // TODO: left = 0, maxLen = 0
  // TODO: 遍历 right：
  //       - 收缩左边界直到无重复
  //       - 加入当前字符
  //       - 更新 maxLen
  // TODO: 返回 maxLen
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #76: Minimum Window Substring（Hard）
// ============================================================================
// 题目描述：
//   给定字符串 s 和 t。返回 s 中涵盖 t 所有字符的最小子串。若不存在，返回 ""。
//   t 中可能有重复字符，最小子串中字符出现次数不能少于 t 中。
//
// 解题思路（可变大小窗口 + 频率统计）：
//   1. 用 Map 统计 t 中字符需求 need
//   2. 用 Map 统计当前窗口字符频率 window
//   3. 用 matched 变量追踪已满足需求的字符种类数（优化：避免每次都遍历比较）
//   4. 当 matched == need.length 时，尝试收缩左边界以获取更短子串
//
// 实现步骤：
//   1. 构建 need Map：统计 t 中每个字符的需求量
//   2. left = 0, matched = 0, minLen = ∞, start = 0
//   3. 遍历 right 从 0 到 s.length - 1：
//      a. 将 s[right] 加入 window，若该字符数量满足 need 要求 → matched++
//      b. while matched == need.length（窗口已有效）：
//         - 更新 minLen 和 start
//         - 移除 s[left]：如果移除后某字符不满足需求 → matched--
//         - left++
//   4. 返回 s.substring(start, start + minLen)（若 minLen 未更新则返回 ""）

String minWindow(String s, String t) {
  // TODO: 构建 need Map（t 中每个字符的需求量）
  // TODO: 创建 window Map、left=0、matched=0、minLen=极大值、start=0
  // TODO: 遍历 right：
  //       - 将 s[right] 加入 window
  //       - 若满足需求 → matched++
  //       - 收缩左边界，更新最短子串
  // TODO: 返回最短子串
  throw UnimplementedError(); // 请替换为你的实现
}
