import 'package:test/test.dart';
import '../lib/shared.dart';
import '../binary_tree_traversal/binary_tree_traversal.dart';

/// 辅助函数：从层序数组构建二叉树
/// 例如 [3,9,20,null,null,15,7]
TreeNode? buildTree(List<int?> values) {
  if (values.isEmpty || values[0] == null) return null;
  TreeNode root = TreeNode(values[0]!);
  List<TreeNode> queue = [root];
  int i = 1;
  while (queue.isNotEmpty && i < values.length) {
    TreeNode node = queue.removeAt(0);
    if (i < values.length) {
      if (values[i] != null) {
        node.left = TreeNode(values[i]!);
        queue.add(node.left!);
      }
      i++;
    }
    if (i < values.length) {
      if (values[i] != null) {
        node.right = TreeNode(values[i]!);
        queue.add(node.right!);
      }
      i++;
    }
  }
  return root;
}

void main() {
  group('#257 Binary Tree Paths', () {
    test('基本用例', () {
      TreeNode? root = buildTree([1, 2, 3, null, 5]);
      expect(
        binaryTreePaths(root)..sort(),
        equals(['1->2->5', '1->3']),
      );
    });

    test('单节点', () {
      expect(binaryTreePaths(TreeNode(1)), equals(['1']));
    });
  });

  group('#230 Kth Smallest Element in a BST', () {
    test('基本用例', () {
      TreeNode? root = buildTree([3, 1, 4, null, 2]);
      expect(kthSmallest(root, 1), equals(1));
      expect(kthSmallest(root, 3), equals(3));
    });

    test('链状BST', () {
      TreeNode? root = buildTree([5, 3, 6, 2, 4, null, null, 1]);
      expect(kthSmallest(root, 3), equals(3));
    });
  });

  group('#124 Binary Tree Maximum Path Sum', () {
    test('基本用例', () {
      TreeNode? root = buildTree([1, 2, 3]);
      expect(maxPathSum(root), equals(6)); // 2+1+3
    });

    test('含负数', () {
      TreeNode? root = buildTree([-10, 9, 20, null, null, 15, 7]);
      expect(maxPathSum(root), equals(42)); // 15+20+7
    });
  });
}
