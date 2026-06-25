import 'package:test/test.dart';
import '../lib/shared.dart';
import '../bfs/bfs.dart';

void main() {
  group('#102 Binary Tree Level Order Traversal', () {
    TreeNode? buildTree(List<int?> vals) {
      if (vals.isEmpty || vals[0] == null) return null;
      TreeNode root = TreeNode(vals[0]!);
      List<TreeNode> q = [root];
      int i = 1;
      while (q.isNotEmpty && i < vals.length) {
        TreeNode n = q.removeAt(0);
        if (i < vals.length) {
          if (vals[i] != null) { n.left = TreeNode(vals[i]!); q.add(n.left!); }
          i++;
        }
        if (i < vals.length) {
          if (vals[i] != null) { n.right = TreeNode(vals[i]!); q.add(n.right!); }
          i++;
        }
      }
      return root;
    }

    test('基本用例', () {
      TreeNode? root = buildTree([3, 9, 20, null, null, 15, 7]);
      expect(
        levelOrder(root),
        equals([
          [3],
          [9, 20],
          [15, 7],
        ]),
      );
    });

    test('空树', () {
      expect(levelOrder(null), isEmpty);
    });
  });

  group('#994 Rotting Oranges', () {
    test('基本用例', () {
      expect(
        orangesRotting([
          [2, 1, 1],
          [1, 1, 0],
          [0, 1, 1],
        ]),
        equals(4),
      );
    });

    test('无法全部腐烂', () {
      expect(
        orangesRotting([
          [2, 1, 1],
          [0, 1, 1],
          [1, 0, 1],
        ]),
        equals(-1),
      );
    });

    test('无新鲜橘子', () {
      expect(
        orangesRotting([
          [2, 0],
          [0, 2],
        ]),
        equals(0),
      );
    });
  });

  group('#127 Word Ladder', () {
    test('基本用例', () {
      expect(
        ladderLength('hit', 'cog', ['hot', 'dot', 'dog', 'lot', 'log', 'cog']),
        equals(5),
      );
    });

    test('不可达', () {
      expect(
        ladderLength('hit', 'cog', ['hot', 'dot', 'dog', 'lot', 'log']),
        equals(0),
      );
    });
  });
}
