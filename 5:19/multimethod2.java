
/* instanceof and casts:
   - gives the right behavior
   - tedious, error prone (introduces the possibility of run-time
     cast errors)
   - hard to read, hard to extend

*/

interface Shape {
    boolean intersect(Shape s);
}

class Rectangle implements Shape {
    public boolean intersect(Shape s) {
	if (s instanceof Rectangle) {
	    Rectangle r = (Rectangle) s;
	    System.out.println("rectangle");
	    return true;
	} else if (s instanceof Triangle) {
	    Triangle t = (Triangle) s;
	    System.out.println("triangle");
	    return true;
	} else {
	    System.out.println("shape");
	    return true;
	}
    }
}

class Triangle implements Shape {
    public boolean intersect(Shape s) {
	return true;
    }

}

class Client {

    public static void main(String[] args) {
	Shape r = new Rectangle();
	Shape t = new Triangle();
	r.intersect(t);
    }
}