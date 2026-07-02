import Foundation

/// ---------------------------------------------------------------------------
/// 模式：二叉树遍历（Binary Tree Traversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 判断使用前序、中序还是后序，关键看父节点的处理时机：
/// - 前序：先处理父节点，再去子树。
/// - 中序：左子树处理完，再处理父节点。
/// - 后序：必须先拿到左右子树结果，才能处理父节点。
///
/// ## 适用场景
/// - 路径收集、BST 排序、树形 DP。
///
/// ## 时间复杂度
/// - O(n)
///
/// ## 空间复杂度
/// - O(h)，h 为树高。
///
/// ## Swift 语法提示
/// - 树节点一般使用 `class`，因为树结构依赖引用语义。
/// - `TreeNode?` 表示节点可能为空。
enum BinaryTreeTraversalSolutions {
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
    // LeetCode #257: Binary Tree Paths
    // ============================================================================
    // 所属模式：Binary Tree Traversal（前序遍历）
    // 难度：Easy
    // 题目描述：
    //   返回所有从根节点到叶子节点的路径。
    //
    // 核心考点：
    //   - 前序遍历边走边维护路径字符串。
    static func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var answer: [String] = []

        func dfs(_ node: TreeNode?, _ path: String) {
            guard let node else { return }
            let nextPath = path.isEmpty ? "\(node.val)" : "\(path)->\(node.val)"
            if node.left == nil && node.right == nil {
                answer.append(nextPath)
                return
            }
            dfs(node.left, nextPath)
            dfs(node.right, nextPath)
        }

        dfs(root, "")
        return answer
    }

    // ============================================================================
    // LeetCode #230: Kth Smallest Element in a BST
    // ============================================================================
    // 所属模式：Binary Tree Traversal（中序遍历）
    // 难度：Medium
    // 题目描述：
    //   返回 BST 中第 k 小的元素。
    //
    // 核心考点：
    //   - BST 中序遍历天然是升序。
    static func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var stack: [TreeNode] = []
        var current = root
        var count = 0

        while current != nil || !stack.isEmpty {
            while let node = current {
                stack.append(node)
                current = node.left
            }
            let node = stack.removeLast()
            count += 1
            if count == k { return node.val }
            current = node.right
        }

        return -1
    }

    // ============================================================================
    // LeetCode #124: Binary Tree Maximum Path Sum
    // ============================================================================
    // 所属模式：Binary Tree Traversal（后序遍历）
    // 难度：Hard
    // 题目描述：
    //   返回树中的最大路径和，路径不一定经过根节点。
    //
    // 核心考点：
    //   - 后序遍历先拿左右贡献。
    //   - “向父节点返回的单边路径”和“更新全局答案的完整路径”需要分开理解。
    static func maxPathSum(_ root: TreeNode?) -> Int {
        var answer = Int.min

        func dfs(_ node: TreeNode?) -> Int {
            guard let node else { return 0 }
            let leftGain = max(dfs(node.left), 0)
            let rightGain = max(dfs(node.right), 0)
            answer = max(answer, node.val + leftGain + rightGain)
            return node.val + max(leftGain, rightGain)
        }

        _ = dfs(root)
        return answer
    }
}
