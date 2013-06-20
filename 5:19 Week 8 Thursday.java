/*
 Thursday 5/19/11
 
 */

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
        return o; }
}

class D extends C {
	// safe to change the return type of an overwriting method
	// a "more specific type"
	//		aka "String" instead of "Object"
	// but not the other way around
	
	/*************************************************/
	
	// if you change the type of the argument to "String"
	// 	 String m(String o)
	// makes the method completely different than the other one.
	// NOT overwriting .. IT IS overloading
	
	/*************************************************/
	
	/* Is it okay for D.m to INCLUDE another exception?
	 * NO, because the caller doesn't know about the 3rd exception
	 * NOT ALLOWED to extend the exceptions
	 */
	
	/*************************************************/
	
	/* Is it okay for D.m to DISCLUDE an exception?
	 * YES, because this function just wont handle the 2nd exception.
	 * Allowed to NARROW the exceptions.
	 */
	
    String m(Object o) throws Exn1, Exn2{ 
        System.out.println("invoked D.m");
        return "hello"; 
    }
}

class Client {
    Object callM (C c) throws Exn1, Exn2 {
        // c -> invokes c's m method
        // d -> invokes d's m method
        Object o = c.m(new Integer(3));
        return o;
    }
    
    public static void main(String[] args){
        Client client = new Client();
        C c = new D();
        try {
            System.out.println(client.callM(c));
            
        } 
        // catches go in type order
        catch (Exn1 e) {}
        catch (Exn2 e) {}
    }
}