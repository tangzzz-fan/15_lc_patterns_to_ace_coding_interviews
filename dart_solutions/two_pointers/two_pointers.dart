/// ---------------------------------------------------------------------------
/// 模式：双指针（Two Pointers）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 双指针技术使用两个指针从数组的两端或同一端开始遍历，将 O(n²) 的暴力枚举优化到 O(n)。
/// 常见变体包括：
/// - 对撞指针：左右指针分别从两端向中间移动（用于有序数组）。
/// - 同向快慢指针：两个指针同向移动，一个快一个慢（与快慢指针模式不同，这里是用于
///   数组/字符串的同向遍历）。
///
/// ## 适用场景
/// - 在排序数组中查找满足特定条件的元素对。
/// - 三数之和 / 四数之和问题。
/// - 盛水最多的容器等面积问题。
/// - 回文串验证。
///
/// ## 时间复杂度
/// - 通常为 O(n)，每个指针最多移动 n 次。
/// - 对于需要排序的场景，加上排序的 O(n log n)。
///
/// ## 空间复杂度
/// - O(1)，只使用常量额外空间（不计算排序所需空间）。

// ============================================================================
// LeetCode #167: Two Sum II - Input Array is Sorted
// ============================================================================
// 所属模式：Two Pointers（双指针 - 对撞指针）
// 难度：Medium
// 题目描述：
//   给定一个已按照非递减顺序排序的整数数组 numbers，请找出两个数，使它们的和等于
//   目标数 target。函数应返回这两个数的下标（从 1 开始计数）。
//   假设每个输入只有唯一解，且不能重复使用同一个元素。
//
// 核心考点：
//   - 对撞指针的正确移动策略。
//   - 利用有序性缩小搜索范围。
//
// 解题思路推导：
//   因为数组已排序，我们可以用两个指针：
//   - left 指向最小元素（数组开头）。
//   - right 指向最大元素（数组末尾）。
//   - 计算 sum = numbers[left] + numbers[right]：
//     - 如果 sum == target，找到答案。
//     - 如果 sum < target，说明需要更大的和，left 右移。
//     - 如果 sum > target，说明需要更小的和，right 左移。
//   - 每次迭代，搜索空间至少缩小 1，保证 O(n) 完成。
//
// 实现步骤：
//   1. 初始化 left = 0，right = numbers.length - 1。
//   2. while left < right：
//      a. 计算 sum = numbers[left] + numbers[right]。
//      b. 若 sum == target，返回 [left + 1, right + 1]（题目要求 1-based）。
//      c. 若 sum < target，left++。
//      d. 若 sum > target，right--。
//   3. 题目保证有解，所以一定能返回。

List<int> twoSum(List<int> numbers, int target) {
  int left = 0; // 左指针指向最小元素
  int right = numbers.length - 1; // 右指针指向最大元素

  while (left < right) {
    int sum = numbers[left] + numbers[right]; // 当前两数之和

    if (sum == target) {
      return [left + 1, right + 1]; // 返回 1-based 下标
    } else if (sum < target) {
      left++; // 和太小，需要增大（左指针右移，取更大的数）
    } else {
      right--; // 和太大，需要减小（右指针左移，取更小的数）
    }
  }

  return []; // 题目保证有解，不会走到这里
}

// ============================================================================
// LeetCode #15: 3Sum
// ============================================================================
// 所属模式：Two Pointers（双指针 - 排序 + 对撞指针）
// 难度：Medium
// 题目描述：
//   给定一个包含 n 个整数的数组 nums，判断是否存在三个元素 a, b, c 使得
//   a + b + c = 0。找出所有满足条件且不重复的三元组。
//
// 核心考点：
//   - 将 3Sum 降维为 2Sum。
//   - 排序后使用双指针。
//   - 去重处理（跳过重复元素）。
//
// 解题思路推导：
//   关键思路：固定第一个数，问题降维为在剩余数组中找两数之和 = -第一个数的 2Sum 问题。
//   1. 先对数组排序 O(n log n)。
//   2. 遍历每个元素 nums[i] 作为第一个数（跳过重复的 i 以避免重复三元组）。
//   3. 在 [i+1, n-1] 范围内用双指针找两数之和为 -nums[i]。
//   4. 找到后同时移动左右指针，并跳过重复值。
//
// 实现步骤：
//   1. 对数组排序。
//   2. 遍历 i 从 0 到 n-3：
//      a. 如果 nums[i] > 0，break（排序后若第一个数 > 0，三数和不可能为 0）。
//      b. 如果 i > 0 且 nums[i] == nums[i-1]，跳过（去重）。
//      c. 初始化 left = i + 1, right = n - 1。
//      d. while left < right：
//         - 计算 sum = nums[i] + nums[left] + nums[right]。
//         - 若 sum == 0：加入结果集，left++, right--，并跳过重复元素。
//         - 若 sum < 0：left++。
//         - 若 sum > 0：right--。
//   3. 返回结果列表。

