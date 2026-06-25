/// ---------------------------------------------------------------------------
/// 模式：前缀和（Prefix Sum）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 前缀和是一种预处理技术。构建一个前缀和数组 `prefix`，其中 `prefix[i]` 表示原数组
/// 从下标 0 到下标 i 的所有元素之和。这样任意区间 [i, j] 的和可以在 O(1) 时间内通过
/// `prefix[j] - prefix[i - 1]` 得到。
///
/// ## 适用场景
/// - 需要多次查询子数组的和。
/// - 需要计算区间内的累积值（求和、计数、异或等）。
/// - 涉及"和为 K 的子数组个数"这类问题。
/// - 二维矩阵的区间求和。
///
/// ## 时间复杂度
/// - 构建前缀和数组：O(n)
/// - 单次区间查询：O(1)
///
/// ## 空间复杂度
/// - O(n) 用于存储前缀和数组（或 O(1) 如果可以原地修改原数组）。
///
/// ## 常见变体
/// - 前缀和 + 哈希表：用于统计满足特定条件的子数组个数（如和为 K）。
/// - 前缀积：用于区间乘积查询。
/// - 差分数组：用于区间增减操作。
/// - 二维前缀和：用于矩阵的区间求和。

// ============================================================================
// LeetCode #303: Range Sum Query - Immutable（Easy）
// ============================================================================
// 题目描述：
//   给定一个整数数组 nums，实现 NumArray 类：
//   - NumArray(int[] nums)：用数组 nums 初始化对象。
//   - int sumRange(int left, int right)：返回数组 nums 中下标 left 到 right
//     （包含 left 和 right）之间的元素之和。
// 要求 sumRange 查询为 O(1) 时间。
//
// 解题思路：
//   1. 构造函数中构建前缀和数组 _prefix
//   2. _prefix[i] = 前 i+1 个元素的和
//   3. sumRange(left, right):
//      - 如果 left == 0 → 返回 _prefix[right]
//      - 否则 → 返回 _prefix[right] - _prefix[left - 1]
//
// 实现步骤：
//   1. 声明私有字段 _prefix（List<int>）
//   2. 构造函数中：
//      a. 初始化 _prefix，长度与 nums 相同
//      b. 第一个元素：_prefix[0] = nums[0]
//      c. 循环 i 从 1 到 n-1：_prefix[i] = _prefix[i-1] + nums[i]
//   3. sumRange 方法中：
//      a. 如果 left == 0 → 返回 _prefix[right]
//      b. 否则 → 返回 _prefix[right] - _prefix[left - 1]

class NumArray {
  // TODO: 声明私有前缀和数组 _prefix

  NumArray(List<int> nums)
    // TODO: 初始化 _prefix 数组
    // TODO: _prefix[0] = nums[0]
    // TODO: for i in 1..n-1: _prefix[i] = _prefix[i-1] + nums[i]
  {
    throw UnimplementedError(); // 请替换为你的实现
  }

  int sumRange(int left, int right) {
    // TODO: 如果 left == 0，返回 _prefix[right]
    // TODO: 否则返回 _prefix[right] - _prefix[left - 1]
    throw UnimplementedError(); // 请替换为你的实现
  }
}

// ============================================================================
// LeetCode #525: Contiguous Array（Medium）
// ============================================================================
// 题目描述：
//   给定一个二进制数组 nums（元素只包含 0 和 1），找到含有相同数量的 0 和 1 的
//   最长连续子数组，并返回其长度。
//
// 核心技巧：
//   将 0 视为 -1，问题转化为"和为 0 的最长子数组"
//
// 解题思路：
//   1. 使用 HashMap 记录每个前缀和首次出现的位置
//   2. 遇 1 → 前缀和 +1，遇 0 → 前缀和 -1
//   3. 如果当前前缀和在 map 中已存在 → 说明中间一段的 0 和 1 数量相等
//   4. 子数组长度 = 当前位置 - 该前缀和首次出现的位置
//
// 实现步骤：
//   1. 创建 Map<int, int>，key=前缀和，value=首次出现的下标
//   2. map[0] = -1（前缀和为 0 出现在下标 -1 处）
//   3. 初始化 maxLen = 0, count = 0
//   4. 遍历数组 i 从 0 到 n-1：
//      a. count += (nums[i] == 1 ? 1 : -1)
//      b. 如果 map.containsKey(count)：
//         - len = i - map[count]!
//         - 更新 maxLen = max(maxLen, len)
//      c. 否则：map[count] = i
//   5. 返回 maxLen

int findMaxLength(List<int> nums) {
  // TODO: 创建 HashMap，初始化 map[0] = -1
  // TODO: 遍历数组：
  //       - 遇 1 加 1，遇 0 减 1（维护前缀和 count）
  //       - 若 count 已存在 → 计算长度并更新 maxLen
  //       - 否则 → 记录该前缀和首次出现位置
  // TODO: 返回 maxLen
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #560: Subarray Sum Equals K（Medium）
// ============================================================================
// 题目描述：
//   给定一个整数数组 nums 和一个整数 k，返回数组中和为 k 的连续子数组的个数。
//
// 核心技巧：
//   子数组 (i..j) 的和 = k 等价于 prefix[j] - prefix[i-1] = k
//   即 prefix[i-1] = prefix[j] - k
//   遍历到位置 j 时，只需查找前面有多少个位置的前缀和等于 currentSum - k
//
// 解题思路：
//   1. HashMap：key=前缀和，value=该前缀和出现的次数
//   2. 初始 map[0] = 1（空子数组的前缀和为 0）
//   3. 遍历时，每次查找 map 中 currentSum - k 的出现次数，累加到结果
//   4. 更新当前前缀和的出现次数
//
// 实现步骤：
//   1. 创建 Map<int, int>，初始化 map[0] = 1
//   2. 初始化 count = 0, currentSum = 0
//   3. 遍历 nums：
//      a. currentSum += num
//      b. target = currentSum - k
//      c. 如果 map.containsKey(target) → count += map[target]!
//      d. map[currentSum] = (map[currentSum] ?? 0) + 1
//   4. 返回 count

int subarraySum(List<int> nums, int k) {
  // TODO: 创建 HashMap，初始化 map[0] = 1
  // TODO: 遍历数组：
  //       - 维护 currentSum
  //       - 查找 currentSum - k 在 map 中的出现次数，累加到 count
  //       - 更新 map[currentSum] 的出现次数
  // TODO: 返回 count
  throw UnimplementedError(); // 请替换为你的实现
}
