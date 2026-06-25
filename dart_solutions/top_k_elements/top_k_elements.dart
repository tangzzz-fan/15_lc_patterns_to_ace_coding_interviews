/// ---------------------------------------------------------------------------
/// 模式：前 K 个元素（Top 'K' Elements）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 使用大小为 K 的堆（优先队列）来高效地找出数组或数据流中前 K 大/小的元素。
/// - 找前 K 大：使用大小为 K 的最小堆（Min-Heap）。堆顶就是第 K 大的元素。
/// - 找前 K 小：使用大小为 K 的最大堆（Max-Heap）。堆顶就是第 K 小的元素。
/// 核心优势：不需要对整个数组排序（O(n log n)），只需 O(n log K) 时间。
///
/// ## 适用场景
/// - 寻找第 K 大/小的元素。
/// - 前 K 个出现频率最高的元素。
/// - 从多个有序数组中找前 K 小的和。
/// - 数据流中维护前 K 大/小的元素。
///
/// ## 时间复杂度
/// - O(n log K)，遍历 n 个元素，每个元素堆操作 O(log K)。
/// - 若 K << n，远优于全排序的 O(n log n)。
///
/// ## 空间复杂度
/// - O(K)，堆中只存储 K 个元素。

// ============================================================================
// LeetCode #215: Kth Largest Element in an Array
// ============================================================================
// 所属模式：Top K Elements（前 K 个元素 - 最小堆）
// 难度：Medium
// 题目描述：
//   给定整数数组 nums 和整数 k，请返回数组中第 k 大的元素。
//   注意：是排序后的第 k 大的元素，而非第 k 个不同的元素。
//   要求不排序整个数组。
//
// 核心考点：
//   - 最小堆维护前 K 大元素的模板。
//   - 堆顶即第 K 大元素。
//   - 也可使用快速选择（QuickSelect）算法达到平均 O(n)。
//
// 解题思路推导：
//   维护一个大小为 k 的最小堆。
//   遍历数组：
//   - 如果堆的大小 < k，直接入堆。
//   - 如果堆的大小 == k，且当前元素 > 堆顶，弹出堆顶，当前元素入堆。
//   遍历结束后，堆顶就是第 k 大的元素。
//
//   举例：nums = [3,2,1,5,6,4], k = 2
//   堆变化：[] → [3] → [2,3]（大小=2） → [2,3]（1<2，跳过）
//   → [3,5]（5>2，弹出2入5） → [5,6]（6>3，弹出3入6） → [5,6]（4<5，跳过）
//   堆顶 = 5，即第 2 大元素 ✓
//
// 实现步骤：
//   1. 检查输入：k 有郊范围 [1, nums.length]。
//   2. 创建优先队列（Dart 中 heap 默认是最小堆）。
//   3. 遍历每个元素 num：
//      a. if heap.length < k：heap.add(num)。
//      b. else if num > heap.first：heap.removeFirst()，heap.add(num)。
//   4. 返回 heap.first（第 K 大元素）。

// Dart 中需要使用 HeapPriorityQueue（来自 collection 包）或手动实现堆。
// 以下为概念性实现，展示核心逻辑：

int findKthLargest(List<int> nums, int k) {
  // 使用最小堆（手动实现，便于理解）
  final List<int> heap = [];

  // 向最小堆添加元素，保持堆特性
  void addToHeap(int val) {
    heap.add(val);
    // 上浮：子节点与父节点比较
    int i = heap.length - 1;
    while (i > 0) {
      int parent = (i - 1) ~/ 2; // 父节点下标
      if (heap[parent] <= heap[i]) break; // 已满足最小堆
      // 交换
      int temp = heap[parent];
      heap[parent] = heap[i];
      heap[i] = temp;
      i = parent;
    }
  }

  // 移除堆顶元素
  int removeTop() {
    int top = heap[0];
    heap[0] = heap.removeLast();
    // 下沉
    int i = 0;
    while (true) {
      int smallest = i;
      int left = 2 * i + 1;
      int right = 2 * i + 2;
      if (left < heap.length && heap[left] < heap[smallest]) smallest = left;
      if (right < heap.length && heap[right] < heap[smallest]) smallest = right;
      if (smallest == i) break; // 已就位
      int temp = heap[i];
      heap[i] = heap[smallest];
      heap[smallest] = temp;
      i = smallest;
    }
    return top;
  }

  // 构建大小为 k 的最小堆
  for (int num in nums) {
    if (heap.length < k) {
      addToHeap(num); // 堆未满，直接加入
    } else if (num > heap[0]) {
      // 当前元素大于堆顶 → 替换堆顶
      removeTop(); // 弹出堆顶（最小的）
      addToHeap(num); // 加入更大的元素
    }
    // 否则 num <= 堆顶，直接跳过（num 不可能在前 K 大）
  }

  return heap[0]; // 堆顶就是第 K 大元素
}

