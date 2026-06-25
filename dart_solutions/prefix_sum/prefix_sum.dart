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
// LeetCode #303: Range Sum Query - Immutable
// ============================================================================
// 所属模式：Prefix Sum（前缀和）
// 难度：Easy
// 题目描述：
//   给定一个整数数组 nums，实现 NumArray 类：
//   - NumArray(int[] nums)：用数组 nums 初始化对象。
//   - int sumRange(int left, int right)：返回数组 nums 中下标 left 到 right
//     （包含 left 和 right）之间的元素之和。
//
// 核心考点：
//   - 前缀和的构建与查询
//   - 将 O(n) 查询优化到 O(1)
//
// 解题思路推导：
//   朴素做法：每次调用 sumRange 都遍历 [left, right]，O(n) 时间。
//   优化思路：预处理数组，构建前缀和。`prefix[i]` 表示前 i+1 个元素的和。
//   那么 sumRange(left, right) = prefix[right] - prefix[left - 1]（left > 0 时）
//   若 left == 0，直接返回 prefix[right]。
//
// 实现步骤：
//   1. 在构造函数中构建前缀和数组 prefix。
//   2. prefix[0] = nums[0]。
//   3. 对于 i 从 1 到 n-1：prefix[i] = prefix[i-1] + nums[i]。
//   4. sumRange 方法中：
//      - 如果 left == 0，返回 prefix[right]。
//      - 否则，返回 prefix[right] - prefix[left - 1]。

class NumArray {
  final List<int> _prefix;

  // 构造函数：初始化前缀和数组
  // 时间复杂度 O(n)，空间复杂度 O(n)
  NumArray(List<int> nums)
      : _prefix = List<int>.filled(nums.length, 0) {
    if (nums.isNotEmpty) {
      _prefix[0] = nums[0]; // 第一个元素的前缀和就是它本身
      for (int i = 1; i < nums.length; i++) {
        _prefix[i] = _prefix[i - 1] + nums[i]; // 逐步累加构建前缀和
      }
    }
  }

  // 查询区间和：O(1) 时间
  // left, right 为下标（包含区间两端）
  int sumRange(int left, int right) {
    if (left == 0) return _prefix[right];
    // 区间 [left, right] 的和 = 前 right+1 个元素的和 - 前 left 个元素的和
    return _prefix[right] - _prefix[left - 1];
  }
}

// ============================================================================
// LeetCode #525: Contiguous Array
// ============================================================================
// 所属模式：Prefix Sum（前缀和）+ HashMap
// 难度：Medium
// 题目描述：
//   给定一个二进制数组 nums（元素只包含 0 和 1），找到含有相同数量的 0 和 1 的
//   最长连续子数组，返回其长度。
//
// 核心考点：
//   - 将"0 和 1 数量相等"转化为前缀和相等的问题。
//   - 使用哈希表记录每个前缀和首次出现的位置。
//   - 巧妙转化：将 0 视为 -1，问题变为"和为 0 的最长子数组"。
//
// 解题思路推导：
//   设 nums[i] 为 1 时贡献 +1，为 0 时贡献 -1。
//   构建前缀和 prefix[i]（按上述规则计算）。
//   如果 prefix[j] == prefix[i]，说明子数组 [i+1, j] 中 +1 和 -1 数量相等，
//   即 0 和 1 的数量相等！长度 = j - i。
//
//   举例：nums = [0,1,0]，转化后为 [-1,1,-1]
//   计算前缀和（从 index 0 前开始）：-1, 0, -1
//   第一次出现 -1 在 index 0，再次出现 -1 在 index 2
//   长度 = 2 - 0 = 2，即子数组 [0,1] 有相同数量的 0 和 1 ✓
//
// 实现步骤：
//   1. 创建 HashMap，key = 前缀和，value = 该前缀和首次出现的下标。
//   2. 初始化 map[0] = -1（表示前缀和为 0 出现在下标 -1 处）。
//   3. 遍历数组，计算当前前缀和 count（遇 1 加 1，遇 0 减 1）。
//   4. 若 count 已在 map 中：更新最大长度 = max(最大长度, i - map[count])。
//   5. 若 count 不在 map 中：记录 map[count] = i。
//   6. 返回最大长度。

int findMaxLength(List<int> nums) {
  // 哈希表：记录每个前缀和首次出现的位置
  final Map<int, int> map = {};

  // 初始化：前缀和为 0 时，位置记为 -1（在数组开始之前）
  map[0] = -1;

  int maxLen = 0;
  int count = 0; // 当前前缀和（1 视为 +1，0 视为 -1）

  for (int i = 0; i < nums.length; i++) {
    // 遇 1 加 1，遇 0 减 1
    count += (nums[i] == 1) ? 1 : -1;

    if (map.containsKey(count)) {
      // 相同前缀和再次出现 → 中间子数组的 0 和 1 数量相等
      int len = i - map[count]!; // 计算子数组长度
      if (len > maxLen) {
        maxLen = len; // 更新最大长度
      }
    } else {
      // 第一次遇到该前缀和，记录位置
      map[count] = i;
    }
  }

  return maxLen;
}

// ============================================================================
// LeetCode #560: Subarray Sum Equals K
// ============================================================================
// 所属模式：Prefix Sum（前缀和）+ HashMap
// 难度：Medium
// 题目描述：
//   给定一个整数数组 nums 和一个整数 k，返回数组中和为 k 的连续子数组的个数。
//
// 核心考点：
//   - 前缀和与哈希表结合，统计满足特定和的子数组个数。
//   - 公式转换：sum(i..j) = k → prefix[j] - prefix[i-1] = k
//     → prefix[i-1] = prefix[j] - k
//
// 解题思路推导：
//   当前前缀和为 currentSum。
//   我们想知道：前面有多少个位置 i，使得 prefix[i] == currentSum - k。
//   因为对于这些 i，子数组 [i+1..当前位置] 的和 = k。
//
//   举例：nums = [1,1,1], k = 2
//   遍历过程：
//   i=0: currentSum=1, 需要 prefix=-1（不存在），记录 prefix[1]=1
//   i=1: currentSum=2, 需要 prefix=0（存在，出现 1 次），count+=1，记录 prefix[2]=1
//   i=2: currentSum=3, 需要 prefix=1（存在，出现 1 次），count+=1，记录 prefix[3]=1
//   结果：count = 2（子数组 [0,1] 和 [1,2]）
//
// 实现步骤：
//   1. 创建 HashMap，key = 前缀和，value = 该前缀和出现的次数。
//   2. 初始化 map[0] = 1（前缀和为 0 出现 1 次，处理从开头开始的子数组）。
//   3. 遍历数组，维护当前前缀和 currentSum。
//   4. 每次检查 map 中是否存在 currentSum - k：
//      - 若存在，将其次数累加到结果 count 中。
//   5. 更新 map[currentSum] = map[currentSum] + 1。
//   6. 返回 count。

int subarraySum(List<int> nums, int k) {
  // 哈希表：记录每个前缀和出现的次数
  final Map<int, int> map = {};

  // 初始化：前缀和为 0 出现 1 次
  map[0] = 1;

  int count = 0;
  int currentSum = 0;

  for (int i = 0; i < nums.length; i++) {
    currentSum += nums[i]; // 当前前缀和

    // 查找之前有多少个位置的前缀和等于 currentSum - k
    // 这些位置到当前位置的子数组和就是 k
    int target = currentSum - k;
    if (map.containsKey(target)) {
      count += map[target]!; // 累加所有可能的起点
    }

    // 记录当前前缀和的出现次数
    map[currentSum] = (map[currentSum] ?? 0) + 1;
  }

  return count;
}
