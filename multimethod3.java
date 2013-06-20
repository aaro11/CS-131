/* instanceof and casts
 * 
 * - gives the right behavior
 * - tedious, error prone (introduces the possibility of run-time cast errors)
 * - hard to read, hard to extend
 * 
 * but it works.
 */

interface Shape {
	boolean intersect(Shape s);
}

class Rectangle implements Shape {
	
	// THIS IS STATIC OVERLOADING: DOESN'T SOLVE PROBLEM
	// 
	/*public boolean intersect(Shape s){
     System.out.println("1");
     return true;
     }
     public boolean intersect(Rectangle r) {
     System.out.println("2");
     return true;
     }
     public boolean intersect(Triangle r) {
     System.out.println("3");
     return true;
     }*/
	
	
	// introducing possibility to runtime error
	// if you use casts
	public boolean intersect (Shape s) {
		if (s instanceof Rectangle)	{
			Rectangle r = (Rectangle) s;
			System.out.println("retangle");
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
	
	// STATIC OVERLOADING: NOT GOOD FOR THIS PART
	/*
     public boolean intersect(Shape s){
     return true;
     }
     public boolean intersect(Rectangle r) {
     return true;
     }
     public boolean intersect(Triangle r) {
     return true;
     }*/
	public boolean intersect (Shape s) {
		if (s instanceof Rectangle)	{
			Rectangle r = (Rectangle) s;
			System.out.println("retangle");
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

class Client2 {
	public static void main(String[] args) {
		Shape r = new Rectangle();
		Shape t = new Triangle();
		r.intersect(t);
	}
}