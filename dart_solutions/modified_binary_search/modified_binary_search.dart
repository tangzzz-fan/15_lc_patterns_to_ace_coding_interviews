/// ---------------------------------------------------------------------------
/// 模式：变形二分查找（Modified Binary Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 二分查找通过在每次迭代中将搜索范围缩小一半，在有序数据中实现 O(log n) 的查找。
/// "变形"二分查找指的是在旋转数组、二维矩阵等非标准有序场景中对二分查找进行适配。
/// 核心技巧是：**总有一半是有序的**，先判断目标在哪一半，然后缩小范围。
///
/// ## 适用场景
/// - 在旋转排序数组中查找目标值。
/// - 寻找旋转排序数组中的最小值。
/// - 在二维有序矩阵中搜索。
/// - 寻找峰值元素。
/// - 二分查找的边界变体（第一个/最后一个出现位置）。
///
/// ## 时间复杂度
/// - O(log n) 或 O(log m + log n)，每次迭代搜索范围减半。
///
/// ## 空间复杂度
/// - O(1)，只使用常数量级变量。

// ============================================================================
// LeetCode #33: Search in Rotated Sorted Array
// ============================================================================
// 所属模式：Modified Binary Search（变形二分查找 - 旋转数组搜索）
// 难度：Medium
// 题目描述：
//   整数数组 nums 按升序排列，数组中的值互不相同。
//   在传递给函数之前，nums 在某个未知下标 k（0 <= k < nums.length）上进行了旋转。
//   例如 nums = [0,1,2,4,5,6,7] 在下标 3 处旋转后可能变成 [4,5,6,7,0,1,2]。
//   给定旋转后的数组 nums 和一个整数 target，如果 nums 中存在 target 则返回其下标，
//   否则返回 -1。要求 O(log n) 时间。
//
// 核心考点：
//   - 识别旋转数组中"有序的一半"。
//   - 判断 target 是否在某一半中。
//   - 两端闭区间的二分查找模板。
//
// 解题思路推导：
//   对于旋转数组 [4,5,6,7,0,1,2]，mid = 3（值为 7）。
//   判断：nums[left] <= nums[mid] → 左半 [left, mid] 有序。
//   如果 target 在有序半中（nums[left] <= target < nums[mid]），就搜索有序半；
//   否则搜索另一侧。
//
//   如果左半无序（nums[left] > nums[mid]），则右半一定有序。同样判断。
//
// 实现步骤：
//   1. 初始化 left = 0, right = nums.length - 1。
//   2. while left <= right：
//      a. mid = left + (right - left) ~/ 2。
//      b. 如果 nums[mid] == target，返回 mid。
//      c. 如果 nums[left] <= nums[mid]（左半有序）：
//         - 如果 target 在 [nums[left], nums[mid]) → right = mid - 1。
//         - 否则 → left = mid + 1。
//      d. 否则（右半有序）：
//         - 如果 target 在 (nums[mid], nums[right]] → left = mid + 1。
//         - 否则 → right = mid - 1。
//   3. 返回 -1（未找到）。

int searchRotated(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;

  while (left <= right) {
    int mid = left + (right - left) ~/ 2; // 防溢出的中间下标

    if (nums[mid] == target) {
      return mid; // 找到了
    }

    // 判断哪一半是有序的
    if (nums[left] <= nums[mid]) {
      // 左半 [left, mid] 有序
      if (nums[left] <= target && target < nums[mid]) {
        right = mid - 1; // target 在有序的左半中
      } else {
        left = mid + 1; // target 在右半中
      }
    } else {
      // 右半 [mid, right] 有序
      if (nums[mid] < target && target <= nums[right]) {
        left = mid + 1; // target 在有序的右半中
      } else {
        right = mid - 1; // target 在左半中
      }
    }
  }

  return -1; // 未找到
}

