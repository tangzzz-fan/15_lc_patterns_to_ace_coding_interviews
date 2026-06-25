/// ---------------------------------------------------------------------------
/// 模式：广度优先搜索（BFS，Breadth-First Search）
/// ---------------------------------------------------------------------------
///
/// ## 核心原理
/// BFS 使用队列（Queue）从起始节点出发，按层逐层向外扩展。先访问距离起始节点为 1
/// 的所有节点，再访问距离为 2 的节点，依此类推。BFS 天然适合求无权图中的最短路径，
/// 因为它是按距离递增顺序访问节点的。
///
/// ## 适用场景
/// - 树的层序遍历（逐层输出节点）。
/// - 无权图的最短路径。
/// - 多源 BFS（如腐烂橘子问题，从多个起点同时扩散）。
/// - 迷宫/网格中的最短路径。
/// - 社交网络中的"距离"问题。
///
/// ## 时间复杂度
/// - O(V + E)，V 为顶点数，E 为边数。每个节点入队一次、出队一次。
///
/// ## 空间复杂度
/// - O(V)，队列中最多存储 V 个节点。

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// ============================================================================
// LeetCode #102: Binary Tree Level Order Traversal
// ============================================================================
// 所属模式：BFS（广度优先搜索 - 树的层序遍历）
// 难度：Medium
// 题目描述：
//   给定一个二叉树的根节点 root，返回其节点值的层序遍历（即逐层地从左到右访问）。
//   结果格式为 List<List<int>>，每个内层列表代表一层的节点值。
//
// 核心考点：
//   - BFS 层序遍历的标准模板。
//   - 按层分组输出（需要知道每层的节点数）。
//   - 队列（Queue）的使用。
//
// 解题思路推导：
//   使用队列维护当前层的节点。
//   每轮处理队列中当前层的所有节点（通过记录队列大小 levelSize），
//   将它们的值收集到当前层结果中，同时将子节点入队（作为下一层）。
//
//   举例：[3,9,20,null,null,15,7]
//   初始队列：[3], levelSize=1 → 处理 [3]，结果[[3]]，子节点入队：[9,20]
//   队列：[9,20], levelSize=2 → 处理 [9,20]，结果[[3],[9,20]]，子节点入队：[15,7]
//   队列：[15,7], levelSize=2 → 处理 [15,7]，结果[[3],[9,20],[15,7]]，子节点入队：[]
//   队列空，结束。
//
// 实现步骤：
//   1. 如果 root 为 null，返回 []。
//   2. 初始化 result = [], queue = [root]。
//   3. while queue 非空：
//      a. levelSize = queue.length（当前层节点数）。
//      b. 初始化 currentLevel = []。
//      c. 循环 levelSize 次：
//         - node = queue.removeFirst()（出队）。
//         - currentLevel.add(node.val)。
//         - 如果 node.left 不为 null，queue.add(node.left)。
//         - 如果 node.right 不为 null，queue.add(node.right)。
//      d. result.add(currentLevel)。
//   4. 返回 result。

List<List<int>> levelOrder(TreeNode? root) {
  List<List<int>> result = [];
  if (root == null) return result;

  // Dart 中可用 List 模拟队列
  List<TreeNode> queue = [root];

  while (queue.isNotEmpty) {
    int levelSize = queue.length; // 当前层的节点数量
    List<int> currentLevel = []; // 当前层的结果

    // 处理当前层的所有节点
    for (int i = 0; i < levelSize; i++) {
      TreeNode node = queue.removeAt(0); // 出队（FIFO）
      currentLevel.add(node.val);

      // 将子节点入队（作为下一层）
      if (node.left != null) queue.add(node.left!);
      if (node.right != null) queue.add(node.right!);
    }

    result.add(currentLevel); // 该层处理完毕
  }

  return result;
}

// ============================================================================
// LeetCode #994: Rotting Oranges
// ============================================================================
// 所属模式：BFS（广度优先搜索 - 多源 BFS / 网格扩散）
// 难度：Medium
// 题目描述：
//   在给定的 m×n 网格 grid 中，每个单元格可以有三个值之一：
//   - 0 代表空单元格
//   - 1 代表新鲜橘子
//   - 2 代表腐烂的橘子
//   每分钟，腐烂的橘子会使上下左右四个方向上相邻的新鲜橘子腐烂。
//   返回直到单元格中没有新鲜橘子为止所必须经过的最小分钟数。如果不可能，返回 -1。
//
// 核心考点：
//   - 多源 BFS（多个起始腐烂橘子同时扩散）。
//   - 网格中的 4 方向遍历。
//   - BFS 计算扩散时间 = BFS 的层数。
//
// 解题思路推导：
//   问题是典型的"扩散"问题。可以将所有初始的腐烂橘子作为 BFS 的起始点（多源），
//   同时向四个方向扩散。BFS 的"层数"就是经过的分钟数。
//
//   实现步骤：
//   1. 遍历网格，将所有腐烂橘子（2）的位置入队，同时统计新鲜橘子数量。
//   2. 如果初始无新鲜橘子，返回 0。
//   3. BFS：每分钟（每层）处理队列中所有腐烂橘子，向四个方向扩散：
//      - 检查相邻格子是否在边界内且为新鲜橘子（1）。
//      - 若是，将其变为腐烂（2），入队，新鲜橘子数--。
//   4. 每处理完一层，分钟数 +1（如果这一层有扩散的话）。
//   5. BFS 结束后，若新鲜橘子数 > 0，返回 -1；否则返回总分钟数。

