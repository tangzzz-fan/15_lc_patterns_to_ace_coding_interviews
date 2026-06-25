import 'package:test/test.dart';
import '../sliding_window/sliding_window.dart';

void main() {
  group('#643 Maximum Average Subarray I', () {
    test('基本用例', () {
      expect(findMaxAverage([1, 12, -5, -6, 50, 3], 4), closeTo(12.75, 0.00001));
    });

    test('k=1', () {
      expect(findMaxAverage([5], 1), equals(5.0));
    });

    test('全负数', () {
      expect(findMaxAverage([-1, -2, -3], 2), closeTo(-1.5, 0.00001));
    });
  });

  group('#3 Longest Substring Without Repeating Characters', () {
    test('基本用例', () {
      expect(lengthOfLongestSubstring('abcabcbb'), equals(3));
    });

    test('全相同', () {
      expect(lengthOfLongestSubstring('bbbbb'), equals(1));
    });

    test('空字符串', () {
      expect(lengthOfLongestSubstring(''), equals(0));
    });

    test('无重复', () {
      expect(lengthOfLongestSubstring('abcdef'), equals(6));
    });
  });

  group('#76 Minimum Window Substring', () {
    test('基本用例', () {
      expect(minWindow('ADOBECODEBANC', 'ABC'), equals('BANC'));
    });

    test('单字符匹配', () {
      expect(minWindow('a', 'a'), equals('a'));
    });

    test('无匹配', () {
      expect(minWindow('a', 'aa'), equals(''));
    });
  });
}
