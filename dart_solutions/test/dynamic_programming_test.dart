import 'package:test/test.dart';
import '../dynamic_programming/dynamic_programming.dart';

void main() {
  group('#70 Climbing Stairs', () {
    test('n=2', () => expect(climbStairs(2), equals(2)));
    test('n=3', () => expect(climbStairs(3), equals(3)));
    test('n=4', () => expect(climbStairs(4), equals(5)));
    test('n=45', () => expect(climbStairs(45), equals(1836311903)));
  });

  group('#198 House Robber', () {
    test('基本用例', () {
      expect(rob([1, 2, 3, 1]), equals(4));
    });
    test('两间房', () {
      expect(rob([2, 7, 9, 3, 1]), equals(12));
    });
    test('单间房', () {
      expect(rob([5]), equals(5));
    });
  });

  group('#322 Coin Change', () {
    test('基本用例', () {
      expect(coinChange([1, 2, 5], 11), equals(3)); // 5+5+1
    });
    test('无法凑成', () {
      expect(coinChange([2], 3), equals(-1));
    });
    test('amount=0', () {
      expect(coinChange([1], 0), equals(0));
    });
  });

  group('#1143 Longest Common Subsequence', () {
    test('基本用例', () {
      expect(longestCommonSubsequence('abcde', 'ace'), equals(3));
    });
    test('无公共子序列', () {
      expect(longestCommonSubsequence('abc', 'def'), equals(0));
    });
    test('完全相等', () {
      expect(longestCommonSubsequence('abc', 'abc'), equals(3));
    });
  });

  group('#300 Longest Increasing Subsequence', () {
    test('基本用例', () {
      expect(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]), equals(4));
    });
    test('全部递增', () {
      expect(lengthOfLIS([0, 1, 0, 3, 2, 3]), equals(4));
    });
    test('单元素', () {
      expect(lengthOfLIS([7]), equals(1));
    });
  });

  group('#416 Partition Equal Subset Sum', () {
    test('基本用例', () {
      expect(canPartition([1, 5, 11, 5]), isTrue);
    });
    test('无法平分', () {
      expect(canPartition([1, 2, 3, 5]), isFalse);
    });
    test('只有两个元素', () {
      expect(canPartition([1, 1]), isTrue);
    });
    test('奇数和', () {
      expect(canPartition([1, 2, 5]), isFalse);
    });
  });
}
