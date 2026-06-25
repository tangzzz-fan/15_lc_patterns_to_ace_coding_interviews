/// ---------------------------------------------------------------------------
/// 模式：变形二分查找（Modified Binary Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 二分查找在每次迭代中将搜索范围缩小一半，在有序数据中实现 O(log n) 查找。
/// "变形"二分查找是指在旋转数组、二维矩阵等非标准有序场景中的适配。
/// 核心技巧：**总有一半是有序的**，先判断目标在有序的那一半还是另一半。
///
/// ## 适用场景
/// - 在旋转排序数组中查找目标值。
/// - 寻找旋转排序数组中的最小值。
/// - 在行列有序的二维矩阵中搜索。
/// - 寻找峰值元素。
/// - 二分查找的边界变体（第一个/最后一个出现位置）。
///
/// ## 时间复杂度
/// - O(log n) 或 O(log m + log n)。
///
/// ## 空间复杂度
/// - O(1)，只使用常量级变量。

// ============================================================================
// LeetCode #33: Search in Rotated Sorted Array（Medium）
// ============================================================================
// 题目描述：
//   一个升序数组在某个未知下标旋转。在旋转后的数组中搜索 target，返回下标。
//   要求 O(log n)。数组值互不相同。
//   例如：[4,5,6,7,0,1,2] 中搜索 0 → 返回 4
//
// 解题思路：
//   关键：mid 将数组分为两半，其中一半一定是有序的。
//   - 如果 nums[left] <= nums[mid] → 左半有序
//     - target 在 [left, mid) 中 → 搜索左半
//     - 否则 → 搜索右半
//   - 否则（右半有序）
//     - target 在 (mid, right] 中 → 搜索右半
//     - 否则 → 搜索左半
//
// 实现步骤：
//   1. left = 0, right = nums.length - 1
//   2. while left <= right：
//      a. mid = left + (right - left) ~/ 2
//      b. 如果 nums[mid] == target → 返回 mid
//      c. 如果 nums[left] <= nums[mid]（左半有序）：
//         - target 在 left~mid 之间 → right = mid - 1
//         - 否则 → left = mid + 1
//      d. 否则（右半有序）：
//         - target 在 mid~right 之间 → left = mid + 1
//         - 否则 → right = mid - 1
//   3. 返回 -1

int searchRotated(List<int> nums, int target) {
  // TODO: left = 0, right = nums.length - 1
  // TODO: while left <= right:
  //       计算 mid，判断哪一半有序，target 是否在有序半中
  // TODO: 返回 -1（未找到）
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #153: Find Minimum in Rotated Sorted Array（Medium）
// ============================================================================
// 题目描述：
//   一个升序数组经过旋转。找出数组中的最小元素。要求 O(log n)。
//   数组元素互不相同。
//
// 解题思路：
//   关键：比较 nums[mid] 和 nums[right]
//   - 如果 nums[mid] < nums[right]：mid→right 递增，最小值在 [left, mid]（含 mid）
//   - 如果 nums[mid] > nums[right]：旋转的"断崖"在右侧，最小值在 [mid+1, right]
//
// 实现步骤：
//   1. left = 0, right = nums.length - 1
//   2. while left < right（注意不是 <=，因为要留一个元素）：
//      a. mid = left + (right - left) ~/ 2
//      b. 如果 nums[mid] < nums[right] → right = mid
//      c. 否则 → left = mid + 1
//   3. 返回 nums[left]

int findMin(List<int> nums) {
  // TODO: left = 0, right = nums.length - 1
  // TODO: while left < right:
  //       比较 nums[mid] 与 nums[right]，缩小范围
  // TODO: 返回 nums[left]
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #240: Search a 2D Matrix II（Medium）
// ============================================================================
// 题目描述：
//   在 m×n 矩阵中搜索 target。矩阵特性：每行从左到右升序，每列从上到下升序。
//
// 解题思路（右上角出发）：
//   右上角是该行最大、该列最小的元素。
//   - target < 当前值 → 排除当前列（列左移）
//   - target > 当前值 → 排除当前行（行下移）
//   - 等于 → 找到
//   每次排除一行或一列，最多 O(m+n) 步
//
// 实现步骤：
//   1. row = 0, col = cols - 1（右上角）
//   2. while row < rows && col >= 0：
//      a. 如果 matrix[row][col] == target → 返回 true
//      b. 如果 matrix[row][col] > target → col--
//      c. 否则 → row++
//   3. 返回 false

bool searchMatrix(List<List<int>> matrix, int target) {
  // TODO: 从右上角开始
  // TODO: 大于 target → 列左移，小于 target → 行下移
  // TODO: 找到返回 true，越界返回 false
  throw UnimplementedError(); // 请替换为你的实现
}
