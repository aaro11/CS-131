/*
 essentially.. everything is a pointer..
*/
class C {
	protected int i;
	protected String s;

	C(int i, String s) { this.i = i; this.s = s; }
}

class D extends C {
	protected boolean b;
	D(int i, String s, boolean b){
		super(i, s);
		this.b = b;
	}
}

/*
 Parameter passing is *by value*;
 copy the value of hte actual parameter into the formal parameter
 
 key property: the value of the formal paramter cannot change
	as a result of the call
 
 */
class IntPair {
	int a;
	int b;
	IntPair (int a, int b) { this.a = a; this.b = b; }
}
class ParameterPassing {
	int add(int a, int b) {
		a+= b;
		return a;
	}
	
	int addPair(IntPair pair) {
		pair.a += pair.b;
		return pair.a;
	}
	
	public static void main(String[] args){
		ParameterPassing p = new ParameterPassing();
		
		int x = 3;
		int y = 4;
		//int z = p.add(x,y);

		IntPair pair = new IntPair(3,4);
		int z = p.addPair(pair);
		
		System.out.println("x is " + x);
		System.out.println("y is " + y);
		System.out.println("z is " + z);
		
		System.out.println("a is " + pair.a);
		System.out.println("b is " + pair.b);
		System.out.println("z is " + z);
	}
}

/* Parameter passing *by reference*:
	make the formal parameter an alias of the actual parameter

 C++ example:

int add (int &a, int &b) {
	a+=b;
	return a;
}
x = 3;
y = 5;
z = add(x,y);

the arguments to add must b l-values -- things that can appear
	on the left-hand-side of an assignment

z = add(3,4); //error, not allowed

you can do this explicitly with pointers:
	int add (int *a, int *b) {
		*a += *b;
		return *a;
	}

	int x = 3;
	int y = 4;
	add (&x, &y);

*/