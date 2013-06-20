Final Exam:

Cumulative
 - OCaml - (Functional)
 - Java - (Object-Oriented)
 - Prolog - (Logic)

 Java:
* inheritance:
 - being able to use public and protected members of Super class 
    without having to copy/paste code

     ie: 
abstract class Shape {
    // public int area() { return length * width; }

    // all abstract methods must not contain a body
    public abstract int area();

    // the difference between an abstract class:
    // you can have fields
    public int length;
    public int getLength() { return length; }

    // can declare protected things:
    // protected ...
}

* abstract classes vs interfaces
    - abstract classes can provide method bodies and fields
    - interface only contain methods

    ie:
// interface:
    interface Shape {
	int area();
    }
- everything in an interface must be public
- cant instantiate

// in C++, 
// an interface is a pure virtual class

    class Rhombus extends Shape {
    int area () { length * width; }
}

* SUBTYPING - "extends", "implements"
-> child classes can be used where parent is expected

    class Ellipse implements Shape {
    public double circumference() {...}
    public int area();
}

class Circle extends Ellipse { circumference(); }
class Oval extends Ellipse { circumference(); }

// you can post an ellipse and a circle
// if you pass in Circle, you cannot access methods from Circle

public int circumference(Ellipse e) {

* DYNAMIC DISPATCH
    Ellipse e; 

e = new Oval();
e.circumference(); // will call Oval's circumference

* runtime determintation of correct method to call

abstract class Ellipse implements Shape {
    abstract public double circumference() {...}
    abstract public int area();
}

    class Circle extends Ellipse{
    private double radius;
    public double circumference(){
	return 2*radius*math.PI;
    }
	public int area () {
	    return (int)(math.PI*R*R);
	}
}

*JAVA MEMORY MODEL
    - Java is passed by value!!
    - primitive types : int, double.
    - "reference types" - all classes
	
PRIMITIVE:
    int x = 5;
    int y = x;
    y++; // 6
    x?; // 5

REFERENCE:
	class A {
	    public int x;
	}
    A x = new A ();
    A x.x = 5;
    A y = x;
    y.x++; // 6
    x.x?; // 6

*GENERICS - Java's way of Parametric Polymorphism
    class List <T> { void add(T obj); }
}

w/o generics:
Vector t = new Vector();
t.add(new A());
t.add(new Circle());

Class c = (Circle) t.get(0); // exception

WITH GENERICS:
List<Ellipse> t = new List <Ellipse> ();
t.add(new A()); // compile error
t.add(new Circle()); // OKAY!
t.get(0); // no error, because the list is only circles

Ellipse e = t.get(0);
e.circumference(); // will call Circle's circumference

* EXCEPTIONS
    - Java has checked Exceptions;
    - if you declare a method;

    void foo(int x) throws BadArgsExpection{
	if (x < 0)
	    throw new BadArgsException();
    }

    try {
	foo(5);
    } catch(BadArgsException e) {
	// ...;
    }

    interface Foo{
	int bar() throws IOException();
    }
    public class FooFoo implements Foo {
	public int bar() {...}
    }

*** PROLOG ***
* A program is a collection of
    - facts - cat(kitty).
    - rules animal(X) :- cat(X)
	?- animal(kitty)
	- yes

cat(kitty).
cat(cookie).
animal(X) :- cat(X).
fourlegs(X) :- cat(X).

% Complex rules can be created
quadropod(X) :- animal(X), fourlegs(X).
quadropod(kitty).

rule([]).
rule([X|Y]) :- rule(Y).
