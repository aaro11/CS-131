
/* double dispatch:
   - gets the right behavior
   - cumbersome, error-prone (but at least no casts)
   - tedious to extend
*/

interface Shape {
    boolean intersect(Shape s);
    boolean intersectRect(Rectangle r);
    boolean intersectTri(Triangle t);
}

class Rectangle implements Shape {
    public boolean intersect(Shape s) {
	return s.intersectRect(this);
    }
    public boolean intersectRect(Rectangle r) {
	    /* implement intersection of a rect and a rect */
	System.out.println("rect, rect");
	return true;
    }
   public boolean intersectTri(Triangle t) {
	    /* implement intersection of a rect and a tri */
	System.out.println("rect, tri");
	return true;
    }
}

class Triangle implements Shape {
    public boolean intersect(Shape s) {
	return s.intersectTri(this);
    }
    public boolean intersectRect(Rectangle r) {
	    /* implement intersection of a rect and a tri */
	System.out.println("tri, rect");
	return true;
    }
   public boolean intersectTri(Triangle t) {
	   /* implement intersection of a tri with a tri */
	System.out.println("tri, tri");
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
