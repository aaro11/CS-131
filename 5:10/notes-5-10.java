
/*
  Parameter passing is *by value*:
  copy the value of the actual parameter into the formal parameter

  key property:  the value of the formal parameter cannot change
  as a result of the call

*/

class IntPair {
    int a;
    int b;

    IntPair(int a, int b) { this.a = a; this.b = b; }
}

class ParameterPassing {

    int add(int a, int b) {
	a += b;
	return a;
    }

    int addPair(IntPair pair) {
	pair.a += pair.b;
	return pair.a;
    }
	

    public static void main(String[] args) {
	ParameterPassing p = new ParameterPassing();

	int x = 3;
	int y = 4;
// 	int z = p.add(x,y);

	IntPair pair = new IntPair(3,4);
	int z = p.addPair(pair);

	System.out.println("a is " + pair.a);
	System.out.println("b is " + pair.b);
	System.out.println("z is " + z);

    }

}