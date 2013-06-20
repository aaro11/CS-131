
// visitor pattern: adding new operations to existing types

// represent a new operation on Nodes that returns a String
interface Visitor {
    String visitEmptyNode(EmptyNode n);
    String visitValueNode(ValueNode n);
}

class ConcatAll implements Visitor {

    public String visitEmptyNode(EmptyNode n) {
	return "";
    }
    
    public String visitValueNode(ValueNode n) {
	return n.value + n.next.accept(this);
    }
}

/* ListNode n = ...;
   n.accept(new ConcatAll());
*/

interface Node {
    int size();

    String accept(Visitor v);

	/* generic version:
	  <A,R> R accept(Visitor v, A a);
	*/
}

class EmptyNode implements Node {
    public int size() { return 0; }

    public String accept(Visitor v) {
	return v.visitEmptyNode(this);
    }
}

class ValueNode implements Node {
    String value;
    Node next;

    ValueNode(String v, Node n) { value = v; next = n; }
    
    public int size() { return 1 + next.size(); }

    public String accept(Visitor v) {
	return v.visitValueNode(this);
    }

}

