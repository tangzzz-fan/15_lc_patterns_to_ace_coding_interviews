/// ---------------------------------------------------------------------------
/// 模式：链表原地反转（Linked List In-place Reversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 通过调整节点之间的 next 指针指向，在不使用额外空间（或仅使用少量指针变量）
/// 的情况下，反转链表的一部分或全部。核心操作是：用 prev、curr、next 三个指针
/// 迭代地翻转指针方向。
///
/// ## 适用场景
/// - 反转整个链表。
/// - 反转链表的某一段（从位置 m 到 n）。
/// - 两两交换链表节点。
/// - K 个一组翻转链表。
///
/// ## 时间复杂度
/// - O(n)，只需一次遍历链表。
///
/// ## 空间复杂度
/// - O(1)，只使用常数量级的额外指针变量。

// 注意：ListNode 定义已存在于 fast_slow_pointers.dart 中。
// 此处为了文件独立性，再次声明。
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

// ============================================================================
// LeetCode #206: Reverse Linked List
// ============================================================================
// 所属模式：Linked List In-place Reversal（链表原地反转）
// 难度：Easy
// 题目描述：
//   给定单链表的头节点 head，请反转链表，并返回反转后的链表头节点。
//
// 核心考点：
//   - 三指针迭代法的标准模板。
//   - 正确处理 prev、curr、next 之间的关系。
//
// 解题思路推导：
//   反转链表的核心操作：让每个节点的 next 指向它的前一个节点。
//   迭代法：使用三个指针 prev（前驱）、curr（当前）、nextTemp（后继）。
//   - 保存 curr.next 到 nextTemp（否则链会断开）。
//   - 将 curr.next 指向 prev（反转）。
//   - prev 和 curr 各前进一步。
//
//   举例：1 → 2 → 3 → null
//   初始：prev=null, curr=1
//   第 1 步：nextTemp=2, 1→null, prev=1, curr=2
//   第 2 步：nextTemp=3, 2→1, prev=2, curr=3
//   第 3 步：nextTemp=null, 3→2, prev=3, curr=null
//   结果：3 → 2 → 1 → null，返回 prev(3)
//
// 实现步骤：
//   1. 初始化 prev = null, curr = head。
//   2. while curr != null：
//      a. 保存 nextTemp = curr.next。
//      b. curr.next = prev（反转指针）。
//      c. prev = curr（prev 前进一步）。
//      d. curr = nextTemp（curr 前进一步）。
//   3. 返回 prev（新的头节点）。

ListNode? reverseList(ListNode? head) {
  ListNode? prev = null; // 前驱节点（初始为 null，因为反转后原头节点指向 null）
  ListNode? curr = head; // 当前处理的节点

  while (curr != null) {
    ListNode? nextTemp = curr.next; // 保存后继节点，防止断链
    curr.next = prev; // 核心操作：将当前节点的 next 指向前驱（反转方向）
    prev = curr; // 前驱指针前进一步
    curr = nextTemp; // 当前指针前进一步
  }

  return prev; // prev 即为新链表的头节点
}

// ============================================================================
// LeetCode #92: Reverse Linked List II
// ============================================================================
// 所属模式：Linked List In-place Reversal（链表原地反转 - 局部反转）
// 难度：Medium
// 题目描述：
//   给定单链表的头节点 head 和两个整数 left、right，其中 left <= right。
//   请反转从位置 left 到位置 right 的链表节点，返回反转后的链表。
//   下标从 1 开始。
//
// 核心考点：
//   - 局部反转链表。
//   - 正确维护反转段与前驱、后继的连接关系。
//   - 使用哑节点（dummy node）简化头节点被反转的情况。
//
// 解题思路推导：
//   关键：反转 [left, right] 段，需要找到 left 的前驱节点（用于重连）。
//   设 prev 为第 left-1 个节点（前驱），curr 为第 left 个节点。
//   对 [left+1, right] 的每个节点，执行"头插法"：将其移到反转段的最前面。
//
//   举例：1 → 2 → 3 → 4 → 5, left=2, right=4
//   初始：prev=1（前驱）, curr=2
//   第 1 次：将 3 插到 prev 后面 → 1→3→2→4→5
//   第 2 次：将 4 插到 prev 后面 → 1→4→3→2→5
//   结果反转了 [2,3,4] 为 [4,3,2]
//
// 实现步骤：
//   1. 创建 dummy 节点，dummy.next = head（处理 left=1 的情况）。
//   2. 移动 prev 到第 left-1 个节点。
//   3. curr = prev.next（第 left 个节点）。
//   4. 循环 right - left 次：
//      a. nextTemp = curr.next（要移到前面的节点）。
//      b. curr.next = nextTemp.next（跳过 nextTemp）。
//      c. nextTemp.next = prev.next（nextTemp 指向反转段的最前面）。
//      d. prev.next = nextTemp（prev 连接新的最前面节点）。
//   5. 返回 dummy.next。

