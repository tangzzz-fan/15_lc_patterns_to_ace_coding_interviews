/// ---------------------------------------------------------------------------
/// 模式：环形缓冲队列（Circular Buffer Queue）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 环形缓冲队列使用固定容量数组模拟队列，通过取模运算让头尾指针在数组尾部之后
/// 回到数组开头，从而复用已经出队的位置，而不需要整体搬移元素。
///
/// 常见的两个指针定义方式：
/// - `front` 指向当前队头元素。
/// - `rear` 指向下一个可插入位置，或者指向当前队尾元素之后的位置。
///
/// 配合 `count` 记录当前元素个数后，判空和判满会非常直接：
/// - 空：`count == 0`
/// - 满：`count == capacity`
///
/// ## 适用场景
/// - 固定容量队列。
/// - 固定容量双端队列。
/// - 高频入队出队，且希望避免头部删除带来的 O(n) 元素移动。
/// - 数据流窗口、日志缓冲区、消息缓冲区。
///
/// ## 时间复杂度
/// - 单次入队、出队、访问头尾：O(1)
///
/// ## 空间复杂度
/// - 固定容量队列 / 双端队列：O(k)
/// - 数据流窗口队列：O(n) 或 O(window)，取决于保留数据量
///
/// ## Dart 语法提示
/// - `List<int>.filled(k, 0)` 是创建固定容量数组的常见方式。
/// - 处理环形下标时，常用 `(index + 1) % capacity` 和
///   `(index - 1 + capacity) % capacity`。
/// - 设计题通常使用类封装状态，让构造函数初始化容量和内部数组。

// ============================================================================
// LeetCode #622: Design Circular Queue
// ============================================================================
// 所属模式：Circular Buffer Queue（固定容量环形队列）
// 难度：Medium
// 题目描述：
//   设计一个容量为 k 的环形队列，支持：
//   - enQueue(value)：入队
//   - deQueue()：出队
//   - Front()：获取队头
//   - Rear()：获取队尾
//   - isEmpty()：判空
//   - isFull()：判满
//
// 核心考点：
//   - 头尾指针如何在数组末尾后回绕。
//   - rear 指向“下一个插入位置”时，队尾元素如何读取。
//   - 为什么额外维护 count 能简化判空判满逻辑。
//
// 解题思路推导：
//   朴素队列如果用数组直接 removeAt(0)，会导致 O(n) 的移动成本。
//   环形队列的优化在于：元素出队后，不真的移动数组内容，只移动 front 指针。
//   元素入队时，也只是在 rear 指向的位置写入，然后 rear 右移一格并取模。
//
// 实现步骤：
//   1. 用 data 保存固定容量数组。
//   2. front 指向当前队头位置。
//   3. rear 指向下一个可插入位置。
//   4. count 记录当前元素个数。
//   5. Rear() 读取时，需要回退到 `(rear - 1 + capacity) % capacity`。
class MyCircularQueue {
  late final List<int> _data;
  late final int _capacity;
  int _frontIndex = 0;
  int _rearIndex = 0;
  int _count = 0;

  MyCircularQueue(int k) {
    _capacity = k;
    _data = List<int>.filled(k, 0);
  }

  bool enQueue(int value) {
    if (isFull()) return false;
    _data[_rearIndex] = value;
    _rearIndex = (_rearIndex + 1) % _capacity;
    _count++;
    return true;
  }

  bool deQueue() {
    if (isEmpty()) return false;
    _frontIndex = (_frontIndex + 1) % _capacity;
    _count--;
    return true;
  }

  int Front() {
    if (isEmpty()) return -1;
    return _data[_frontIndex];
  }

  int Rear() {
    if (isEmpty()) return -1;
    int lastIndex = (_rearIndex - 1 + _capacity) % _capacity;
    return _data[lastIndex];
  }

  bool isEmpty() {
    return _count == 0;
  }

  bool isFull() {
    return _count == _capacity;
  }
}

