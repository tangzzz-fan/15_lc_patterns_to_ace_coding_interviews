import 'package:test/test.dart';
import '../matrix_traversal/matrix_traversal.dart';

void main() {
  group('#733 Flood Fill', () {
    test('基本用例', () {
      var image = [
        [1, 1, 1],
        [1, 1, 0],
        [1, 0, 1],
      ];
      expect(
        floodFill(image, 1, 1, 2),
        equals([
          [2, 2, 2],
          [2, 2, 0],
          [2, 0, 1],
        ]),
      );
    });

    test('起始颜色等于目标颜色', () {
      var image = [
        [0, 0, 0],
        [0, 0, 0],
      ];
      expect(
        floodFill(image, 0, 0, 0),
        equals([
          [0, 0, 0],
          [0, 0, 0],
        ]),
      );
    });
  });

  group('#200 Number of Islands', () {
    test('基本用例', () {
      expect(
        numIslands([
          ['1', '1', '1', '1', '0'],
          ['1', '1', '0', '1', '0'],
          ['1', '1', '0', '0', '0'],
          ['0', '0', '0', '0', '0'],
        ]),
        equals(1),
      );
    });

    test('三个岛屿', () {
      expect(
        numIslands([
          ['1', '1', '0', '0', '0'],
          ['1', '1', '0', '0', '0'],
          ['0', '0', '1', '0', '0'],
          ['0', '0', '0', '1', '1'],
        ]),
        equals(3),
      );
    });
  });

  group('#130 Surrounded Regions', () {
    test('基本用例', () {
      var board = [
        ['X', 'X', 'X', 'X'],
        ['X', 'O', 'O', 'X'],
        ['X', 'X', 'O', 'X'],
        ['X', 'O', 'X', 'X'],
      ];
      solve(board);
      expect(
        board,
        equals([
          ['X', 'X', 'X', 'X'],
          ['X', 'X', 'X', 'X'],
          ['X', 'X', 'X', 'X'],
          ['X', 'O', 'X', 'X'],
        ]),
      );
    });
  });
}
