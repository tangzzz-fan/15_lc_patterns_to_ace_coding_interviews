import Foundation

/// ---------------------------------------------------------------------------
/// 模式：回溯（Backtracking）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 回溯就是在“决策树”上做 DFS：
/// - 进入下一层前，先做选择。
/// - 返回上一层时，再撤销选择。
/// 它适合求“全部可行解”而不是单个最优值。
///
/// ## 适用场景
/// - 全排列。
/// - 子集、组合。
/// - N 皇后。
///
/// ## 时间复杂度
/// - 取决于搜索树规模，通常是指数级或阶乘级。
///
/// ## 空间复杂度
/// - 递归深度 + 路径存储。
///
/// ## Swift 语法提示
/// - `Set<Int>` 很适合做约束剪枝，例如记录列、主对角线、副对角线占用情况。
enum BacktrackingSolutions {
    // ============================================================================
    // LeetCode #46: Permutations
    // ============================================================================
    // 所属模式：Backtracking（排列）
    // 难度：Medium
    // 题目描述：
    //   返回数组的所有排列。
    static func permute(_ nums: [Int]) -> [[Int]] {
        var answer: [[Int]] = []
        var path: [Int] = []
        var visited = Array(repeating: false, count: nums.count)

        func backtrack() {
            if path.count == nums.count {
                answer.append(path)
                return
            }

            for index in 0..<nums.count {
                if visited[index] { continue }
                visited[index] = true
                path.append(nums[index])
                backtrack()
                path.removeLast()
                visited[index] = false
            }
        }

        backtrack()
        return answer
    }

    // ============================================================================
    // LeetCode #78: Subsets
    // ============================================================================
    // 所属模式：Backtracking（子集）
    // 难度：Medium
    // 题目描述：
    //   返回数组的所有子集。
    static func subsets(_ nums: [Int]) -> [[Int]] {
        var answer: [[Int]] = []
        var path: [Int] = []

        func backtrack(_ start: Int) {
            answer.append(path)
            guard start < nums.count else { return }

            for index in start..<nums.count {
                path.append(nums[index])
                backtrack(index + 1)
                path.removeLast()
            }
        }

        backtrack(0)
        return answer
    }

    // ============================================================================
    // LeetCode #51: N-Queens
    // ============================================================================
    // 所属模式：Backtracking（约束搜索）
    // 难度：Hard
    // 题目描述：
    //   返回所有 N 皇后的合法摆放方案。
    //
    // 核心考点：
    //   - 列、主对角线、副对角线的冲突判断。
    //   - 逐行放置皇后，每一行只放一个。
    static func solveNQueens(_ n: Int) -> [[String]] {
        var board = Array(repeating: Array(repeating: Character("."), count: n), count: n)
        var cols = Set<Int>()
        var diag1 = Set<Int>()
        var diag2 = Set<Int>()
        var answer: [[String]] = []

        func backtrack(_ row: Int) {
            if row == n {
                answer.append(board.map { String($0) })
                return
            }

            for col in 0..<n {
                let d1 = row - col
                let d2 = row + col
                if cols.contains(col) || diag1.contains(d1) || diag2.contains(d2) {
                    continue
                }

                cols.insert(col)
                diag1.insert(d1)
                diag2.insert(d2)
                board[row][col] = "Q"

                backtrack(row + 1)

                board[row][col] = "."
                cols.remove(col)
                diag1.remove(d1)
                diag2.remove(d2)
            }
        }

        backtrack(0)
        return answer
    }
}