// ============================================================================
// LeetCode #641: Design Circular Deque
// ============================================================================
// 所属模式：Circular Buffer Queue（固定容量环形双端队列）
// 难度：Medium
// 题目描述：
//   设计一个容量为 k 的环形双端队列，支持头尾双向插入、删除和访问。
//
// 核心考点：
//   - 双端操作时，front 和 rear 的语义要稳定。
//   - 向前移动下标时必须写成 `(index - 1 + capacity) % capacity`。
//   - 固定容量设计题中，count 依然是最直接的状态变量。
//
// 解题思路推导：
//   单端环形队列只需要在 rear 插入、front 删除。
//   双端队列则要支持：
//   - insertFront：front 先左移，再写值。
//   - insertLast：在 rear 写值，再让 rear 右移。
//   - deleteFront：front 右移。
//   - deleteLast：rear 先左移。
//
// 实现步骤：
//   1. front 指向当前头元素位置。
//   2. rear 指向“当前尾元素之后的位置”。
//   3. 头插时：front 左移一格后写入。
//   4. 尾删时：rear 左移一格即可完成删除。
class MyCircularDeque {
  late final List<int> _data;
  late final int _capacity;
  int _frontIndex = 0;
  int _rearIndex = 0;
  int _count = 0;

  MyCircularDeque(int k) {
    _capacity = k;
    _data = List<int>.filled(k, 0);
  }

  bool insertFront(int value) {
    if (isFull()) return false;
    _frontIndex = (_frontIndex - 1 + _capacity) % _capacity;
    _data[_frontIndex] = value;
    _count++;
    return true;
  }

  bool insertLast(int value) {
    if (isFull()) return false;
    _data[_rearIndex] = value;
    _rearIndex = (_rearIndex + 1) % _capacity;
    _count++;
    return true;
  }

  bool deleteFront() {
    if (isEmpty()) return false;
    _frontIndex = (_frontIndex + 1) % _capacity;
    _count--;
    return true;
  }

  bool deleteLast() {
    if (isEmpty()) return false;
    _rearIndex = (_rearIndex - 1 + _capacity) % _capacity;
    _count--;
    return true;
  }

  int getFront() {
    if (isEmpty()) return -1;
    return _data[_frontIndex];
  }

  int getRear() {
    if (isEmpty()) return -1;
    int lastIndex = (_rearIndex - 1 + _capacity) % _capacity;
    return _data[lastIndex];
  }

  bool isEmpty() {
    return _count == 0;
  }

  bool isFull() {
    return _count == _capacity;
  }
}

// ============================================================================
// LeetCode #933: Number of Recent Calls
// ============================================================================
// 所属模式：Circular Buffer Queue（队列窗口应用）
// 难度：Easy
// 题目描述：
//   维护最近 3000 毫秒内的请求数量。每次 ping(t) 返回区间 [t - 3000, t] 内的请求数。
//
// 核心考点：
//   - 维护一个单调递增时间戳队列。
//   - 队头不断跳过窗口外的数据，队尾加入新请求。
//   - 这是“固定方向进出队”的经典窗口模型，和环形缓冲队列的使用方式高度相似。
//
// 解题思路推导：
//   由于 ping 的时间戳严格递增，过期请求一定只会出现在队头。
//   因此每次：
//   - 先把当前时间加入队尾。
//   - 再把所有早于 `t - 3000` 的时间戳从队头移走。
//   - 队列剩余元素个数就是答案。
//
// 实现步骤：
//   1. 用数组保存请求时间。
//   2. 用 head 指针表示当前有效队头，而不是频繁 removeAt(0)。
//   3. 每次 ping 后把窗口外元素跳过。
//   4. 返回 `calls.length - head`。
//
// 说明：
//   这题不需要固定容量，因此实现上更像“队列窗口”而不是严格固定长度的 ring buffer。
//   但它非常适合作为环形队列模式的应用延伸题。
class RecentCounter {
  final List<int> _calls = [];
  int _head = 0;

  RecentCounter();

  int ping(int t) {
    _calls.add(t);
    int lowerBound = t - 3000;

    while (_head < _calls.length && _calls[_head] < lowerBound) {
      _head++;
    }

    return _calls.length - _head;
  }
}
