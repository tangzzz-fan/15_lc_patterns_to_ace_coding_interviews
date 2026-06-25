/// ---------------------------------------------------------------------------
/// 模式：链表原地反转（Linked List In-place Reversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 通过调整节点之间的 next 指针，在不使用额外空间的情况下反转链表的一部分或全部。
/// 核心是三指针法：prev（前驱）、curr（当前）、nextTemp（后继）。
///
/// ## 适用场景
/// - 反转整个链表。
/// - 反转链表的某一段（从位置 m 到 n）。
/// - 两两交换链表节点。
/// - K 个一组翻转链表。
///
/// ## 时间复杂度
/// - O(n)，只需遍历一次链表。
///
/// ## 空间复杂度
/// - O(1)，只使用常数量级指针变量。

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

// ============================================================================
// LeetCode #206: Reverse Linked List（Easy）
// ============================================================================
// 题目描述：
//   给定单链表的头节点 head，反转链表，返回反转后的头节点。
//
// 解题思路（三指针迭代法）：
//   核心操作：让每个节点的 next 指向它的前一个节点
//   prev = null（初始时原头节点反转后指向 null）
//   curr = head
//   每次迭代：
//     1. 保存 nextTemp = curr.next（防止断链）
//     2. curr.next = prev（反转指针方向）
//     3. prev = curr（prev 前进一步）
//     4. curr = nextTemp（curr 前进一步）
//
// 实现步骤：
//   1. prev = null, curr = head
//   2. while curr != null：
//      a. nextTemp = curr.next
//      b. curr.next = prev
//      c. prev = curr
//      d. curr = nextTemp
//   3. 返回 prev（新头节点）

ListNode? reverseList(ListNode? head) {
  // TODO: prev = null, curr = head
  // TODO: while curr != null:
  //       保存 nextTemp, 反转 curr.next, prev 和 curr 前进
  // TODO: 返回 prev
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #92: Reverse Linked List II（Medium）
// ============================================================================
// 题目描述：
//   反转从位置 left 到 right 的链表节点，下标从 1 开始。返回反转后的链表。
//
// 解题思路（局部反转 + 头插法）：
//   - 用 dummy 节点简化边界处理（left = 1 时头节点也会变化）
//   - 先找到 left-1 位置的节点 prev
//   - curr = 第 left 个节点
//   - 对 [left+1, right] 范围内的每个节点，用头插法移到反转段的最前面
//
// 头插法（每次将 curr 后面的一个节点移到 prev 后面）：
//   1. nextTemp = curr.next（要前移的节点）
//   2. curr.next = nextTemp.next（跳过 nextTemp）
//   3. nextTemp.next = prev.next（nextTemp 连到段首）
//   4. prev.next = nextTemp（prev 连接新段首）
//
// 实现步骤：
//   1. 创建 dummy 节点，dummy.next = head
//   2. 移动 prev 到第 left-1 个节点
//   3. curr = prev.next
//   4. 循环 right - left 次，每次用头插法将 curr 后面的节点移到 prev 后面
//   5. 返回 dummy.next

ListNode? reverseBetween(ListNode? head, int left, int right) {
  // TODO: 创建 dummy 节点
  // TODO: 移动 prev 到第 left-1 个节点
  // TODO: curr = prev.next
  // TODO: 循环 right-left 次，头插法移动节点
  // TODO: 返回 dummy.next
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #24: Swap Nodes in Pairs（Medium）
// ============================================================================
// 题目描述：
//   两两交换链表中相邻的节点，返回交换后的链表头节点。只能交换节点，不能修改值。
//   例如：1→2→3→4 变为 2→1→4→3
//
// 解题思路（三指针 + 迭代）：
//   - dummy 节点处理头节点交换
//   - prev（当前对的前驱）、first（第一个节点）、second（第二个节点）
//   - 交换步骤：
//     1. prev.next = second
//     2. first.next = second.next
//     3. second.next = first
//     4. prev = first（移动到下一对的前驱位置）
//
// 实现步骤：
//   1. 创建 dummy 节点，dummy.next = head, prev = dummy
//   2. while prev.next != null && prev.next.next != null（至少还有两个节点）：
//      a. first = prev.next
//      b. second = prev.next.next
//      c. 交换：prev.next=second; first.next=second.next; second.next=first
//      d. prev = first（移动 prev）
//   3. 返回 dummy.next

ListNode? swapPairs(ListNode? head) {
  // TODO: 创建 dummy 节点
  // TODO: prev = dummy
  // TODO: while prev.next != null && prev.next.next != null:
  //       获取 first 和 second
  //       执行交换
  //       prev 移动到 first
  // TODO: 返回 dummy.next
  throw UnimplementedError(); // 请替换为你的实现
}
