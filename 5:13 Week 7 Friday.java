/*
 Pass by value:
 
 
 Pass by ref:
 */

//Pass by value:
/*class main {
 int x = 3;
 int y = changeX(x);
 System.out.print(y); //2
 System.out.print(x); //3
 
 int changeX (int x){
 x = 2;
 return x;
 }
 }
 */
class Item {
    static int z = 10;
    public int x;
    
    Item (int x) {
        this.x = x;
    }
    
    Item changX(Item i){
        i.x = 2;
        return i;
    }
    
    public static void main(){
        Item myX = new Item(3);
        Item myY = changeX(myX);
        System.out.print(myX.x);
        System.out.print(myY.x);
    }
    
}

/* "Indeed"  - company that uses Java
 */

/* EXCEPTIONS: 2 types
 
 unchecked (runtime) exception
 class myUnchecked extends (RunTimeException)
 
 checked 
 class myChecked extends Exception
 1. throw
 2. try catch
 
 
 */

class Hello {
    method () {
        try{
            // some code
        } catch (myUnchecked e1) {
           // catch (exception e)
            // e.specificMsg(x,y);
        } return;
        
    }
}

public class SuperClass {
    protected int myVar;
    
    SuperClass (int y){
        myVar = y;
    }
    public print (){}
}

public class SubClass extends SuperClass {
    public SubClass (int z)
    {
        super(s);
        //super myVar;
        //this.myVar;
    }
    
    public print (){
        super.print();
    }
}


/* GENERICS */
/*
public class Box<T> {
    private T t;
    
    public void add ( T t ) {
        this.t = t;
    }
    
    public T get() {
        return t;
    }
    
}

Box x = new Box();
Integer i = new Integer (3);
x.add(i);
String s = "help";
x.add(s);


Box <Integer> x = newBox <Integer>();
x.add(i);
Integer i2 = x.get();

Object o = x.get; // need to use "Object".. bad
*/
Integer x = new Integer(3);
changeX(x);
public void changeX(Integer x) {
x.set(2);
}
