List<List<int>> threeSum(List<int> nums) {
  nums.sort(); // 先排序，O(n log n)
  List<List<int>> result = [];

  for (int i = 0; i < nums.length - 2; i++) {
    // 剪枝：排序后第一个数已经大于 0，三数之和不可能等于 0
    if (nums[i] > 0) break;

    // 去重：跳过重复的第一个数
    if (i > 0 && nums[i] == nums[i - 1]) continue;

    int left = i + 1;
    int right = nums.length - 1;
    int target = -nums[i]; // 问题转化为找两个数之和为 -nums[i]

    while (left < right) {
      int sum = nums[left] + nums[right];

      if (sum == target) {
        result.add([nums[i], nums[left], nums[right]]); // 找到一组解
        left++;
        right--;

        // 去重：跳过左边重复元素
        while (left < right && nums[left] == nums[left - 1]) {
          left++;
        }
        // 去重：跳过右边重复元素
        while (left < right && nums[right] == nums[right + 1]) {
          right--;
        }
      } else if (sum < target) {
        left++; // 和太小，需要更大的数
      } else {
        right--; // 和太大，需要更小的数
      }
    }
  }

  return result;
}

// ============================================================================
// LeetCode #11: Container With Most Water
// ============================================================================
// 所属模式：Two Pointers（双指针 - 对撞指针 / 贪心）
// 难度：Medium
// 题目描述：
//   给定一个长度为 n 的整数数组 height。有 n 条垂直线，第 i 条线的两个端点是
//   (i, 0) 和 (i, height[i])。找出两条线，与 x 轴共同构成一个容器，使该容器
//   能够容纳最多的水。返回容器可以储存的最大水量。
//   注意：容器不能倾斜。
//
// 核心考点：
//   - 贪心策略：每次移动较短的那根柱子。
//   - 面积 = min(height[left], height[right]) * (right - left)。
//
// 解题思路推导：
//   关键洞察：面积由较短的那根柱子决定，且距离越远面积越大。
//   从两端开始（最大距离），每次移动较短的那根柱子：
//   - 因为如果移动较长的柱子，面积只会变小或不变（宽度变小，高度 ≤ 原高度）。
//   - 只有移动较短的柱子，才有可能让最小高度变大，从而增大面积。
//
//   举例：height = [1,8,6,2,5,4,8,3,7]
//   left=0(高1), right=8(高7): 面积 = min(1,7) * 8 = 8
//   移动 left：left=1(高8), right=8(高7): 面积 = min(8,7) * 7 = 49
//   移动 right：left=1(高8), right=7(高3): 面积 = min(8,3) * 6 = 18
//   ...继续直到 left == right，最大面积 = 49
//
// 实现步骤：
//   1. 初始化 left = 0, right = height.length - 1, maxArea = 0。
//   2. while left < right：
//      a. 计算当前面积 area = min(height[left], height[right]) * (right - left)。
//      b. 更新 maxArea = max(maxArea, area)。
//      c. 如果 height[left] < height[right]，left++（移动较短的柱子）。
//      d. 否则，right--。
//   3. 返回 maxArea。

int maxArea(List<int> height) {
  int left = 0; // 左指针
  int right = height.length - 1; // 右指针
  int maxArea = 0;

  while (left < right) {
    // 计算当前容器的面积
    int h = height[left] < height[right] ? height[left] : height[right]; // 取较短柱子
    int w = right - left; // 容器宽度
    int currentArea = h * w;

    if (currentArea > maxArea) {
      maxArea = currentArea; // 更新最大面积
    }

    // 贪心策略：移动较短的那根柱子
    if (height[left] < height[right]) {
      left++; // 尝试找更高的左柱子
    } else {
      right--; // 尝试找更高的右柱子
    }
  }

  return maxArea;
}
