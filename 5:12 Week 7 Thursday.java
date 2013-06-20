
interface Pair<F,S> {
    F first();
    S second();
    
}

/*
interface Pair {
    Object first();
    Object second();
    
}*/
class IntStringPair implements Pair <Integer, String> {
    public Integer first() { return 0; }
    public String second() { return "hi"; }
}

class PairImpl <T1, T2> implements Pair<T1,T2> {
    protected T1 fst;
    protected T2 snd;
    
    PairImpl(T1 f, T2 s) { fst = f; snd = s; }
    
    public T1 first() { return fst; }
    public T2 second() { return snd; }
    
}

/*
class PairImpl implements Pair {
    protected Object fst;
    protected Object snd;
    
    PairImpl(Object f, Object s) { fst = f; snd = s; }
    
    public Object first() { return fst; }
    public Object second() { return snd; }
    
}*/

/*
class Main {
    public static void main(String[] args) {
        Pair p = new PairImpl("hello", new Integer(3));
        // same as:
        //Pair p = new PairImpl("hello", 3);
        
        Object o = p.second();
        Integer i = (Integer) p.second();
        int j = i.intValue() + 45;
        
        System.out.println("first is " + p.first());
        System.out.println("second is " + p.second());
        
        System.out.println("ahh is " + i.toString());
        System.out.println("ahh is " + j);
    }
}*/

class Main {
    public static void main(String[] args) {
        Pair<Integer,String> p = new IntStringPair();
        Pair<Integer,String> p2 = new PairImpl<Integer,String> (45, "hello");
        Integer i = p.first();
        int j = i.intValue() + 45;
        System.out.println("first is " + i.toString());
    }
}

class OutOfBoundsException extends Exception{
    OutOfBoundsException() {}
    
    OutOfBoundsException(String message){
        super(message);
    }
}
// EXCEPTIONS
interface List<T>{
    void add(int i);
    
    T get(int i) throws OutOfBoundsException;
}

class OtherException extends Exception {}

class FatalError extends RuntimeException { }

class ListImpl<T> implements List<T>{
    // add an element at position i
    public void add (int i) { }
    
    public void helper() { throw new OtherException; }
    
    // get the element at position i
    public T get (int i) throws OutOfBoundsException {
        if (i > 1000)
            throw new FatalError;
        if (i < 0)
            throw new OutOfBoundsException("negative index");
        //..
        try {
            this.helper();
        } catch(OtherException e){
            System.out.println("caught the exception");
            
        } catch(AnotherException e){
            
        }
        this.helper();
        return null;
    }
}









