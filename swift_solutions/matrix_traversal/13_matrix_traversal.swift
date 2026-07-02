import Foundation

/// ---------------------------------------------------------------------------
/// 模式：矩阵遍历（Matrix Traversal）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// 矩阵题通常把每个格子看作图节点，再配合 DFS 或 BFS 处理四联通关系。
/// 关键不是算法名字，而是边界检查、访问标记、方向数组三件事。
///
/// ## 适用场景
/// - Flood Fill。
/// - 岛屿数量。
/// - 区域包围、连通块搜索。
///
/// ## 时间复杂度
/// - 通常 O(mn)
///
/// ## 空间复杂度
/// - 递归栈或队列最坏 O(mn)
///
/// ## Swift 语法提示
/// - `inout` 允许函数直接修改外部变量，这在 DFS 改网格时非常常见。
enum MatrixTraversalSolutions {
    // ============================================================================
    // LeetCode #733: Flood Fill
    // ============================================================================
    // 所属模式：Matrix Traversal（DFS 染色）
    // 难度：Easy
    // 题目描述：
    //   从起点开始，把四联通且颜色相同的区域染成新颜色。
    static func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        var image = image
        let original = image[sr][sc]
        guard original != color else { return image }
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        func dfs(_ row: Int, _ col: Int) {
            guard row >= 0, row < image.count, col >= 0, col < image[0].count else { return }
            guard image[row][col] == original else { return }
            image[row][col] = color
            for (dr, dc) in directions {
                dfs(row + dr, col + dc)
            }
        }

        dfs(sr, sc)
        return image
    }

    // ============================================================================
    // LeetCode #200: Number of Islands
    // ============================================================================
    // 所属模式：Matrix Traversal（连通块计数）
    // 难度：Medium
    // 题目描述：
    //   统计二维网格中岛屿的数量。
    static func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty, !grid[0].isEmpty else { return 0 }
        var grid = grid
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        func dfs(_ row: Int, _ col: Int) {
            guard row >= 0, row < grid.count, col >= 0, col < grid[0].count else { return }
            guard grid[row][col] == "1" else { return }
            grid[row][col] = "0"
            for (dr, dc) in directions {
                dfs(row + dr, col + dc)
            }
        }

        var count = 0
        for row in 0..<grid.count {
            for col in 0..<grid[0].count where grid[row][col] == "1" {
                count += 1
                dfs(row, col)
            }
        }
        return count
    }

    // ============================================================================
    // LeetCode #130: Surrounded Regions
    // ============================================================================
    // 所属模式：Matrix Traversal（边界逆向思考）
    // 难度：Medium
    // 题目描述：
    //   把所有被 X 完全包围的 O 改成 X，边界联通的 O 保留。
    //
    // 核心考点：
    //   - 不去直接找“该翻转谁”，而是先找“绝对不能翻转谁”。
    static func solve(_ board: inout [[Character]]) {
        guard !board.isEmpty, !board[0].isEmpty else { return }
        let rows = board.count
        let cols = board[0].count
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        func dfs(_ row: Int, _ col: Int) {
            guard row >= 0, row < rows, col >= 0, col < cols else { return }
            guard board[row][col] == "O" else { return }
            board[row][col] = "#"
            for (dr, dc) in directions {
                dfs(row + dr, col + dc)
            }
        }

        for row in 0..<rows {
            dfs(row, 0)
            dfs(row, cols - 1)
        }
        for col in 0..<cols {
            dfs(0, col)
            dfs(rows - 1, col)
        }

        for row in 0..<rows {
            for col in 0..<cols {
                if board[row][col] == "O" {
                    board[row][col] = "X"
                } else if board[row][col] == "#" {
                    board[row][col] = "O"
                }
            }
        }
    }
}
