import 'package:test/test.dart';
import '../top_k_elements/top_k_elements.dart';

void main() {
  group('#215 Kth Largest Element in an Array', () {
    test('基本用例', () {
      expect(findKthLargest([3, 2, 1, 5, 6, 4], 2), equals(5));
    });

    test('k=1', () {
      expect(findKthLargest([3, 2, 1, 5, 6, 4], 1), equals(6));
    });

    test('有重复元素', () {
      expect(findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), equals(4));
    });
  });

  group('#347 Top K Frequent Elements', () {
    test('基本用例', () {
      expect(
        topKFrequent([1, 1, 1, 2, 2, 3], 2),
        unorderedEquals([1, 2]),
      );
    });

    test('单元素', () {
      expect(topKFrequent([1], 1), equals([1]));
    });
  });

  group('#373 Find K Pairs with Smallest Sums', () {
    test('基本用例', () {
      expect(
        kSmallestPairs([1, 7, 11], [2, 4, 6], 3),
        unorderedEquals([
          [1, 2],
          [1, 4],
          [1, 6],
        ]),
      );
    });

    test('k超过总数', () {
      expect(
        kSmallestPairs([1, 1, 2], [1, 2, 3], 10).length,
        equals(9),
      );
    });
  });
}
