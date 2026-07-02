import Foundation

/// ---------------------------------------------------------------------------
/// 模式：前 K 个元素（Top K Elements）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 当题目只关心“最大的 K 个”或“最小的 K 个”时，没有必要把全部元素完整排序。
/// 用堆维护一个局部有序结构，能把复杂度降到 O(n log k)。
///
/// ## 适用场景
/// - 第 K 大 / 第 K 小。
/// - Top K 高频元素。
/// - K 个最小和数对。
///
/// ## 时间复杂度
/// - 常见为 O(n log k)
///
/// ## 空间复杂度
/// - 常见为 O(k)
///
/// ## Swift 语法提示
/// - 这里实现了一个泛型堆 `Heap<Element>`。
/// - `priorityFunction` 是比较闭包，用它决定这是最小堆还是最大堆。
/// - Swift 元组可以直接存 `(sum, i, j)` 这种状态，非常适合堆节点。
enum TopKElementsSolutions {
    struct Heap<Element> {
        private var elements: [Element] = []
        private let priorityFunction: (Element, Element) -> Bool

        init(sort: @escaping (Element, Element) -> Bool) {
            self.priorityFunction = sort
        }

        var isEmpty: Bool { elements.isEmpty }
        var count: Int { elements.count }
        var peek: Element? { elements.first }

        mutating func insert(_ value: Element) {
            elements.append(value)
            siftUp(from: elements.count - 1)
        }

        @discardableResult
        mutating func remove() -> Element? {
            guard !elements.isEmpty else { return nil }
            if elements.count == 1 {
                return elements.removeLast()
            }
            elements.swapAt(0, elements.count - 1)
            let value = elements.removeLast()
            siftDown(from: 0)
            return value
        }

        private mutating func siftUp(from index: Int) {
            var child = index
            var parent = (child - 1) / 2
            while child > 0 && priorityFunction(elements[child], elements[parent]) {
                elements.swapAt(child, parent)
                child = parent
                parent = (child - 1) / 2
            }
        }

        private mutating func siftDown(from index: Int) {
            var parent = index
            while true {
                let left = parent * 2 + 1
                let right = parent * 2 + 2
                var candidate = parent

                if left < elements.count && priorityFunction(elements[left], elements[candidate]) {
                    candidate = left
                }
                if right < elements.count && priorityFunction(elements[right], elements[candidate]) {
                    candidate = right
                }
                if candidate == parent { return }
                elements.swapAt(parent, candidate)
                parent = candidate
            }
        }
    }

    // ============================================================================
    // LeetCode #215: Kth Largest Element in an Array
    // ============================================================================
    // 所属模式：Top K Elements（大小为 K 的最小堆）
    // 难度：Medium
    // 题目描述：
    //   返回数组中的第 k 大元素。
    //
    // 核心考点：
    //   - 维护大小为 k 的最小堆。
    //   - 堆顶始终是当前“前 k 大元素”里最小的那个，也就是第 k 大。
    static func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var heap = Heap<Int>(sort: <)

        for num in nums {
            heap.insert(num)
            if heap.count > k {
                _ = heap.remove()
            }
        }

        return heap.peek ?? 0
    }

    // ============================================================================
    // LeetCode #347: Top K Frequent Elements
    // ============================================================================
    // 所属模式：Top K Elements（频率统计 + 最小堆）
    // 难度：Medium
    // 题目描述：
    //   返回出现频率最高的 k 个元素。
    //
    // 核心考点：
    //   - 先统计频率，再维护大小为 k 的最小堆。
    //   - 堆节点是 `(num, freq)` 二元组。
    static func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var frequency: [Int: Int] = [:]
        for num in nums {
            frequency[num, default: 0] += 1
        }

        var heap = Heap<(Int, Int)>(sort: { $0.1 < $1.1 })
        for (num, count) in frequency {
            heap.insert((num, count))
            if heap.count > k {
                _ = heap.remove()
            }
        }

        var answer: [Int] = []
        while let item = heap.remove() {
            answer.append(item.0)
        }
        return answer.reversed()
    }

    // ============================================================================
    // LeetCode #373: Find K Pairs with Smallest Sums
    // ============================================================================
    // 所属模式：Top K Elements（多路归并 + 最小堆）
    // 难度：Medium
    // 题目描述：
    //   在两个升序数组中找出和最小的 k 对数对。
    //
    // 核心考点：
    //   - 每个 nums1[i] 可以与 nums2 形成一条升序链。
    //   - 用最小堆做 k 次多路归并。
    //
    // 解题思路推导：
    //   先把 `(i, 0)` 全部入堆，表示每条链的起点。
    //   每次弹出最小和的 `(i, j)` 后，把 `(i, j + 1)` 放回去。
    static func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        guard !nums1.isEmpty, !nums2.isEmpty, k > 0 else { return [] }

        var heap = Heap<(Int, Int, Int)>(sort: { $0.0 < $1.0 })
        let limit = min(nums1.count, k)
        for i in 0..<limit {
            heap.insert((nums1[i] + nums2[0], i, 0))
        }

        var answer: [[Int]] = []
        while !heap.isEmpty && answer.count < k {
            guard let (_, i, j) = heap.remove() else { break }
            answer.append([nums1[i], nums2[j]])

            if j + 1 < nums2.count {
                heap.insert((nums1[i] + nums2[j + 1], i, j + 1))
            }
        }

        return answer
    }
}

