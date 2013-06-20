
import java.util.Iterator;
import java.lang.Iterable;

// an exception for places in the code that you need to implement
class ImplementMe extends RuntimeException {}

// an interface for sets of strings
interface Set {
	// is string s in the set?
    boolean contains(String s);
	// add an element; no duplicates allowed
    void add(String s);
	// how many elements are in the set?
    int size();
}

// a type for nodes in the linked list
interface ListNode {
    boolean contains(String s);
    ListNode add(String s);
    int size();
}

// a sentinel indicating that we've reached the end of the linked list
class EmptyNode implements ListNode {
    ListSet set;
    
    EmptyNode(ListSet s) { this.set = s; }
    
    public boolean contains(String s) {
	return false;
    }

    public ListNode add(String s) {
	return set.valuenode(s, this);
    }

    public int size() {
	return 0;
    }

    public String value() { return null; }
    public ListNode next() { return null; }
}

class ValueNode implements ListNode {    
	// the element stored in this node
    protected String value;
	// a pointer to the next node in the list
    protected ListNode next;

    ValueNode(String value, ListNode next) {
	this.value = value;
	this.next = next;
    }

    public boolean contains(String s) {
	return s.equals(value) || next.contains(s);
    }

    public ListNode add(String s) {
	next = next.add(s);
	return this;
    }

    public int size() {
	return 1 + next.size();
    }
    
    public String value() { return value; }
    public ListNode next() { return next; }
}

class ListSet implements Set {
	// the head of the linked list of nodes
    protected ListNode head;

    ListSet() { head = this.emptynode(); }


	// factory methods
    public ListNode emptynode() { return new EmptyNode(this); }
    public ListNode valuenode(String s, ListNode n) {
	return new ValueNode(s, n);
    }
    
    public boolean contains(String s) {
	return head.contains(s);
    }

   public void add(String s) {
       if(contains(s))
	   return;
       head = head.add(s);
    }

    public int size() {
	return head.size();
    }
}

class SortedValueNode extends ValueNode {
    SortedValueNode(String s, ListNode n) {
	super(s,n);
    }
}

class SortedListSet extends ListSet {

	// no need to create a new kind of empty node now!
    
    public ListNode valuenode(String s, ListNode n) {
	return new SortedValueNode(s, n);
    }

    SortedListSet() { super(); }
}

class Test {
    public static void main(String[] args) {
	Set s1 = new ListSet();
	s1.add("hello");
	s1.add("hi");	
	s1.add("hello");
	System.out.println("test 1: " + (s1.contains("hi") == true));
	System.out.println("test 2: " + (s1.contains("bye") == false));
	System.out.println("test 3: " + (s1.size() == 2));

    }
}

