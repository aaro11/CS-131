
class Exn1 extends Exception {}
class Exn2 extends Exception {}
class Exn3 extends Exception {}

class C {
    Object m(Object o) throws Exn1, Exn2 {
	System.out.println("invoked C.m");
	if(false)
	    throw new Exn1();
	if(false)
	    throw new Exn2();
	return o;
    }
}

class D extends C {
    String m(Object o) throws Exn1 {
	System.out.println("invoked D.m");
	return o.toString();
    }
}

class Client {
    Object callM(C c) throws Exn1, Exn2 {
	Object o = c.m(new Integer(3));
	return o;
    }

    public static void main(String[] args) {
	Client client = new Client();
	C c = new D();
	try {
	    System.out.println(client.callM(c));
	} catch(Exn1 e) {}
	catch (Exn2 e) {}
    }

}