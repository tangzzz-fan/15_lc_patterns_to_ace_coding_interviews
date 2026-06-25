/// ---------------------------------------------------------------------------
/// 模式：快慢指针（Fast & Slow Pointers / 龟兔赛跑）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 使用两个指针，慢指针每次移动 1 步，快指针每次移动 2 步。
/// 如果存在循环（环），快指针最终会"追上"慢指针（速度差为 1，每轮缩小差距 1 步）。
/// 如果无环，快指针会到达终点。
///
/// ## 适用场景
/// - 链表判环（检测是否有环、找到环的入口）。
/// - 寻找链表中点。
/// - 寻找重复数（将数组视为隐式链表）。
/// - Happy Number（快乐数检测）。
///
/// ## 关键技巧
/// Floyd 判圈算法：
///   阶段 1：快慢指针相遇 → 有环
///   阶段 2：slow 回到 head，两者同速前进，再次相遇 → 环的入口
///
/// ## 时间复杂度
/// - O(n)，快指针最多走 n 步。
///
/// ## 空间复杂度
/// - O(1)，只使用两个指针。

// 链表节点定义
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

// ============================================================================
// LeetCode #141: Linked List Cycle（Easy）
// ============================================================================
// 题目描述：
//   给定一个链表，判断链表中是否有环。如果有环返回 true，否则返回 false。
//
// 解题思路（Floyd 判圈）：
//   slow 走 1 步，fast 走 2 步
//   - 如果 fast 能追上 slow → 有环
//   - 如果 fast 到达 null → 无环
//
// 实现步骤：
//   1. slow = head, fast = head
//   2. while fast != null && fast.next != null：
//      slow = slow.next（走 1 步）
//      fast = fast.next.next（走 2 步）
//      如果 slow == fast → 返回 true
//   3. 返回 false

bool hasCycle(ListNode? head) {
  // TODO: slow = head, fast = head
  // TODO: while fast != null && fast.next != null:
  //       slow = slow.next
  //       fast = fast.next.next
  //       若 slow == fast → return true
  // TODO: return false
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #202: Happy Number（Easy）
// ============================================================================
// 题目描述：
//   判断一个数 n 是不是快乐数。快乐数定义为：每次将该数替换为各位数字的平方和，
//   重复此过程直到变为 1（是快乐数）或进入不含 1 的循环（不是快乐数）。
//
// 解题思路（隐式链表 + 快慢指针）：
//   将数字变换过程看作一个隐式链表：n → next(n) → next(next(n)) → ...
//   用快慢指针检测循环：
//   - 如果 fast 到达 1 → 是快乐数
//   - 如果 slow 和 fast 在非 1 位置相遇 → 不是快乐数（进入循环）
//
// 实现步骤：
//   1. 定义辅助函数 getNext(num)：计算各位数字的平方和
//      - while num > 0: digit = num % 10; sum += digit * digit; num ~/= 10
//   2. slow = n, fast = getNext(n)
//   3. while fast != 1 && slow != fast：
//      slow = getNext(slow)
//      fast = getNext(getNext(fast))
//   4. 返回 fast == 1

bool isHappy(int n) {
  // TODO: 实现 getNext 辅助函数（各位数字平方和）
  // TODO: slow = n, fast = getNext(n)
  // TODO: while fast != 1 && slow != fast:
  //       slow = getNext(slow)
  //       fast = getNext(getNext(fast))
  // TODO: 返回 fast == 1
  throw UnimplementedError(); // 请替换为你的实现
}

// ============================================================================
// LeetCode #287: Find the Duplicate Number（Medium）
// ============================================================================
// 题目描述：
//   给定一个包含 n+1 个整数的数组 nums，数字都在 [1, n] 内。只有一个数字重复。
//   找出这个重复数字。要求：不修改数组，O(1) 额外空间，O(n) 时间。
//
// 解题思路（数组视为隐式链表 + Floyd 判圈）：
//   数组下标 → 值的映射就是链表的 next 指针
//   nums[i] 就是节点 i 的 next 指向
//   由于数字范围 [1, n]，每个元素都是有效下标
//   重复数字意味着有两个节点指向同一个 next → 形成了环！
//   环的入口节点 = 重复数字
//
// 实现步骤（两阶段）：
//   阶段 1（找相遇点）：
//     1. slow = nums[0], fast = nums[nums[0]]
//     2. while slow != fast：
//        slow = nums[slow]（1 步）
//        fast = nums[nums[fast]]（2 步）
//   阶段 2（找环入口 = 重复数）：
//     3. slow = 0（回到起点）
//     4. while slow != fast：
//        slow = nums[slow]（同速前进）
//        fast = nums[fast]
//     5. 返回 slow

int findDuplicate(List<int> nums) {
  // TODO: 阶段 1：slow=nums[0], fast=nums[nums[0]]，找相遇点
  // TODO: 阶段 2：slow=0，slow 和 fast 同速前进，相遇即环入口
  // TODO: 返回 slow
  throw UnimplementedError(); // 请替换为你的实现
}
