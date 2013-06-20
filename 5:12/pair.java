
interface Pair<F,S> {
    F first();
    S second();
}

class IntStringPair implements Pair<Integer,String> {
    public Integer first() { return 0; }

    public String second() { return "hi"; }

}

interface Drawable {
    void draw();
}

class Shape implements Drawable {

    public void draw() { }
}

class PairImpl<T1 extends Drawable, T2 extends Drawable>
    implements Pair<T1,T2>, Drawable {
    protected T1 fst;
    protected T2 snd;

    PairImpl(T1 f, T2 s) { fst = f; snd = s; }

    public String toString() {
	return "(" + fst.toString() + ", " + snd.toString() + ")";
    }

    public void draw() {
	fst.draw();
	snd.draw();
    }

    public T1 first() { return fst; }
    public T2 second() { return snd; }
}

class Main {

    public static void main(String[] args) {

	Pair<Integer,String> p = new IntStringPair();

// 	Pair<Integer,String> p2 =
// 	    new PairImpl<Integer,String>(new Integer(45), "hello");

	Pair<Shape,Shape> p2 =
	    new PairImpl<Shape,Shape>(new Shape(), new Shape());

	System.out.println(p2.toString());
	
 	Integer i = p.first();
 	int j = i.intValue() + 45;
 	System.out.println("first is " + i.toString());
    }
}