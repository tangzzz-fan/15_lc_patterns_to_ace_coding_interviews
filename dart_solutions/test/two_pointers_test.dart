import 'package:test/test.dart';
import '../two_pointers/two_pointers.dart';

void main() {
  group('#167 Two Sum II — Input Array is Sorted', () {
    test('基本用例', () {
      expect(twoSum([2, 7, 11, 15], 9), equals([1, 2]));
    });

    test('首尾配对', () {
      expect(twoSum([2, 3, 4], 6), equals([1, 3]));
    });

    test('负数', () {
      expect(twoSum([-1, 0], -1), equals([1, 2]));
    });
  });

  group('#15 3Sum', () {
    test('基本用例', () {
      expect(threeSum([-1, 0, 1, 2, -1, -4]), unorderedEquals([
        [-1, -1, 2],
        [-1, 0, 1],
      ]));
    });

    test('无解', () {
      expect(threeSum([0, 1, 1]), isEmpty);
    });

    test('全零', () {
      expect(threeSum([0, 0, 0]), equals([
        [0, 0, 0]
      ]));
    });
  });

  group('#11 Container With Most Water', () {
    test('基本用例', () {
      expect(maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]), equals(49));
    });

    test('两根柱子', () {
      expect(maxArea([1, 1]), equals(1));
    });

    test('递增高度', () {
      expect(maxArea([1, 2, 3, 4, 5]), equals(6)); // 最边两根
    });
  });
}
