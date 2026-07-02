import Foundation

/// ---------------------------------------------------------------------------
/// 模式：广度优先搜索（BFS）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// BFS 按层推进，因此第一次到达某个状态时，通常就已经使用了最少步数。
/// 这正是它适合最短路径问题的原因。
///
/// ## 适用场景
/// - 二叉树层序遍历。
/// - 网格最短扩散时间。
/// - 无权图最短路径。
///
/// ## 时间复杂度
/// - 常见为 O(V + E) 或 O(mn)。
///
/// ## 空间复杂度
/// - 队列最坏可达 O(V) 或 O(mn)。
///
/// ## Swift 语法提示
/// - Swift 数组头删是 O(n)，因此这里使用“数组 + 头指针”模拟队列。
enum BFSSolutions {
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
    // LeetCode #102: Binary Tree Level Order Traversal
    // ============================================================================
    // 所属模式：BFS（层序遍历）
    // 难度：Medium
    // 题目描述：
    //   按层返回二叉树节点值。
    static func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root else { return [] }
        var queue: [TreeNode] = [root]
        var head = 0
        var answer: [[Int]] = []

        while head < queue.count {
            let levelCount = queue.count - head
            var level: [Int] = []
            for _ in 0..<levelCount {
                let node = queue[head]
                head += 1
                level.append(node.val)
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
            answer.append(level)
        }

        return answer
    }

    // ============================================================================
    // LeetCode #994: Rotting Oranges
    // ============================================================================
    // 所属模式：BFS（多源扩散）
    // 难度：Medium
    // 题目描述：
    //   求所有新鲜橘子都腐烂所需的最少分钟数。
    static func orangesRotting(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty, !grid[0].isEmpty else { return 0 }
        var grid = grid
        var queue: [(Int, Int)] = []
        var head = 0
        var fresh = 0
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                if grid[row][col] == 2 {
                    queue.append((row, col))
                } else if grid[row][col] == 1 {
                    fresh += 1
                }
            }
        }

        var minutes = 0
        while head < queue.count && fresh > 0 {
            let levelCount = queue.count - head
            minutes += 1
            for _ in 0..<levelCount {
                let (row, col) = queue[head]
                head += 1
                for (dr, dc) in directions {
                    let nr = row + dr
                    let nc = col + dc
                    guard nr >= 0, nr < grid.count, nc >= 0, nc < grid[0].count else { continue }
                    guard grid[nr][nc] == 1 else { continue }
                    grid[nr][nc] = 2
                    fresh -= 1
                    queue.append((nr, nc))
                }
            }
        }

        return fresh == 0 ? minutes : -1
    }

    // ============================================================================
    // LeetCode #127: Word Ladder
    // ============================================================================
    // 所属模式：BFS（无权图最短路径）
    // 难度：Hard
    // 题目描述：
    //   每次只能修改一个字符，求从 beginWord 到 endWord 的最短转换序列长度。
    //
    // 核心考点：
    //   - 用 Set 存字典，生成相邻状态后立即删除，避免重复入队。
    //   - Swift 字符串不支持整数下标，因此先转 `[Character]` 再原位改字符。
    static func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var words = Set(wordList)
        guard words.contains(endWord) else { return 0 }

        var queue: [(String, Int)] = [(beginWord, 1)]
        var head = 0
        words.remove(beginWord)

        while head < queue.count {
            let (word, step) = queue[head]
            head += 1
            if word == endWord { return step }

            var chars = Array(word)
            for index in 0..<chars.count {
                let original = chars[index]
                for ascii in 97...122 {
                    let candidate = Character(UnicodeScalar(ascii)!)
                    if candidate == original { continue }
                    chars[index] = candidate
                    let nextWord = String(chars)
                    if words.contains(nextWord) {
                        words.remove(nextWord)
                        queue.append((nextWord, step + 1))
                    }
                }
                chars[index] = original
            }
        }

        return 0
    }
}