// ============================================================================
// LeetCode #153: Find Minimum in Rotated Sorted Array
// ============================================================================
// 所属模式：Modified Binary Search（变形二分查找 - 找旋转数组最小值）
// 难度：Medium
// 题目描述：
//   已知一个长度为 n 的数组，预先按升序排列，经由 1 到 n 次旋转后得到输入数组。
//   数组中的元素互不相同。请找出数组中的最小元素。要求 O(log n) 时间。
//
// 核心考点：
//   - 二分查找缩小最小值所在范围。
//   - 判断最小值在哪一侧：比较 nums[mid] 和 nums[right]。
//   - 旋转数组的"断崖"特征：最小值是"断崖"的位置。
//
// 解题思路推导：
//   关键：比较 nums[mid] 与 nums[right]。
//   - 如果 nums[mid] < nums[right]：说明 mid 到 right 之间是递增的，
//     最小值一定在 [left, mid]（mid 本身也可能是最小值）。
//   - 如果 nums[mid] > nums[right]：说明最小值在旋转后的"低谷"处，
//     即一定在 [mid+1, right]。
//
//   举例：[4,5,6,7,0,1,2]
//   mid=3(val=7), right=2: 7>2 → 最小值在右侧 [4,6]
//   mid=5(val=1), right=2: 1<2 → 最小值在左侧 [4,5]
//   mid=4(val=0), right=2: 0<2 → 最小值在左侧 [4,4]
//   left=right=4, val=0 → 最小值=0
//
// 实现步骤：
//   1. 初始化 left = 0, right = nums.length - 1。
//   2. while left < right：
//      a. mid = left + (right - left) ~/ 2。
//      b. 如果 nums[mid] < nums[right]：
//         - right = mid（最小值在左侧，mid 可能是最小值）。
//      c. 否则（nums[mid] > nums[right]）：
//         - left = mid + 1（最小值在右侧）。
//   3. 返回 nums[left]。

int findMin(List<int> nums) {
  int left = 0;
  int right = nums.length - 1;

  // 注意是 left < right（不是 <=），因为最后 left == right 时就是答案
  while (left < right) {
    int mid = left + (right - left) ~/ 2;

    // 与右边界比较
    if (nums[mid] < nums[right]) {
      // 右侧有序，最小值在左半（包括 mid）
      right = mid;
    } else {
      // nums[mid] > nums[right]，最小值在右半（mid 不可能是最小值）
      left = mid + 1;
    }
  }

  return nums[left]; // left == right，即最小值位置
}

// ============================================================================
// LeetCode #240: Search a 2D Matrix II
// ============================================================================
// 所属模式：Modified Binary Search（变形二分查找 - 二维矩阵搜索）
// 难度：Medium
// 题目描述：
//   编写一个在 m×n 矩阵中搜索目标值 target 的高效算法。矩阵具有以下特性：
//   - 每行的元素从左到右升序排列。
//   - 每列的元素从上到下升序排列。
//
// 核心考点：
//   - 从右上角（或左下角）开始搜索，利用矩阵的排序特性。
//   - 每次排除一行或一列，O(m+n) 时间。
//   - 也可对每行做二分查找，O(m log n)。
//
// 解题思路推导：
//   关键洞察：从右上角（或左下角）开始。
//   - 右上角元素是该行最大、该列最小。
//   - 如果 target < 当前值 → 目标不可能在当前列（因为列从上到下递增），列左移。
//   - 如果 target > 当前值 → 目标不可能在当前行（因为行从左到右递增），行下移。
//   - 等于 → 找到。
//   每次排除一行或一列，最多 O(m+n) 步。
//
//   举例：Matrix = [[1,4,7],[2,5,8],[3,6,9]], target = 5
//   从右上角 7 开始：5<7，列左移
//   当前 4：5>4，行下移
//   当前 5：等于，返回 true ✓
//
// 实现步骤：
//   1. 初始化 row = 0, col = matrix[0].length - 1（右上角）。
//   2. while row < m 且 col >= 0：
//      a. 如果 matrix[row][col] == target → 返回 true。
//      b. 如果 matrix[row][col] > target → col--（排除当前列）。
//      c. 否则 → row++（排除当前行）。
//   3. 返回 false（未找到）。

bool searchMatrix(List<List<int>> matrix, int target) {
  if (matrix.isEmpty || matrix[0].isEmpty) return false;

  int rows = matrix.length;
  int cols = matrix[0].length;

  // 从右上角开始搜索
  int row = 0;
  int col = cols - 1;

  while (row < rows && col >= 0) {
    int current = matrix[row][col];

    if (current == target) {
      return true; // 找到了
    } else if (current > target) {
      col--; // 当前值太大，排除当前列（往左移动）
    } else {
      row++; // 当前值太小，排除当前行（往下移动）
    }
  }

  return false; // 未找到
}
