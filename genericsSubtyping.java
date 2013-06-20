import java.util.*;

/*
 * List<S> is only a subtype of List<T> if S=T 
 * 
 * Still the case that ArrayList<String> is a subtype of List<String>
 * q
 */

class Main {
	void m(List<Object> lst) {
		lst.add(new Integer(3));
	}
	
	<E> void printAll(List<E> lst) {
		for (E o : lst)
			System.out.println(o.toString());
		
		//cant add an integer to the list because youd ont know the type
		// lst.add(new Integer(3));
	}
	
	// equivalent to the above, but uses WILDCARD type
	void printAllSimpler(List<?> lst) {
		for (Object o : lst)
			System.out.println(o.toString());
	}

	public static void main(String[] args) {
		Main mn = new Main();
		
		List<String> l = new ArrayList<String>();
		l.add("hello");
		l.add("bye");
		// Because you cant do things to all Objects to Strings
		// You CANT do this:
		//	mn.m(l);
		mn.printAll(l);
	}
}