// ============================================================================
// LeetCode #347: Top K Frequent Elements
// ============================================================================
// 所属模式：Top K Elements（前 K 个元素 - 最小堆 + 频率统计）
// 难度：Medium
// 题目描述：
//   给定一个非空的整数数组 nums，返回其中出现频率前 k 高的元素。
//   可以按任意顺序返回答案。
//
// 核心考点：
//   - 统计频率（HashMap）+ 堆排序。
//   - 堆中存储条目（频率, 元素），按频率比较。
//   - 和 #215 的思路一致，但需要先统计频率。
//
// 解题思路推导：
//   1. 用 HashMap 统计每个元素出现的频率。
//   2. 维护大小为 k 的最小堆（按频率比较）。
//   3. 遍历频率表中的每个条目：
//      - 堆未满直接入堆。
//      - 堆满且当前频率 > 堆顶频率 → 弹出堆顶，当前条目入堆。
//   4. 堆中剩余的元素就是频率前 k 高的元素。
//
//   举例：nums = [1,1,1,2,2,3], k = 2
//   频率：1→3, 2→2, 3→1
//   堆操作：[(3,1)], [(2,2),(3,1)], [(2,2),(3,1)]（1的频率<堆顶频率2，跳过）
//   结果：1 和 2
//
// 实现步骤：
//   1. 统计每个元素的频率。
//   2. 创建最小堆（按频率排序）。
//   3. 遍历频率表，维护大小为 k 的堆：
//      a. heap.length < k → 直接加入。
//      b. 当前频率 > heap.first.freq → 移除堆顶，加入当前条目。
//   4. 收集堆中所有元素的 key，返回结果列表。

List<int> topKFrequent(List<int> nums, int k) {
  // 第 1 步：统计频率
  final Map<int, int> freq = {};
  for (int num in nums) {
    freq[num] = (freq[num] ?? 0) + 1;
  }

  // 第 2 步：使用最小堆按频率维护前 K 大频率的元素
  // 堆中每个元素是一个记录 {element, frequency}
  final List<_ElementFreq> heap = [];

  void add(_ElementFreq entry) {
    heap.add(entry);
    int i = heap.length - 1;
    while (i > 0) {
      int parent = (i - 1) ~/ 2;
      if (heap[parent].freq <= heap[i].freq) break;
      _ElementFreq temp = heap[parent];
      heap[parent] = heap[i];
      heap[i] = temp;
      i = parent;
    }
  }

  _ElementFreq removeTop() {
    _ElementFreq top = heap[0];
    heap[0] = heap.removeLast();
    int i = 0;
    while (true) {
      int smallest = i;
      int left = 2 * i + 1;
      int right = 2 * i + 2;
      if (left < heap.length && heap[left].freq < heap[smallest].freq) smallest = left;
      if (right < heap.length && heap[right].freq < heap[smallest].freq) smallest = right;
      if (smallest == i) break;
      _ElementFreq temp = heap[i];
      heap[i] = heap[smallest];
      heap[smallest] = temp;
      i = smallest;
    }
    return top;
  }

  // 遍历频率表，维护大小为 k 的最小堆
  freq.forEach((element, frequency) {
    _ElementFreq entry = _ElementFreq(element, frequency);
    if (heap.length < k) {
      add(entry); // 堆未满，直接加入
    } else if (frequency > heap[0].freq) {
      removeTop(); // 弹出最低频率
      add(entry); // 加入更高频率的元素
    }
  });

  // 第 3 步：收集结果
  List<int> result = [];
  for (_ElementFreq e in heap) {
    result.add(e.element);
  }
  return result;
}

// 辅助类：元素及其频率
class _ElementFreq {
  int element;
  int freq;
  _ElementFreq(this.element, this.freq);
}

