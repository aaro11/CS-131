/* Three main topics of java:
 
 Inheritance, Subtyping, Dynamic Dispatch
 Generics
 
 
 */

/*
 Inheritance:
	* Code reuse
 
	ie. class a {
			public void foo () {
			...
		}
		class b extends a {
			...
		}
		class StackImpl implements Stack {
			Object[] items;
			int size () {
				return items.length;
			}
			push;pop.. etc
		}
		class B extends StackImpl {
			void push (Object s){
				...
			}
		}
 */

/*
 Subtyping:
	* If B is a subtype of A, an instance of B can be used wherever an A is expected.
 
	ie. interface Stack extends Collection {
			void push (Object o);
			Object pop();
		}
		interface Collection {
			int size();
		}
 
		void printSize (Collection c) {
			System.out.println(c.size()).
		}
		void printTop (Stack s) {
			System.out.println(s.pop());
		}
*/

/*
 Dynamic Dispatch:
	* Runtime determination ("dynamic") of the correct target for
	  a method, irrespective of the static type of an object.
	
	ie. void foo (StackImpl s) {
			...
			// if you call 
			s.push(null);
		}
 
	//if you called
		foo (new B());
	this would use B's implementation of push
		
*/

/*
 Class type hierarchy
 Interface	Classes
 Collection
	^
	|			Object
	|				^
	|				|
	|			Stack Impl
 Stack				^
					|
					B

*/

/*
 Generics
	//this is why generics was invented
	class A {
	
	}
	Stack s = newStack();
	s.push (new A());
	A obj = (A) s.pop();
	
	interace Stack <T>
		T pop();
		void push (T o);
	}
 

*/