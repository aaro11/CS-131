
class ListSet {

    ListNode head;

}

/* type listnode = EmptyNode | ValueNode of string * listnode 

   let size l =
     match l with
        EmptyNode -> 0
      | ValueNode(s, n) -> 1 + (size n)

  easy to add new operations without touching existing code:

  let concatAll l =
    match l with
       EmptyNode -> ""
     | ValueNode(s,n) -> s ^ (concatAll n)

  difficult to add a new kind of node     
     
 */

interface ListNode {
    int size();
}

class EmptyNode implements ListNode {
    public int size() { return 0; }
}

class ValueNode implements ListNode {
    String value;
    ListNode next;
    
    public int size() { return 1 + next.size(); }
}

/* adding new kinds of nodes is easy */

class TwoValueNode implements ListNode {

	// ...

}