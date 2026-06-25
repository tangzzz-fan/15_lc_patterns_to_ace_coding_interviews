/// ---------------------------------------------------------------------------
/// 模式：双指针（Two Pointers）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 双指针技术使用两个指针从数组的两端或同一端开始遍历，将 O(n²) 的暴力枚举优化到 O(n)。
/// 常见变体：
/// - 对撞指针：左右指针分别从两端向中间移动（用于有序数组）。
/// - 同向指针：两个指针同向移动，一个快一个慢。
///
/// ## 适用场景
/// - 在排序数组中查找满足特定条件的元素对。
/// - 三数之和 / 四数之和问题。
/// - 盛水最多的容器等面积问题。
/// - 回文串验证。
///
/// ## 时间复杂度
/// - 通常为 O(n)，加上排序则为 O(n log n)。
///
/// ## 空间复杂度
/// - O(1)，只使用常量额外空间。

// ============================================================================
// LeetCode #167: Two Sum II - Input Array is Sorted（Medium）
// ============================================================================
// 题目描述：
//   给定一个已按非递减顺序排序的整数数组 numbers，找出两个数使它们的和等于目标数 target。
//   返回这两个数的下标（从 1 开始计数）。假设每个输入只有唯一解。
//
// 解题思路（对撞指针）：
//   数组已排序 → 左指针指向最小，右指针指向最大
//   计算 sum = numbers[left] + numbers[right]：
//     - sum == target → 找到
//     - sum < target → left++（需要更大的和）
//     - sum > target → right--（需要更小的和）
//
// 实现步骤：
//   1. left = 0, right = numbers.length - 1
//   2. while left < right：
//      a. sum = numbers[left] + numbers[right]
//      b. 如果 sum == target → 返回 [left + 1, right + 1]
//      c. 如果 sum < target → left++
//      d. 如果 sum > target → right--
//   3. 返回 []（题目保证有解，不会走到这里）

List<int> twoSum(List<int> numbers, int target) {
  // TODO: left = 0, right = numbers.length - 1
  // TODO: while left < right:
  //       计算 sum，根据 sum 与 target 的关系决定 left++ 还是 right--
  // TODO: 返回 [left + 1, right + 1]（1-based 下标）
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #15: 3Sum（Medium）
// ============================================================================
// 题目描述：
//   给定一个包含 n 个整数的数组 nums，找出所有满足 a + b + c = 0 且不重复的三元组。
//
// 解题思路（排序 + 双指针）：
//   1. 排序数组
//   2. 固定第一个数 nums[i]，问题降维为在 [i+1, n-1] 中找两数之和 = -nums[i]
//   3. 去重：跳过重复的 nums[i]、nums[left]、nums[right]
//
// 实现步骤：
//   1. 对数组排序
//   2. 循环 i 从 0 到 n-3：
//      a. 如果 nums[i] > 0 → break（后面的数都大于 0，三数和不可能为 0）
//      b. 如果 i > 0 且 nums[i] == nums[i-1] → continue（去重）
//      c. left = i + 1, right = n - 1
//      d. while left < right：
//         - sum = nums[i] + nums[left] + nums[right]
//         - 如果 sum == 0：加入结果，left++, right--，跳过左右重复元素
//         - 如果 sum < 0：left++
//         - 如果 sum > 0：right--
//   3. 返回结果列表

List<List<int>> threeSum(List<int> nums) {
  // TODO: 排序
  // TODO: 遍历 i，固定第一个数
  // TODO: 双指针 left=i+1, right=n-1 找两数之和 = -nums[i]
  // TODO: 注意去重（i、left、right 三个位置都要去重）
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #11: Container With Most Water（Medium）
// ============================================================================
// 题目描述：
//   给定一个长度为 n 的整数数组 height。找出两条线与 x 轴构成的容器能容纳的最多水量。
//   面积 = min(height[left], height[right]) × (right - left)
//
// 解题思路（对撞指针 + 贪心）：
//   从两端开始（宽度最大），每次移动较短的那根柱子（因为较短的柱子决定了高度，
//   移动较长的柱子不可能增大面积，只有移动较短的才有可能）。
//
// 实现步骤：
//   1. left = 0, right = height.length - 1, maxArea = 0
//   2. while left < right：
//      a. h = min(height[left], height[right])
//      b. area = h * (right - left)
//      c. 更新 maxArea = max(maxArea, area)
//      d. 如果 height[left] < height[right] → left++
//        否则 → right--
//   3. 返回 maxArea

int maxArea(List<int> height) {
  // TODO: left = 0, right = height.length - 1, maxArea = 0
  // TODO: while left < right:
  //       - 计算当前面积 area = min(height[left], height[right]) * (right - left)
  //       - 更新 maxArea
  //       - 移动较短的那根柱子
  // TODO: 返回 maxArea
  throw UnimplementedError(); // 请替换为你的实现
}
