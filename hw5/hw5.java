/*
 * Name: Jonathan Nguy
 * UID: 603 799 761
 * 
 * Collaborators: 
 * Harvey Abaya
 * 
 * Homework 5
 */

import java.util.Iterator;
import java.lang.Iterable;


import java.util.NoSuchElementException;

// an exception for places in the code that you need to implement
class ImplementMe extends RuntimeException {}

// an interface for sets of strings
// ignore the "extends" clause until Problem 5
interface Set extends Iterable<String> {
	// is string s in the set?
    boolean contains(String s);
	// add an element; no duplicates allowed
    void add(String s);
	// how many elements are in the set?
    int size();
	
	// These operations are used in Problem 4.
    boolean isEmpty();
    void addAll(String[] items);
	
	// This operation is used in Problem 5.	
	// return an iterator for the current set
	Iterator<String> iterator();
}

// PROBLEM 1

class ArraySet extends AbstractSet implements Set {
	// the array of elements
    protected String[] elems;
	// the number of elements in the set currently
    protected int size;
	
    ArraySet() {
		elems = new String[5];
		size = 0;
    }
    
    public boolean contains(String s) {
		for (int a = 0; a < size; a++) 
			if (elems[a].equals(s))
				return true;
		return false;
    }
	
	public void add(String s) {
		if (!contains(s)) {
			if (size >= elems.length) {
				//double size into a temp variable
				String[] temp = new String[elems.length * 2];
				
				// copy all the elems into temp
				int a = 0;
				for (; a < elems.length; a++)
					temp[a] = elems[a];
				
				// swap elems to temp and add s
				elems = temp;
				elems[a] = s;
			} else {
				elems[size] = s;
			}
			size++;
		}
    }
	
	// return the size
    public int size() { return size; }
	
	// ignore until PROBLEM 5	
    class ArrayIterator implements Iterator<String> {
        // counter for location
		protected int curr;
		
		ArrayIterator() { curr = 0; }
		
        // check the sizes
    	public boolean hasNext() {
			return (curr < size);
		}
		
        // return the element and increment curr
    	public String next() { return elems[curr++]; }
		
	    // you don't have to implement this method
		public void remove() { throw new UnsupportedOperationException(); }
    }
	
	public Iterator<String> iterator() { return new ArrayIterator(); }
}


// PROBLEM 2

// a type for nodes in the linked list
interface ListNode {
    boolean contains(String s);
    ListNode add(String s);
    int size();
	
	//for problem 5
	ListNode next();
	String val();
}

// a sentinel indicating that we've reached the end of the linked list
class EmptyNode implements ListNode {
    EmptyNode() {}
    
    // an empty node cannot contain anything
    public boolean contains(String s) { return false; }
	
	// once it hits the end, add the new value
    public ListNode add(String s) {
		return new ValueNode (s, this);
    }
	
    // size of empty node is 0
    public int size() { return 0; }
	
	//for problem 5 ... return null
	public ListNode next() { return null; }
	public String val() { return null; }
}

class ValueNode implements ListNode {    
	// the element stored in this node
    protected String value;
	// a pointer to the next node in the list
    protected ListNode next;
    
    //for problem 3
	ValueNode () {}
	
    ValueNode(String value, ListNode next) {
		this.value = value; 
		this.next = next;
    }
	
	// recursively go through the value nodes
	public boolean contains(String s) {
		if (value.equals(s))
			return true;
		else 
			return next.contains(s);
    }
	
    public ListNode add(String s) {
		if (!value.equals(s))
			next = next.add(s);
		return this;
    }
	
	//recursively go through the list and add 1 for every ValueNode
    public int size() { return 1 + next.size(); }
	
	
	//for problem 5 ... accessor methods
	public ListNode next() { return next; }
	public String val() { return value; }
}

class ListSet extends AbstractSet implements Set {
	// the head of the linked list of nodes
    protected ListNode head;
	
    // the head starts as an EmptyNode
    ListSet() { head = new EmptyNode(); }
    
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
		
		ListIterator() { curr = head; }
		
        //if the current size is > 0, it has a next.
    	public boolean hasNext() {
			return (curr.size() > 0);
		}
		
    	public String next() {
			String temp = curr.val();
			curr = curr.next();
			return temp;
		}
		
	    // you don't have to implement this method
		public void remove() { throw new UnsupportedOperationException(); }
    }
	
	public Iterator<String> iterator() {
		return new ListIterator();
	}
}



// PROBLEM 3

class SortedListSet extends ListSet {	
    
