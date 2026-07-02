import Foundation

/// ---------------------------------------------------------------------------
/// 模式：快慢指针（Fast & Slow Pointers）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 让两个指针以不同速度前进。如果底层结构存在环，快指针最终会追上慢指针。
/// 这个思想既能用于链表判环，也能用于“函数映射”上的环检测。
///
/// ## 适用场景
/// - 链表是否有环。
/// - 快乐数、寻找重复数这类“状态会重复”的问题。
/// - 找中点、找入环点。
///
/// ## 时间复杂度
/// - 常见为 O(n)。
///
/// ## 空间复杂度
/// - O(1)。
///
/// ## Swift 语法提示
/// - `===` 用于比较两个类实例是否为同一个引用，这和 `==` 的值比较不同。
/// - 链表、树、图节点一般用 `class`，因为需要引用语义。
enum FastSlowPointersSolutions {
    final class ListNode {
        var val: Int
        var next: ListNode?

        init(_ val: Int, _ next: ListNode? = nil) {
            self.val = val
            self.next = next
        }
    }

    // ============================================================================
    // LeetCode #141: Linked List Cycle
    // ============================================================================
    // 所属模式：Fast & Slow Pointers（链表判环）
    // 难度：Easy
    // 题目描述：
    //   判断链表中是否存在环。
    //
    // 核心考点：
    //   - 快指针一次走两步，慢指针一次走一步。
    //   - 如果存在环，二者一定会在环内相遇。
    //
    // 解题思路推导：
    //   无环时快指针会先到 nil；有环时快慢指针速度差为 1，必定追上。
    //
    // 实现步骤：
    //   1. slow、fast 都从 head 出发。
    //   2. fast 每次走两步，slow 每次走一步。
    //   3. 如果某次 `slow === fast`，返回 true。
    static func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head

        while let nextFast = fast?.next {
            slow = slow?.next
            fast = nextFast.next
            if let slowNode = slow, let fastNode = fast, slowNode === fastNode {
                return true
            }
        }

        return false
    }

    // ============================================================================
    // LeetCode #202: Happy Number
    // ============================================================================
    // 所属模式：Fast & Slow Pointers（状态环检测）
    // 难度：Easy
    // 题目描述：
    //   不断把数字替换成其各位平方和，判断最终是否会到达 1。
    //
    // 核心考点：
    //   - 把“数字变换”看作 next(x) 映射。
    //   - 如果不是快乐数，状态一定进入循环。
    //
    // 解题思路推导：
    //   这是一个函数图上的判环问题。到 1 说明结束；进入非 1 的环说明失败。
    //
    // 实现步骤：
    //   1. 定义 nextNumber 计算下一状态。
    //   2. slow 每次走一步，fast 每次走两步。
    //   3. 如果 fast 或 slow 到 1，返回 true；相遇且不为 1，返回 false。
    static func isHappy(_ n: Int) -> Bool {
        func nextNumber(_ value: Int) -> Int {
            var number = value
            var sum = 0
            while number > 0 {
                let digit = number % 10
                sum += digit * digit
                number /= 10
            }
            return sum
        }

        var slow = n
        var fast = nextNumber(n)

        while fast != 1 && slow != fast {
            slow = nextNumber(slow)
            fast = nextNumber(nextNumber(fast))
        }

        return fast == 1
    }

    // ============================================================================
    // LeetCode #287: Find the Duplicate Number
    // ============================================================================
    // 所属模式：Fast & Slow Pointers（数组映射成链表）
    // 难度：Medium
    // 题目描述：
    //   数组包含 n + 1 个数字，取值都在 [1, n]，只有一个重复数，找出它。
    //
    // 核心考点：
    //   - 把下标看作节点，把 nums[i] 看作 next 指针。
    //   - Floyd 判环后，再求入环点。
    //
    // 解题思路推导：
    //   重复数字意味着多个位置指向同一个“下一节点”，因此一定形成环。
    //   环的入口就是重复的数字。
    //
    // 实现步骤：
    //   1. 第一阶段让 slow、fast 相遇。
    //   2. 第二阶段让一个指针回到起点，两者同步前进。
    //   3. 再次相遇的位置就是重复数。
    static func findDuplicate(_ nums: [Int]) -> Int {
        var slow = nums[0]
        var fast = nums[0]

        repeat {
            slow = nums[slow]
            fast = nums[nums[fast]]
        } while slow != fast

        var finder = nums[0]
        while finder != slow {
            finder = nums[finder]
            slow = nums[slow]
        }

        return finder
    }
}

