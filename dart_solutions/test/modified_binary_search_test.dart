import 'package:test/test.dart';
import '../modified_binary_search/modified_binary_search.dart';

void main() {
  group('#33 Search in Rotated Sorted Array', () {
    test('基本用例', () {
      expect(searchRotated([4, 5, 6, 7, 0, 1, 2], 0), equals(4));
    });

    test('不存在', () {
      expect(searchRotated([4, 5, 6, 7, 0, 1, 2], 3), equals(-1));
    });

    test('单元素', () {
      expect(searchRotated([1], 0), equals(-1));
    });

    test('未旋转', () {
      expect(searchRotated([1, 2, 3, 4, 5], 3), equals(2));
    });
  });

  group('#153 Find Minimum in Rotated Sorted Array', () {
    test('旋转3次', () {
      expect(findMin([3, 4, 5, 1, 2]), equals(1));
    });

    test('未旋转', () {
      expect(findMin([11, 13, 15, 17]), equals(11));
    });

    test('旋转一次', () {
      expect(findMin([2, 3, 4, 5, 1]), equals(1));
    });
  });

  group('#240 Search a 2D Matrix II', () {
    test('找到', () {
      expect(
        searchMatrix([
          [1, 4, 7, 11, 15],
          [2, 5, 8, 12, 19],
          [3, 6, 9, 16, 22],
          [10, 13, 14, 17, 24],
          [18, 21, 23, 26, 30],
        ], 5),
        isTrue,
      );
    });

    test('不存在', () {
      expect(
        searchMatrix([
          [1, 4, 7],
          [2, 5, 8],
          [3, 6, 9],
        ], 20),
        isFalse,
      );
    });
  });
}
