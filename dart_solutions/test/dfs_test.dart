import 'package:test/test.dart';
import '../lib/shared.dart';
import '../dfs/dfs.dart';

void main() {
  group('#133 Clone Graph', () {
    test('双节点图', () {
      GraphNode n1 = GraphNode(1);
      GraphNode n2 = GraphNode(2);
      n1.neighbors.add(n2);
      n2.neighbors.add(n1);
      GraphNode? cloned = cloneGraph(n1);
      expect(cloned!.val, equals(1));
      expect(cloned.neighbors.length, equals(1));
      expect(cloned.neighbors[0].val, equals(2));
    });

    test('单节点图', () {
      GraphNode n1 = GraphNode(1);
      GraphNode? cloned = cloneGraph(n1);
      expect(cloned!.val, equals(1));
      expect(cloned.neighbors, isEmpty);
    });
  });

  group('#113 Path Sum II', () {
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
      TreeNode? root = buildTree([5, 4, 8, 11, null, 13, 4, 7, 2, null, null, 5, 1]);
      var result = pathSum(root, 22);
      expect(result, unorderedEquals([
        [5, 4, 11, 2],
        [5, 8, 4, 5],
      ]));
    });

    test('无路径', () {
      expect(pathSum(buildTree([1, 2, 3]), 5), isEmpty);
    });
  });

  group('#210 Course Schedule II', () {
    test('基本用例', () {
      var order = findOrder(4, [
        [1, 0],
        [2, 0],
        [3, 1],
        [3, 2],
      ]);
      expect(order.length, equals(4));
      // 验证拓扑序：先修课必须出现在后续课之前
      int posOf(int c) => order.indexOf(c);
      expect(posOf(0) < posOf(1), isTrue);
      expect(posOf(0) < posOf(2), isTrue);
      expect(posOf(1) < posOf(3), isTrue);
      expect(posOf(2) < posOf(3), isTrue);
    });

    test('有环', () {
      expect(
        findOrder(2, [
          [0, 1],
          [1, 0],
        ]),
        isEmpty,
      );
    });
  });
}
