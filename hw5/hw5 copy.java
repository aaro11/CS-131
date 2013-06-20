
import java.util.Iterator;
import java.lang.Iterable;

// an exception for places in the code that you need to implement
class ImplementMe extends RuntimeException {}

// an interface for sets of strings
// ignore the "extends" clause until Problem 5
interface Set /* extends Iterable<String> */ {
	// is string s in the set?
    boolean contains(String s);
	// add an element; no duplicates allowed
    void add(String s);
	// how many elements are in the set?
    int size();

// These operations are used in Problem 4.
    // boolean isEmpty();
    // void addAll(String[] items);

// This operation is used in Problem 5.	
	// return an iterator for the current set
//     Iterator<String> iterator();
}

// PROBLEM 1

class ArraySet implements Set {
	// the array of elements
    protected String[] elems;
	// the number of elements in the set currently
    protected int size;

    ArraySet() {
	elems = new String[5];
	size = 0;
    }
    
    public boolean contains(String s) {
		int a = 0;
		for (a = 0; a < size; a++) {
			if (elems[a].equals(s))
				return true;
		}
		return false;
    }

   public void add(String s) {
	   if (!contains(s)) {
		   if (size >= elems.length) {
			  //double size into a temp variable
			   String[] temp = new String[elems.length * 2];
			   int a = 0;
			   for (; a < elems.length; a++)
				   temp[a] = elems[a];
			   
			   elems = temp;
			   elems[a] = s;
		   } else {
			   elems[size] = s;
		   }
		   size++;
	   }
    }

    public int size() {
		return size;
    }

	// ignore until PROBLEM 5
    class ArrayIterator implements Iterator<String> {
	protected int curr;

	ArrayIterator() { throw new ImplementMe(); }

    	public boolean hasNext() { throw new ImplementMe(); }

    	public String next() { throw new ImplementMe(); }

	    // you don't have to implement this method
	public void remove() { throw new UnsupportedOperationException(); }
    }
}


// PROBLEM 2

// a type for nodes in the linked list
interface ListNode {
    boolean contains(String s);
    ListNode add(String s);
    int size();
}

// a sentinel indicating that we've reached the end of the linked list
class EmptyNode implements ListNode {
    EmptyNode() {}
    
    public boolean contains(String s) {
		return false;
    }

    public ListNode add(String s) {
		ListNode temp;
		temp.value = s;
		temp.next = EmptyNode();
		return temp;
    }

    public int size() {
		return 0;
    }
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
		if (this.value == s)
			return true;
		else 
			return this.next.contains(s);
		/*
		ListNode temp = this;
		while (temp.next != EmptyNode()) {
			if (temp.value = s)
				return true;
			temp = temp.next;
		}
		return false;*/
    }

    public ListNode add(String s) {
		if (!contains(s))
			return this.next.add();
			/*if (this.next != ValueNode)
				return ValueNode(s, EmptyNode());
			else 
				return this.next.add();*/
		/*
		ListNode temp = this;
		if (!contains(s))
		{
			while (temp.next != EmptyNode())
				temp = temp.next;
			temp = ValueNode(s, EmptyNode());
		}*/
    }

    public int size() {
		return 1 + this.next.size();
		/*
		int count = 0;
		ListNode temp = this;
		while (temp.next != EmptyNode())
		{
			count++;
			temp = temp.next;
		}
		return temp;*/
    }
}

class ListSet implements Set {
	// the head of the linked list of nodes
    protected ListNode head;

    ListSet() {
		;
	}
    
    public boolean contains(String s) {
		return head.contains(s);
    }

	public void add(String s) {
		head = head.add(s);
    }

    public int size() {
		return head.size();
    }
    
    	// ignore until PROBLEM 5
    class ListIterator implements Iterator<String> {
	protected ListNode curr;

	ListIterator() { throw new ImplementMe(); }

    	public boolean hasNext() { throw new ImplementMe(); }

    	public String next() { throw new ImplementMe(); }
	
	    // you don't have to implement this method
	public void remove() { throw new UnsupportedOperationException(); }
    }
}



// PROBLEM 3

class SortedListSet extends ListSet {
	//
}

// PROBLEM 4

abstract class AbstractSet implements Set {
    public boolean isEmpty() {
		if (size() == 0)
			return true;
		else 
			return false;
    }
    
    public void addAll(String[] items) {
		String result = "";
		for (String i : items)
			result += i;
		return result;
    }
}


// PROBLEM 6

class Client {
    boolean subsetOf(Set s1, Set s2) {
	throw new ImplementMe();
    }
}


class Test {
    public static void main(String[] args) {
	    // sample tests for Problem 1
	System.out.println("TESTING PROBLEM 1...");
	Set s1 = new ArraySet();
	s1.add("hello");
	s1.add("hi");	
	s1.add("hello");
	System.out.println("test 1: " + (s1.contains("hi") == true));
	System.out.println("test 2: " + (s1.contains("bye") == false));
	System.out.println("test 3: " + (s1.size() == 2));
    }
}

