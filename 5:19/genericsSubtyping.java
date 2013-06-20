
import java.util.*;

/* List<S> is only a subtype of List<T> if S=T

   Still the case that ArrayList<String> is a subtype of List<String>

 */

class Main {
    void m(List<Object> lst) {
	lst.add(new Integer(3));
    }

    <E> void printAll(List<E> lst) {
	for(E o : lst)
	    System.out.println(o.toString());
    }

	// equivalent to the above, but uses a wildcard type ?
    void printAllSimpler(List<?> lst) {
	for(Object o : lst)
	    System.out.println(o.toString());
    }

    public static void main(String[] args) {

	Main main = new Main();

	List<String> l = new ArrayList<String>();
	l.add("hello");
	l.add("bye");
	main.printAll(l);
    }
    
}