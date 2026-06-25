import 'package:test/test.dart';
import '../monotonic_stack/monotonic_stack.dart';

void main() {
  group('#496 Next Greater Element I', () {
    test('基本用例', () {
      expect(
        nextGreaterElement([4, 1, 2], [1, 3, 4, 2]),
        equals([-1, 3, -1]),
      );
    });

    test('全部递增', () {
      expect(
        nextGreaterElement([2, 4], [1, 2, 3, 4]),
        equals([3, -1]),
      );
    });

    test('没有更大元素', () {
      expect(
        nextGreaterElement([5, 4, 3], [5, 4, 3, 2, 1]),
        equals([-1, -1, -1]),
      );
    });
  });

  group('#739 Daily Temperatures', () {
    test('基本用例', () {
      expect(
        dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]),
        equals([1, 1, 4, 2, 1, 1, 0, 0]),
      );
    });

    test('一直升温', () {
      expect(dailyTemperatures([30, 40, 50, 60]), equals([1, 1, 1, 0]));
    });

    test('一直降温', () {
      expect(dailyTemperatures([30, 20, 10]), equals([0, 0, 0]));
    });
  });

  group('#84 Largest Rectangle in Histogram', () {
    test('基本用例', () {
      expect(largestRectangleArea([2, 1, 5, 6, 2, 3]), equals(10));
    });

    test('递增', () {
      expect(largestRectangleArea([1, 2, 3, 4, 5]), equals(9));
    });

    test('单柱', () {
      expect(largestRectangleArea([5]), equals(5));
    });
  });
}
