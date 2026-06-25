import 'package:test/test.dart';
import '../backtracking/backtracking.dart';

void main() {
  group('#46 Permutations', () {
    test('基本用例', () {
      var result = permute([1, 2, 3]);
      expect(result.length, equals(6));
      expect(result, containsAll([
        [1, 2, 3],
        [1, 3, 2],
        [2, 1, 3],
        [2, 3, 1],
        [3, 1, 2],
        [3, 2, 1],
      ]));
    });

    test('单元素', () {
      expect(permute([0]), equals([
        [0]
      ]));
    });
  });

  group('#78 Subsets', () {
    test('基本用例', () {
      var result = subsets([1, 2, 3]);
      expect(result.length, equals(8));
      expect(result, containsAll([
        [],
        [1],
        [2],
        [3],
        [1, 2],
        [1, 3],
        [2, 3],
        [1, 2, 3],
      ]));
    });

    test('空数组', () {
      expect(subsets([]), equals([
        []
      ]));
    });
  });

  group('#51 N-Queens', () {
    test('n=4', () {
      var result = solveNQueens(4);
      expect(result.length, equals(2));
      expect(
        result,
        unorderedEquals([
          ['.Q..', '...Q', 'Q...', '..Q.'],
          ['..Q.', 'Q...', '...Q', '.Q..'],
        ]),
      );
    });

    test('n=1', () {
      expect(solveNQueens(1), equals([
        ['Q']
      ]));
    });
  });
}