// ============================================================================
// LeetCode #373: Find K Pairs with Smallest Sums
// ============================================================================
// 所属模式：Top K Elements（前 K 个元素 - 最大堆 / 多路归并）
// 难度：Medium
// 题目描述：
//   给定两个以非递减顺序排列的整数数组 nums1 和 nums2，以及一个整数 k。
//   定义 (u, v) 为一个数对，其中 u 来自 nums1，v 来自 nums2。
//   返回和最小的 k 个数对。
//
// 核心考点：
//   - 最大堆维护前 K 小的和。
//   - 多路归并的优化（只扫描必要的组合，而不是穷举所有 m×n）。
//   - 从前 K 小扩展到需要优化组合空间。
//
// 解题思路推导：
//   基础思路：生成所有 m×n 个数对，用最大堆维护前 K 小 → O(mn log K)，太大。
//   优化思路（多路归并）：
//   将 nums1 的每个元素与 nums2[0] 配对放入最小堆。
//   每次弹出堆顶（当前最小和的对），然后加入 (nums1[i], nums2[j+1]) 作为候选。
//   这样可以保证按和递增的顺序生成数对，取前 k 个即可。
//
//   举例：nums1=[1,7,11], nums2=[2,4,6], k=3
//   初始堆：[(1,2,0,0), (7,2,1,0), (11,2,2,0)]
//   弹出 (1,2)，加入 (1,4)→堆：[(1,4,0,1), (7,2,1,0), (11,2,2,0)]
//   弹出 (1,4)，加入 (1,6)→堆：[(1,6,0,2), (7,2,1,0), (11,2,2,0)]
//   弹出 (1,6)... 结果：[[1,2],[1,4],[1,6]]
//
// 实现步骤：
//   1. 创建最小堆，初始化时加入 (nums1[0..], nums2[0])。
//   2. 循环 k 次（或堆为空）：
//      a. 弹出堆顶 (sum, i1, i2)。
//      b. 将 [nums1[i1], nums2[i2]] 加入结果。
//      c. 如果 i2 + 1 < nums2.length，将 (nums1[i1], nums2[i2+1]) 入堆。
//   3. 返回结果列表。

List<List<int>> kSmallestPairs(List<int> nums1, List<int> nums2, int k) {
  List<List<int>> result = [];
  if (nums1.isEmpty || nums2.isEmpty || k <= 0) return result;

  // 使用最小堆，堆元素为 (sum, i1, i2)
  final List<_HeapEntry> heap = [];

  void addToHeap(_HeapEntry entry) {
    heap.add(entry);
    int i = heap.length - 1;
    while (i > 0) {
      int parent = (i - 1) ~/ 2;
      if (heap[parent].sum <= heap[i].sum) break;
      _HeapEntry temp = heap[parent];
      heap[parent] = heap[i];
      heap[i] = temp;
      i = parent;
    }
  }

  _HeapEntry removeTop() {
    _HeapEntry top = heap[0];
    heap[0] = heap.removeLast();
    int i = 0;
    while (true) {
      int smallest = i;
      int left = 2 * i + 1;
      int right = 2 * i + 2;
      if (left < heap.length && heap[left].sum < heap[smallest].sum) smallest = left;
      if (right < heap.length && heap[right].sum < heap[smallest].sum) smallest = right;
      if (smallest == i) break;
      _HeapEntry temp = heap[i];
      heap[i] = heap[smallest];
      heap[smallest] = temp;
      i = smallest;
    }
    return top;
  }

  // 初始化：nums1 的每个元素与 nums2[0] 配对入堆
  for (int i = 0; i < nums1.length && i < k; i++) {
    int sum = nums1[i] + nums2[0];
    addToHeap(_HeapEntry(sum, i, 0));
  }

  // 取出前 k 小的对
  while (result.length < k && heap.isNotEmpty) {
    _HeapEntry entry = removeTop();
    result.add([nums1[entry.i1], nums2[entry.i2]]);

    // 将同一 nums1 元素与下一个 nums2 元素配对入堆
    if (entry.i2 + 1 < nums2.length) {
      int newSum = nums1[entry.i1] + nums2[entry.i2 + 1];
      addToHeap(_HeapEntry(newSum, entry.i1, entry.i2 + 1));
    }
  }

  return result;
}

// 堆元素辅助类
class _HeapEntry {
  int sum;
  int i1; // nums1 中的下标
  int i2; // nums2 中的下标
  _HeapEntry(this.sum, this.i1, this.i2);
}
