import 'package:test/test.dart';
import '../prefix_sum/prefix_sum.dart';

void main() {
  group('#303 Range Sum Query — Immutable', () {
    test('基本用例', () {
      final na = NumArray([-2, 0, 3, -5, 2, -1]);
      expect(na.sumRange(0, 2), equals(1));   // -2 + 0 + 3
      expect(na.sumRange(2, 5), equals(-1));  // 3 - 5 + 2 - 1
      expect(na.sumRange(0, 5), equals(-3));  // -2 + 0 + 3 - 5 + 2 - 1
    });

    test('单元素数组', () {
      final na = NumArray([42]);
      expect(na.sumRange(0, 0), equals(42));
    });
  });

  group('#525 Contiguous Array', () {
    test('基本用例', () {
      expect(findMaxLength([0, 1]), equals(2));
      expect(findMaxLength([0, 1, 0]), equals(2));
    });

    test('相同数量的0和1', () {
      expect(findMaxLength([0, 0, 1, 0, 0, 0, 1, 1]), equals(6));
    });

    test('全0', () {
      expect(findMaxLength([0, 0, 0]), equals(0));
    });

    test('全1', () {
      expect(findMaxLength([1, 1, 1, 1]), equals(0));
    });
  });

  group('#560 Subarray Sum Equals K', () {
    test('基本用例', () {
      expect(subarraySum([1, 1, 1], 2), equals(2));
    });

    test('有正有负', () {
      expect(subarraySum([1, 2, 3], 3), equals(2)); // [1,2], [3]
    });

    test('不含k', () {
      expect(subarraySum([1, 2, 3], 7), equals(0));
    });

    test('单个元素等于k', () {
      expect(subarraySum([1, -1, 0], 0), equals(3)); // [1,-1], [0], [1,-1,0]
    });
  });
}