int orangesRotting(List<List<int>> grid) {
  int rows = grid.length;
  int cols = grid[0].length;

  // 四个方向：上、下、左、右
  final List<List<int>> directions = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1],
  ];

  // 队列中存储 (row, col)
  List<List<int>> queue = [];
  int freshCount = 0; // 新鲜橘子数量

  // 第 1 步：初始化队列（所有腐烂橘子）和统计新鲜橘子
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (grid[r][c] == 2) {
        queue.add([r, c]); // 腐烂橘子作为 BFS 起始点
      } else if (grid[r][c] == 1) {
        freshCount++; // 统计新鲜橘子
      }
    }
  }

  // 没有新鲜橘子，返回 0
  if (freshCount == 0) return 0;

  int minutes = 0;

  // 第 2 步：BFS 扩散
  while (queue.isNotEmpty) {
    int levelSize = queue.length;
    bool rotted = false; // 本分钟是否有新腐烂的橘子

    for (int i = 0; i < levelSize; i++) {
      List<int> pos = queue.removeAt(0);
      int r = pos[0];
      int c = pos[1];

      // 向四个方向扩散
      for (List<int> dir in directions) {
        int nr = r + dir[0];
        int nc = c + dir[1];

        // 边界检查 + 是否为新鲜橘子
        if (nr >= 0 &&
            nr < rows &&
            nc >= 0 &&
            nc < cols &&
            grid[nr][nc] == 1) {
          grid[nr][nc] = 2; // 变为腐烂
          freshCount--; // 新鲜橘子减少
          queue.add([nr, nc]); // 新腐烂的橘子入队
          rotted = true;
        }
      }
    }

    // 本层有扩散才计入分钟数
    if (rotted) minutes++;
  }

  // 如果还有新鲜橘子，说明无法全部腐烂
  return freshCount == 0 ? minutes : -1;
}

// ============================================================================
// LeetCode #127: Word Ladder
// ============================================================================
// 所属模式：BFS（广度优先搜索 - 最短转换路径）
// 难度：Hard
// 题目描述：
//   字典 wordList 中从单词 beginWord 到 endWord 的最短转换序列的长度。
//   转换规则：每次只能改变一个字母，且转换过程中的每个中间单词必须在 wordList 中。
//   如果不存在这样的转换序列，返回 0。
//
// 核心考点：
//   - 将单词转换问题建模为图的最短路径。
//   - BFS 按层搜索，首次遇到 endWord 时的层数即为最短序列长度。
//   - 通配符建图优化：用 `h*t` 代替 `hot` 作为中间节点，加速邻居搜索。
//
// 解题思路推导：
//   朴素 BFS：对于每个单词，遍历 wordList 找相差一个字母的单词 → O(L·N²)，太慢。
//
//   优化方案（通配符建图）：
//   对于单词 "hot"，生成通配模式 "h*t", "ho*", "*ot" 作为中间节点。
//   这样所有能通过改变一个字母相互转换的单词会共享通配模式。
//   图的节点：所有单词 + 所有通配模式。
//   BFS 从 beginWord 开始，遇到 endWord 时记录步数。
//
//   举例：beginWord="hit", endWord="cog"
//   hit → h*t → hot → *ot → dot → do* → dog → *og → cog
//   序列长度 = 5
//
// 实现步骤：
//   1. 创建邻接表 patternMap：pattern → [words]。
//   2. 对每个单词，生成所有通配模式，建立映射。
//   3. BFS：
//      a. 队列元素为 (word, steps)。
//      b. visited Set 避免重复访问。
//      c. 从当前单词生成通配模式，通过 patternMap 获取所有可转换单词。
//      d. 如果某个可转换词 == endWord，返回 steps + 1。
//   4. BFS 结束未找到，返回 0。

int ladderLength(String beginWord, String endWord, List<String> wordList) {
  // 将 wordList 转为 Set，便于 O(1) 查找
  Set<String> wordSet = Set.from(wordList);
  if (!wordSet.contains(endWord)) return 0;

  // 通配模式映射：pattern → [匹配该模式的单词]
  Map<String, List<String>> patternMap = {};
  for (String word in wordSet) {
    for (int i = 0; i < word.length; i++) {
      // 生成通配模式：将第 i 个字符替换为 *
      String pattern = '${word.substring(0, i)}*${word.substring(i + 1)}';
      patternMap.putIfAbsent(pattern, () => []);
      patternMap[pattern]!.add(word);
    }
  }

  // BFS
  List<_WordStep> queue = [_WordStep(beginWord, 1)]; // 队列元素：(单词, 步数)
  Set<String> visited = {beginWord}; // 已访问集合

  while (queue.isNotEmpty) {
    _WordStep current = queue.removeAt(0);

    // 生成当前单词的所有通配模式，查找邻居
    for (int i = 0; i < current.word.length; i++) {
      String pattern =
          '${current.word.substring(0, i)}*${current.word.substring(i + 1)}';

      List<String>? neighbors = patternMap[pattern];
      if (neighbors == null) continue;

      for (String neighbor in neighbors) {
        if (neighbor == endWord) {
          return current.steps + 1; // 找到终点
        }
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(_WordStep(neighbor, current.steps + 1));
        }
      }
    }
  }

  return 0; // 无法到达
}

class _WordStep {
  String word;
  int steps;
  _WordStep(this.word, this.steps);
}
