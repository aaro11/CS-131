/* Tuesday Week 8. 5/17/11
 * 
 */

/* In ML:
 * type listnode = EmptyNode | Value of string * listnode 
 * 
 * let size l =
 * 	match l with
 * 		EmptyNode -> 0
 * 		| ValueNode(s, n) -> 1 + size(n)
 * 
 * easy to add new operations without touching existing code:
 * 
 * let concatAll l =
 * 	match l with
 * 		EmptyNode -> ""
 * 		| ValueNode (s,n) -> s ^ (concatAll n)
 * 
 * difficult to add a new kind of node
 */
/*
 class ListSet {
 ListNode head;
 }
 
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
 
 // Adding new nodes is easy 
 class TwoValueNode implements ListNode {
 // ... 
 public int size() { return 0; }
 }
 
 */

// FACTORIES
//  allow to avoid duplicated code


// visitor pattern: adding new operations to existing types

//represents a new operation on Nodes that return a String
interface Visitor {
	String visitEmptyNode(EmptyNode n);
	String visitValueNode(ValueNode n);
	
}

interface Node {
	int size();
	
	String accept (Visitor v);
	/* Generic version:
	 * <A,R> R accept(Visitor v, A a);
	 * 
	 */
	
	String value();
	
}
class ConcatAll implements Visitor {
	public String visitEmptyNode(EmptyNode n) {
		return "";
	}
	public String visitValueNode(ValueNode n) {
		return n.value() + n.next.accept(this);
	}
}

class EmptyNode implements Node {
	public int size() { return 0; }
	
	public String accept (Visitor v){
		return v.visitEmptyNode(this);
	}
	
	public String value(){
		return null;
	}
}

class ValueNode implements Node {
	String value;
	Node next;
	
	ValueNode (String v, Node n) { value = v; next = n; }
	
	public int size() { return 1 + next.size();	}
	
	public String accept (Visitor v) {
		return v.visitValueNode(this);
	}
	
	public String value(){
		return value;
	}
}


/* ListNode n = ;
 * n.accept(new ConcatAll());
 * 
 */













