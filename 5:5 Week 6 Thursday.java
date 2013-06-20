/*
Notes on Java
-> what are classes
-> different interfaces
 
 
If a class doesn't extend a class, it automatically
 extends the object class
 
 Key words:
 extends -> only can extend 1 class
 implements -> for interfaces
*/

interface StringSet {
	boolean isEmpty();
	void add(String s);
	boolean contains(String s);
	String get();
}

//interfaces dont have constructors or arguments
/*
	StringSet s = new ArraySet();
	if(s.isEmpty()) {
		s.add("hello");
	}
 
*/

class ArraySet implements StringSet {
	protected String[] elems;
	protected int size;
	
	// ...
	public boolean isEmpty() { return size == 0 }
}

// generics, or parametric polymorphism
// 'E' is like ''a'... it's the element type
interface Set<E> {
	boolean isEmpty();
	void add(E s);
	boolean contains(E s);
	E get();
}

/* a client can use it by:

	Set<string> s1 = ...;
	s1.add("hello");
	
	Set<Shape> s2 = ...;
	s2.add(new Circle());
*/

// SUBTYPE POLYMORPHISM
// it supports all of StringSet's operations and the new ones
// key word: "extends"
interface RemoveableStringSet extends StringSet {
	void remove (String s);
}

class RemoveableArraySet extends ArraySet
	implements RemoveableStringSet{
	// inheriting all the operations from ArraySet
		public void remove(String s) { ... }
}

/* subtype polymorphism: if T1 is a subtype of T2, then 
	values of type T1 can be used wherever values of type T2 are
	expected */

void union (StringSet s1, StringSet e2) { ... }

RemoveableStringSet rs = ...;

union(rs, new ArraySet());

RemovableStringSet rs = ...;
StringSet s = rs; // variables are treated as pointers -> 
				// s points to same memory as r
rs.add ("hello"); // both s and rs gets updated
rs.remove ("hello");
s.remove ("hello"); //compile-time type error

interface ObjectSet {
	boolean isEmpty();
	void add (Object s);
	boolean contains (Object s);
	Object get();
}

ObjectSet s = ...;
s.add("hello"); // typechecks because String is a subtype of Object
Object o = s.get();
// lose the information that this is a set of strings

/* Object is the top of the class hierarchy, implicitly 
 
class Object {
	String toString();
	boolean equals(Object equals);
}
 
 */

/* Don't confuse subtyping with inheritance 
 
 Subtyping is an "interface-level" property about behavioral/semantic compatibility:
 - S is a subtype of T if I can use an S wherever a T is expected
	ie. if someone is passing a String type to an Object
 
 Inheritance is an "implementation-level" property that allows for code reuse
 - if C inherits from D, then C is reusing some of the methods and fields of D
 - just a convenience: I could just copy the methods/fields of D into C manually
 */

/* Cases where you might want one instead of the other: */

/* **Subtyping without inheritance:**
   You might want to consider a Square to be a subtype of Rectangle
    - allows squares to be passed wherever Rectangles are expected

	interface Rect {
	}
 
    class Rectangle implement Rect {
		int length;
		int width;
		...
    }
	
	class Square implement Rect {
		int side;
		...
	}
 */
 
/* **Inheritance without subtyping** 
	
	//We DON'T want:
	//bad idea because we're making Set is a subtype of Bag
	// we don't want this because Sets have different symantics
 
	class Bag {
		Object[] elems;
		...
	}
	
	class Set extends Bag {
		...
	}
 
	//We want:
	abstract class Collection {
		Object[] elems;
		... // shared methods
	}
	class Bag extends Collection {
		...
	}
	class Set extends Collection {
		...
	}
 
	// abstract classes are for chunks of code to share
	// interfaces are only for the types
 */
 
/* Java does: dynamic dispatch 
 
 class C {
	void n() { m(); } //shorthand for this.m();
	void m() {}
 }

 class D extends C {
	void m() {}
 }
 
 //client:
 D d = new D();
 C c = d;
 d.m(); // invokes D's m() method
 c.m(); // invokes D's m() method 
 // lookups at run-time always
 
 d.n(); // invokes D's m() method
 c.n(); // invokes D's m() method
 
 abstract class C {
	void n() { this.m(); }
	abstract void m();
 }
 
 void myMethod(C c) {
	c.n();
 }
 
 // want to depend only on using a List, instead specifically an ArrayList
 // don't make it to exclusive
 class MyClass {
	private List lst = new ArrayList();
 }
 */

/* Good object orientation:
	an object knows how to do certain things.
  - client should manipulate an object only through its interface
 
 Example: chess game
	interface Pieces { ... }
 
	class Rook implements Piece { ... }
	class Pawn implements Piece { ... }
	...
 
	class Board {
		void badMove (Piece p, int x, int y) {
			if (p instanceof Pawn) {
				... check if legal move of pawn, and so make it
			} else if (p instanceof Rook) {
				... 
			}
		}
 
		//right way to do it
		void goodMove (Piece p, int x, int y) {
			if (p.isValidMove(x,y) {
				p.move(x,y);
			}
		}
		// all the if this, else this is implemented through the dynamic dispatch
	}
 */
 
 
 
 
 
 
 
 
 
 
 
 
 
