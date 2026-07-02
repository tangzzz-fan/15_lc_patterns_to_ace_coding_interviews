import Foundation

/// ---------------------------------------------------------------------------
/// 模式：链表原地反转（Linked List In-place Reversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 链表反转的关键是重连 `next` 指针。每次保存原来的下一节点，再把当前节点指向前驱，
/// 最后整体向前推进。
///
/// ## 适用场景
/// - 整体反转链表。
/// - 反转区间 [left, right]。
/// - 两两交换、K 个一组翻转。
///
/// ## 时间复杂度
/// - O(n)
///
/// ## 空间复杂度
/// - O(1)
///
/// ## Swift 语法提示
/// - `guard` 用于提前处理空链表或无效区间，能显著降低嵌套层级。
/// - `final class` 表示这个类型不会再被继承，Swift 编译器更容易优化。
enum LinkedListReversalSolutions {
    final class ListNode {
        var val: Int
        var next: ListNode?

        init(_ val: Int, _ next: ListNode? = nil) {
            self.val = val
            self.next = next
        }
    }

    // ============================================================================
    // LeetCode #206: Reverse Linked List
    // ============================================================================
    // 所属模式：Linked List Reversal（整体反转）
    // 难度：Easy
    // 题目描述：
    //   反转单链表并返回新头节点。
    //
    // 核心考点：
    //   - 三指针：prev、current、next。
    //   - 每轮循环只改一条边。
    //
    // 解题思路推导：
    //   当前节点原本指向后继，反转后要改为指向前驱，所以必须先保存 next。
    //
    // 实现步骤：
    //   1. prev = nil，current = head。
    //   2. 保存 nextNode = current?.next。
    //   3. current?.next = prev。
    //   4. prev、current 一起前进。
    static func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode?
        var current = head

        while let node = current {
            let nextNode = node.next
            node.next = prev
            prev = node
            current = nextNode
        }

        return prev
    }

    // ============================================================================
    // LeetCode #92: Reverse Linked List II
    // ============================================================================
    // 所属模式：Linked List Reversal（区间反转）
    // 难度：Medium
    // 题目描述：
    //   反转链表中从 left 到 right 的部分，其他位置保持不变。
    //
    // 核心考点：
    //   - dummy 节点统一处理头节点被反转的情况。
    //   - 头插法原地反转一个局部区间。
    //
    // 解题思路推导：
    //   找到区间前一个节点 `pre` 后，把 `current` 后面的节点不断摘下来，
    //   插到 `pre` 后面，就能原地完成区间翻转。
    //
    // 实现步骤：
    //   1. 创建 dummy，指向 head。
    //   2. 让 pre 走到 left 的前一个节点。
    //   3. 用头插法执行 right - left 次局部反转。
    static func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        guard left < right else { return head }

        let dummy = ListNode(0, head)
        var pre: ListNode? = dummy

        for _ in 1..<left {
            pre = pre?.next
        }

        let current = pre?.next
        for _ in 0..<(right - left) {
            let next = current?.next
            current?.next = next?.next
            next?.next = pre?.next
            pre?.next = next
        }

        return dummy.next
    }

    // ============================================================================
    // LeetCode #24: Swap Nodes in Pairs
    // ============================================================================
    // 所属模式：Linked List Reversal（局部重连）
    // 难度：Medium
    // 题目描述：
    //   每两个节点交换一次，不能只交换值，必须真正交换节点。
    //
    // 核心考点：
    //   - 处理一组两个节点的重连。
    //   - 让前一组的尾巴连到新组头。
    //
    // 解题思路推导：
    //   每次取出 first、second 两个节点，把 second 放到 first 前面，
    //   然后把上一段链表接回来。
    //
    // 实现步骤：
    //   1. 用 dummy 统一处理头节点交换。
    //   2. 每轮检查是否还有两个节点可交换。
    //   3. 重连 prev -> second -> first -> nextPair。
    static func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0, head)
        var prev: ListNode? = dummy

        while let first = prev?.next, let second = first.next {
            let nextPair = second.next
            prev?.next = second
            second.next = first
            first.next = nextPair
            prev = first
        }

        return dummy.next
    }
}

