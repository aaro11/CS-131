
// static overloading:  doesn't solve our problem

interface Shape {
    boolean intersect(Shape s);
}

class Rectangle implements Shape {
    public boolean intersect(Shape s) {
	System.out.println("#1");
	return true;
    }
    public boolean intersect(Rectangle r) {
	System.out.println("#2");
	return true;
    }
   public boolean intersect(Triangle t) {
	System.out.println("#3");
	return true;
    }
}

class Triangle implements Shape {
    public boolean intersect(Shape s) {
	return true;
    }
    public boolean intersect(Rectangle r) {
	return true;
    }
   public boolean intersect(Triangle t) {
	return true;
   }

}

class Client {

    public static void main(String[] args) {
	Shape r = new Rectangle();
	Triangle t = new Triangle();
	r.intersect(t);
    }
}