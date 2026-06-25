/// 共享数据结构
/// 供所有解题文件引用，避免重复定义类导致的冲突。

/// 单链表节点
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

/// 二叉树节点
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

/// 图的节点（邻接表表示）
class GraphNode {
  int val;
  List<GraphNode> neighbors;
  GraphNode(this.val, [List<GraphNode>? neighbors])
      : neighbors = neighbors ?? [];
}

/// 辅助函数：从数组构建链表
/// [1, 2, 3] → 1 → 2 → 3
ListNode? buildList(List<int> values) {
  if (values.isEmpty) return null;
  ListNode head = ListNode(values[0]);
  ListNode curr = head;
  for (int i = 1; i < values.length; i++) {
    curr.next = ListNode(values[i]);
    curr = curr.next!;
  }
  return head;
}

/// 辅助函数：链表转数组（便于测试断言）
List<int> listToArray(ListNode? head) {
  List<int> result = [];
  ListNode? curr = head;
  while (curr != null) {
    result.add(curr.val);
    curr = curr.next;
  }
  return result;
}

/// 辅助函数：给链表末尾创建环（测试环形链表用）
/// 从 head 出发找到第 cycleEntryIndex 个节点，将尾节点的 next 指向它
void createCycle(ListNode? head, int cycleEntryIndex) {
  if (head == null) return;
  ListNode? entry;
  ListNode? tail;
  ListNode? curr = head;
  int i = 0;
  while (curr != null) {
    if (i == cycleEntryIndex) entry = curr;
    tail = curr;
    curr = curr.next;
    i++;
  }
  if (tail != null && entry != null) {
    tail.next = entry;
  }
}