ListNode? reverseBetween(ListNode? head, int left, int right) {
  if (head == null) return null;

  // 创建哑节点，简化边界处理
  ListNode dummy = ListNode(0, head);
  ListNode prev = dummy;

  // 移动 prev 到第 left - 1 个节点
  for (int i = 1; i < left; i++) {
    prev = prev.next!;
  }

  // curr 指向第 left 个节点（反转段中保持不变，后续节点逐个移到它前面）
  ListNode curr = prev.next!;

  // 头插法：每次将 curr 后面的一个节点插到 prev 后面
  for (int i = 0; i < right - left; i++) {
    ListNode? nextTemp = curr.next; // 要前移的节点
    curr.next = nextTemp!.next; // 跳过 nextTemp（curr 连到 nextTemp 后面的节点）
    nextTemp.next = prev.next; // nextTemp 指向当前反转段的最前面
    prev.next = nextTemp; // prev 连接新的最前面节点
  }

  return dummy.next;
}

// ============================================================================
// LeetCode #24: Swap Nodes in Pairs
// ============================================================================
// 所属模式：Linked List In-place Reversal（链表原地反转 - 节点交换变体）
// 难度：Medium
// 题目描述：
//   给定一个链表，两两交换其中相邻的节点，并返回交换后的链表头节点。
//   必须在不修改节点内部值的情况下完成（只能进行节点交换）。
//   例如：1 → 2 → 3 → 4 → 2 → 1 → 4 → 3
//
// 核心考点：
//   - 链表节点交换的标准操作。
//   - 使用 dummy 节点处理头节点交换。
//   - 三指针操作：prev（前驱）、first（第一个节点）、second（第二个节点）。
//
// 解题思路推导：
//   交换相邻的两个节点 first 和 second：
//   - prev.next → second
//   - first.next → second.next
//   - second.next → first
//   然后 prev 移动到 first（因为 first 现在是这一对的第二个节点），继续处理下一对。
//
//   举例：1 ↔ 2, 然后处理 3 ↔ 4
//   初始：dummy → 1(prev) → 2 → 3 → 4
//   第 1 步：dummy → 2 → 1 → 3 → 4，prev 移到 1
//   第 2 步：2 → 1(prev) → 4 → 3，prev 移到 3
//   结果：2 → 1 → 4 → 3
//
// 实现步骤：
//   1. 创建 dummy 节点，dummy.next = head。
//   2. prev = dummy。
//   3. while prev.next != null 且 prev.next.next != null（至少有 2 个节点可交换）：
//      a. first = prev.next。
//      b. second = prev.next.next。
//      c. 交换：prev.next = second；first.next = second.next；second.next = first。
//      d. prev = first（移动 prev 到下一对之前）。
//   4. 返回 dummy.next。

ListNode? swapPairs(ListNode? head) {
  // 创建哑节点
  ListNode dummy = ListNode(0, head);
  ListNode prev = dummy;

  // 至少需要两个节点才能交换
  while (prev.next != null && prev.next!.next != null) {
    ListNode first = prev.next!; // 第一个节点
    ListNode? second = prev.next!.next; // 第二个节点

    // 执行交换
    prev.next = second; // 前驱指向第二个节点
    first.next = second!.next; // 第一个节点的 next 指向第二个节点的 next
    second.next = first; // 第二个节点的 next 指向第一个节点（交换完成）

    // prev 移动到这个新 pair 的第二个节点（即 first），准备处理下一对
    prev = first;
  }

  return dummy.next;
}
