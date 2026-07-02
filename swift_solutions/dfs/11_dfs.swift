import Foundation

/// ---------------------------------------------------------------------------
/// 模式：深度优先搜索（DFS）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// DFS 会沿着一条路径不断深入，直到不能继续，再回到上一个分叉点。
/// 因此它非常适合路径枚举、图遍历、树形递归和拓扑排序。
///
/// ## 适用场景
/// - 图克隆。
/// - 树路径搜索。
/// - 图上的环检测与拓扑排序。
///
/// ## 时间复杂度
/// - 常见为 O(V + E) 或 O(n)。
///
/// ## 空间复杂度
/// - 递归栈最坏 O(V) 或 O(h)。
///
/// ## Swift 语法提示
/// - `ObjectIdentifier` 可以把类实例的身份转成可哈希值。
/// - `guard let node else { return }` 是常见的可选绑定简写。
enum DFSSolutions {
    final class GraphNode: Hashable {
        var val: Int
        var neighbors: [GraphNode]

        init(_ val: Int) {
            self.val = val
            self.neighbors = []
        }

        static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
            lhs === rhs
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }
    }

    final class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?

        init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    // ============================================================================
    // LeetCode #133: Clone Graph
    // ============================================================================
    // 所属模式：DFS（图克隆）
    // 难度：Medium
    // 题目描述：
    //   深拷贝一张无向图。
    //
    // 核心考点：
    //   - 递归克隆当前节点，再递归克隆所有邻居。
    //   - visited 表要先记后搜，防止环上无限递归。
    static func cloneGraph(_ node: GraphNode?) -> GraphNode? {
        var visited: [GraphNode: GraphNode] = [:]

        func dfs(_ current: GraphNode?) -> GraphNode? {
            guard let current else { return nil }
            if let clone = visited[current] { return clone }

            let clone = GraphNode(current.val)
            visited[current] = clone
            clone.neighbors = current.neighbors.compactMap { dfs($0) }
            return clone
        }

        return dfs(node)
    }

    // ============================================================================
    // LeetCode #113: Path Sum II
    // ============================================================================
    // 所属模式：DFS（根到叶路径）
    // 难度：Medium
    // 题目描述：
    //   返回所有从根到叶子节点且路径和等于 targetSum 的路径。
    static func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var answer: [[Int]] = []
        var path: [Int] = []

        func dfs(_ node: TreeNode?, _ remain: Int) {
            guard let node else { return }
            path.append(node.val)

            if node.left == nil && node.right == nil && remain == node.val {
                answer.append(path)
            } else {
                dfs(node.left, remain - node.val)
                dfs(node.right, remain - node.val)
            }

            path.removeLast()
        }

        dfs(root, targetSum)
        return answer
    }

    // ============================================================================
    // LeetCode #210: Course Schedule II
    // ============================================================================
    // 所属模式：DFS（拓扑排序）
    // 难度：Medium
    // 题目描述：
    //   返回一个可行的修课顺序；如果存在环，则返回空数组。
    //
    // 核心考点：
    //   - 0/1/2 三色标记：未访问、访问中、已完成。
    //   - 发现回边说明有环。
    static func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var graph = Array(repeating: [Int](), count: numCourses)
        for edge in prerequisites {
            graph[edge[1]].append(edge[0])
        }

        var state = Array(repeating: 0, count: numCourses)
        var order: [Int] = []
        var hasCycle = false

        func dfs(_ course: Int) {
            if hasCycle { return }
            state[course] = 1

            for next in graph[course] {
                if state[next] == 0 {
                    dfs(next)
                } else if state[next] == 1 {
                    hasCycle = true
                    return
                }
            }

            state[course] = 2
            order.append(course)
        }

        for course in 0..<numCourses where state[course] == 0 {
            dfs(course)
        }

        return hasCycle ? [] : order.reversed()
    }
}
