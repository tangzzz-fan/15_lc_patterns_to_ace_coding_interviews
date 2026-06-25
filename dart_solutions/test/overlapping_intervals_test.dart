import 'package:test/test.dart';
import '../overlapping_intervals/overlapping_intervals.dart';

void main() {
  group('#56 Merge Intervals', () {
    test('基本用例', () {
      expect(
        merge([
          [1, 3],
          [2, 6],
          [8, 10],
          [15, 18],
        ]),
        equals([
          [1, 6],
          [8, 10],
          [15, 18],
        ]),
      );
    });

    test('完全包含', () {
      expect(
        merge([
          [1, 4],
          [2, 3],
        ]),
        equals([
          [1, 4]
        ]),
      );
    });

    test('空数组', () {
      expect(merge([]), isEmpty);
    });
  });

  group('#57 Insert Interval', () {
    test('基本用例', () {
      expect(
        insert(
          [
            [1, 3],
            [6, 9],
          ],
          [2, 5],
        ),
        equals([
          [1, 5],
          [6, 9],
        ]),
      );
    });

    test('插入到头部', () {
      expect(
        insert(
          [
            [4, 5],
            [6, 9],
          ],
          [1, 3],
        ),
        equals([
          [1, 3],
          [4, 5],
          [6, 9],
        ]),
      );
    });

    test('与多个区间重叠', () {
      expect(
        insert(
          [
            [1, 2],
            [3, 5],
            [6, 7],
            [8, 10],
            [12, 16],
          ],
          [4, 8],
        ),
        equals([
          [1, 2],
          [3, 10],
          [12, 16],
        ]),
      );
    });
  });

  group('#435 Non-Overlapping Intervals', () {
    test('基本用例', () {
      expect(
        eraseOverlapIntervals([
          [1, 2],
          [2, 3],
          [3, 4],
          [1, 3],
        ]),
        equals(1),
      );
    });

    test('完全重叠', () {
      expect(
        eraseOverlapIntervals([
          [1, 2],
          [1, 2],
          [1, 2],
        ]),
        equals(2),
      );
    });

    test('无重叠', () {
      expect(
        eraseOverlapIntervals([
          [1, 2],
          [3, 5],
          [6, 8],
        ]),
        equals(0),
      );
    });
  });
}