	// we need a SortedEmptyNode
	SortedListSet () { head = new SortedEmptyNode(); }
}

class SortedEmptyNode extends EmptyNode {
	SortedEmptyNode() {}
	
	public ListNode add (String s){
		return new SortedValueNode (s, this);
	}
}

class SortedValueNode extends ValueNode {
	
	SortedValueNode(String value, ListNode next) {
		super(value,next);
	}
	
    // just go through the nodes to check if it contains
    // if "s" is alphabetically lower than the next node, it doesn't contain it
	public boolean contains(String s){
		if (s.equals(value))
			return true;
		else if (s.compareTo(next.val()) < 0)
			return false;
        // continue to next to see if it contains
		return next.contains(s);
	}
	
    // compare the values, if it is alphabetically lower,
    // move the current information to a new node and swap the values of the current
	public ListNode add (String s){
		if (s.compareTo(value) < 0){
			if(!s.equals(value)){
				ListNode temp = new SortedValueNode (value, next);
				value = s;
				next = temp;
			}
		} else
			next = next.add(s);
		return this;
	}
}

// PROBLEM 4

abstract class AbstractSet implements Set {
    // if the size is 0, it is empty
    public boolean isEmpty() {
		if (size() == 0)
			return true;
		return false;
    }
    
    // just use the add function to all the strings of the array
    public void addAll(String[] items) {
		for (String i : items)
			this.add(i);
    }
}


// PROBLEM 6

class Client {
    //go through the first set and if it's not contained in the second,
    // return false... if it goes through the for loop, it is a subset
    boolean subsetOf(Set s1, Set s2) {
		for (String str : s1)
			if (!s2.contains(str))
				return false;
		return true;
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
		s1.add("1");
		s1.add("1");
		s1.add("2");
		System.out.println("test 1: " + (s1.contains("hi") == true));
		System.out.println("test 2: " + (s1.contains("bye") == false));
		System.out.println("test 3: " + (s1.size() == 4));
		
		// sample tests for Problem 1
		System.out.println("TESTING PROBLEM 2...");
		Set s2 = new ListSet();
		s2.add("hello");
		s2.add("hi");	
		s2.add("hello");
		s2.add("1");
		s2.add("1");
		s2.add("2");
		System.out.println("size: " + s2.size());
		System.out.println("test 1: " + (s2.contains("hi") == true));
		System.out.println("test 2: " + (s2.contains("bye") == false));
		System.out.println("test 3: " + (s2.size() == 4));
		System.out.println("test 4: " + (s2.contains("hello") == true));
		
		
		System.out.println("TESTING ARRAY ITERATOR");
		Set s = new ArraySet();
		s.add("hi");
		s.add("bye");
		s.add("hello");
		s.add("goodbye");
		for(String str : s) {
			System.out.println(str);
		}
		
		System.out.println("TESTING LIST ITERATOR");
		Set sa = new ListSet();
		sa.add("hi");
		sa.add("bye");
		sa.add("hello");
		sa.add("goodbye");
		for(String str : sa) {
			System.out.println(str);
		}
		
		// test cases for Problem 3
		System.out.println("TESTING FOR PROBLEM 3");
		Set s3 = new SortedListSet();
		s3.add("hi");
		s3.add("bye");
		s3.add("hello");
		s3.add("goodbye");
		s3.add("try");
		s3.add("one");
		s3.add("two");
		s3.add("three");
		s3.add("five");
		//iterate through the set
		//for(String str : s3) { System.out.println(str); }
		System.out.println("size: " + s3.size());
		System.out.println("test 1: " + (s3.contains("hi") == true));
		System.out.println("test 2: " + (s3.contains("three") == false));
		System.out.println("test 3: " + (s3.size() == 9));
		System.out.println("test 4: " + (s3.contains("hello") == true));
		
		
		// sample tests for Problem 6
		String[] a = {"test"};
		String[] b = {"test","test1","test3"};
		String[] c = {"test","test1","test2"};
		Set s4 = new ArraySet();
		Set s5 = new ArraySet();
		Set s6 = new ArraySet();
		s4.addAll(a);
		s5.addAll(b);
		s6.addAll(c);
		
		
		Client d = new Client();
		System.out.println("Client TEST");
		System.out.println("test 1 " + (d.subsetOf(s5,s6) == false));
		System.out.println("test 2 " + (d.subsetOf(s5,s5) == true));
		System.out.println("test 3 "+ (d.subsetOf(s6,s5)==false));
		System.out.println("test 4 "+ (d.subsetOf(s6,s4)==false));
		
    }
}

