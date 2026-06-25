import 'package:test/test.dart';
import '../lib/shared.dart';
import '../linked_list_reversal/linked_list_reversal.dart';

void main() {
  group('#206 Reverse Linked List', () {
    test('基本用例', () {
      ListNode head = buildList([1, 2, 3, 4, 5])!;
      expect(listToArray(reverseList(head)), equals([5, 4, 3, 2, 1]));
    });

    test('空链表', () {
      expect(reverseList(null), isNull);
    });

    test('单节点', () {
      expect(listToArray(reverseList(ListNode(1))), equals([1]));
    });
  });

  group('#92 Reverse Linked List II', () {
    test('基本用例', () {
      ListNode head = buildList([1, 2, 3, 4, 5])!;
      expect(listToArray(reverseBetween(head, 2, 4)), equals([1, 4, 3, 2, 5]));
    });

    test('反转整个链表', () {
      ListNode head = buildList([1, 2, 3])!;
      expect(listToArray(reverseBetween(head, 1, 3)), equals([3, 2, 1]));
    });

    test('只反转一个节点', () {
      ListNode head = buildList([1, 2, 3])!;
      expect(listToArray(reverseBetween(head, 2, 2)), equals([1, 2, 3]));
    });
  });

  group('#24 Swap Nodes in Pairs', () {
    test('基本用例', () {
      ListNode head = buildList([1, 2, 3, 4])!;
      expect(listToArray(swapPairs(head)), equals([2, 1, 4, 3]));
    });

    test('奇数个节点', () {
      ListNode head = buildList([1, 2, 3])!;
      expect(listToArray(swapPairs(head)), equals([2, 1, 3]));
    });

    test('单节点', () {
      ListNode head = ListNode(1);
      expect(listToArray(swapPairs(head)), equals([1]));
    });

    test('空链表', () {
      expect(swapPairs(null), isNull);
    });
  });
}
