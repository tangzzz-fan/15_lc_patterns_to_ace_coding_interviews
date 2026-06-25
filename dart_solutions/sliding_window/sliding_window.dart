/// ---------------------------------------------------------------------------
/// 模式：滑动窗口（Sliding Window）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 滑动窗口维护一个可变或固定大小的"窗口"，在数组或字符串上滑动。每次滑动时，
/// 只更新窗口边界的变化部分（新加入的元素和移除的元素），避免对整个窗口的重复计算。
/// 核心是"只处理进和出"，不重复处理窗口内不变的元素。
///
/// ## 适用场景
/// - 寻找满足特定条件的连续子数组或子串。
/// - 固定大小窗口：求最大平均值、最大和。
/// - 可变大小窗口：求最短/最长满足条件的子数组。
/// - 包含特定字符集的最小子串。
///
/// ## 常见分类
/// - 固定窗口大小：窗口大小固定，每次向右移动一格。
/// - 可变窗口大小：窗口右边界不断扩展，左边界根据条件收缩。
///
/// ## 时间复杂度
/// - O(n)，每个元素最多被加入窗口一次、移出窗口一次。
///
/// ## 空间复杂度
/// - 通常 O(k)，k 为字符集大小（用于存储窗口内元素频率）。

// ============================================================================
// LeetCode #643: Maximum Average Subarray I
// ============================================================================
// 所属模式：Sliding Window（滑动窗口 - 固定大小窗口）
// 难度：Easy
// 题目描述：
//   给定一个由 n 个元素组成的整数数组 nums 和一个整数 k。
//   找出长度为 k 的连续子数组，使其平均值最大。返回最大平均值。
//
// 核心考点：
//   - 固定大小滑动窗口的模板化实现。
//   - 避免重复计算窗口内元素和。
//
// 解题思路推导：
//   朴素做法：对每个长度为 k 的子数组求和，O(n*k)。
//   优化：窗口每次向右移动一格，新窗口的和 = 旧窗口的和 - 移出的左侧元素 + 新加入的右侧元素。
//   最大平均值 = 最大窗口和 / k。
//
// 实现步骤：
//   1. 计算初始窗口 [0, k-1] 的和 windowSum。
//   2. 初始化 maxSum = windowSum。
//   3. 遍历 i 从 k 到 n-1（i 是新加入元素的位置）：
//      a. windowSum = windowSum - nums[i - k] + nums[i]（减左侧 + 右侧）。
//      b. 更新 maxSum。
//   4. 返回 maxSum / k。

double findMaxAverage(List<int> nums, int k) {
  // 第 1 步：计算初始窗口 [0, k-1] 的和
  int windowSum = 0;
  for (int i = 0; i < k; i++) {
    windowSum += nums[i];
  }

  int maxSum = windowSum; // 当前最大窗口和

  // 第 2 步：滑动窗口
  // i 是新窗口的右边界（新加入的元素位置）
  for (int i = k; i < nums.length; i++) {
    // 核心操作：减去左边出窗元素，加上右边入窗元素
    windowSum = windowSum - nums[i - k] + nums[i];
    if (windowSum > maxSum) {
      maxSum = windowSum; // 更新最大值
    }
  }

  // 第 3 步：返回最大平均值
  return maxSum / k;
}

// ============================================================================
// LeetCode #3: Longest Substring Without Repeating Characters
// ============================================================================
// 所属模式：Sliding Window（滑动窗口 - 可变大小窗口）
// 难度：Medium
// 题目描述：
//   给定一个字符串 s，请找出其中不含有重复字符的最长子串的长度。
//
// 核心考点：
//   - 可变大小滑动窗口。
//   - 使用 Set/Map 跟踪窗口内字符。
//   - 窗口左边界如何收缩。
//
// 解题思路推导：
//   维护窗口 [left, right]，其中所有字符都不重复。
//   右指针 right 不断向右扩展：
//   - 如果 s[right] 不在窗口中，直接加入，更新最大长度。
//   - 如果 s[right] 已在窗口中，说明出现了重复。此时移动左指针 left 向右，
//     直到窗口中不再包含 s[right]，然后将 s[right] 加入窗口。
//
//   举例：s = "abcabcbb"
//   右指针 right=0(a): 窗口={a}, len=1
//   right=1(b): 窗口={a,b}, len=2
//   right=2(c): 窗口={a,b,c}, len=3
//   right=3(a): a 重复！移动 left：left=0→1(去掉 a) → left=1，窗口={b,c,a}, len=3
//   ...继续，最大长度 = 3
//
// 实现步骤：
//   1. 初始化 left = 0, maxLen = 0, Set<char> window = {}。
//   2. 遍历 right 从 0 到 s.length - 1：
//      a. while window.contains(s[right])：window.remove(s[left])，left++。
//      b. window.add(s[right])。
//      c. maxLen = max(maxLen, right - left + 1)。
//   3. 返回 maxLen。

