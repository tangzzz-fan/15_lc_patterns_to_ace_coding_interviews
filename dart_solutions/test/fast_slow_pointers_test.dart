import 'package:test/test.dart';
import '../lib/shared.dart';
import '../fast_slow_pointers/fast_slow_pointers.dart';

void main() {
  group('#141 Linked List Cycle', () {
    test('有环', () {
      ListNode head = ListNode(3);
      head.next = ListNode(2);
      head.next!.next = ListNode(0);
      head.next!.next!.next = ListNode(-4);
      createCycle(head, 1); // tail → node[1] (val=2)
      expect(hasCycle(head), isTrue);
    });

    test('无环', () {
      ListNode head = ListNode(1);
      head.next = ListNode(2);
      expect(hasCycle(head), isFalse);
    });

    test('单节点无环', () {
      expect(hasCycle(ListNode(1)), isFalse);
    });

    test('空链表', () {
      expect(hasCycle(null), isFalse);
    });
  });

  group('#202 Happy Number', () {
    test('是快乐数', () {
      expect(isHappy(19), isTrue); // 1²+9²=82→68→100→1
    });

    test('不是快乐数', () {
      expect(isHappy(2), isFalse); // 2→4→16→37→58→89→145→42→20→4 循环
    });

    test('n=1', () {
      expect(isHappy(1), isTrue);
    });
  });

  group('#287 Find the Duplicate Number', () {
    test('基本用例', () {
      expect(findDuplicate([1, 3, 4, 2, 2]), equals(2));
    });

    test('重复数在开头', () {
      expect(findDuplicate([3, 1, 3, 4, 2]), equals(3));
    });

    test('两个数的数组', () {
      expect(findDuplicate([1, 1]), equals(1));
    });
  });
}