int lengthOfLongestSubstring(String s) {
  // 使用 Set 记录当前窗口内的字符
  final Set<String> window = {};
  int left = 0; // 窗口左边界
  int maxLen = 0;

  for (int right = 0; right < s.length; right++) {
    String ch = s[right];

    // 如果当前字符已在窗口中，收缩左边界直到移出该字符
    while (window.contains(ch)) {
      window.remove(s[left]); // 移除窗口最左侧字符
      left++; // 左边界右移
    }

    // 将当前字符加入窗口
    window.add(ch);

    // 更新最大无重复子串长度
    int currentLen = right - left + 1;
    if (currentLen > maxLen) {
      maxLen = currentLen;
    }
  }

  return maxLen;
}

// ============================================================================
// LeetCode #76: Minimum Window Substring
// ============================================================================
// 所属模式：Sliding Window（滑动窗口 - 可变大小窗口）
// 难度：Hard
// 题目描述：
//   给定一个字符串 s 和一个字符串 t。返回 s 中涵盖 t 所有字符的最小子串。
//   若不存在，返回空字符串 ""。
//   注意：t 中可能存在重复字符，最小子串中字符出现次数不能少于 t 中。
//
// 核心考点：
//   - 可变大小滑动窗口 + 频率表。
//   - 判断窗口是否满足条件的技巧（使用计数器，避免每次遍历检查）。
//   - 收缩窗口的最优化。
//
// 解题思路推导：
//   1. 用 Map 统计 t 中每个字符需要的数量 need。
//   2. 维护窗口 [left, right]，用 Map 记录窗口内字符频率 window。
//   3. 用变量 matched 记录已满足需求的字符种类数（优化检查效率）。
//   4. 右指针扩展窗口，当 matched == need.length 时（窗口包含了 t 的所有字符），
//      尝试收缩左边界以获取最短子串。
//
//   举例：s = "ADOBECODEBANC", t = "ABC"
//   右移 right 直到包含 A、B、C → 收缩 left 去掉不必要的字符 ADOB → 记录 "BANC"
//   继续右移 → 再次收缩 → 记录更短的结果
//
// 实现步骤：
//   1. 构建 need 频率表。
//   2. 初始化 left = right = 0, matched = 0, minLen = 无穷大, start = 0。
//   3. 遍历 right 从 0 到 s.length - 1：
//      a. 将 s[right] 加入窗口。
//      b. 如果窗口中该字符数量 == need 中需要数量，matched++。
//      c. 当 matched == need.length 时（窗口有效）：
//         - 尝试收缩左边界：如果 s[left] 不在 need 中或窗口内数量 > need，
//           可以安全移除。
//         - 每次收缩后更新 minLen 和 start。
//      d. 移除 s[left]，left++。
//   4. 如果 minLen 未更新，返回 ""；否则返回 s.substring(start, start + minLen)。

String minWindow(String s, String t) {
  // need：统计 t 中每个字符的需要数量
  final Map<String, int> need = {};
  for (int i = 0; i < t.length; i++) {
    String ch = t[i];
    need[ch] = (need[ch] ?? 0) + 1;
  }

  // window：当前窗口内各字符的数量
  final Map<String, int> window = {};

  int left = 0;
  int matched = 0; // 已满足需求的字符种类数
  int minLen = s.length + 1; // 初始化一个极大值
  int start = 0; // 记录最短子串的起始位置

  for (int right = 0; right < s.length; right++) {
    String ch = s[right];
    window[ch] = (window[ch] ?? 0) + 1;

    // 检查当前字符是否满足了 t 中的需求
    if (need.containsKey(ch) && window[ch] == need[ch]) {
      matched++; // 该字符的需求已完全满足
    }

    // 当窗口包含了 t 的所有字符，尝试收缩
    while (matched == need.length) {
      // 更新最短子串
      int currentLen = right - left + 1;
      if (currentLen < minLen) {
        minLen = currentLen;
        start = left;
      }

      // 收缩：移除左边界字符
      String leftChar = s[left];
      window[leftChar] = window[leftChar]! - 1;

      // 如果移除后该字符在窗口中的数量小于需求，matched 失效
      if (need.containsKey(leftChar) && window[leftChar]! < need[leftChar]!) {
        matched--; // 不再满足该字符的需求
      }

      left++; // 左边界右移
    }
  }

  // 如果 minLen 未被更新，说明没有找到这样的子串
  if (minLen > s.length) return '';
  return s.substring(start, start + minLen);
}
