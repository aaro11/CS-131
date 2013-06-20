
class OutOfBoundsException extends Exception {
    OutOfBoundsException() {}

    OutOfBoundsException(String message) {
	super(message);
    }

}

// unchecked exception
class FatalError extends RuntimeException {}

class OtherException extends Exception {}

interface List<T> {
    void add(int i);

    T get(int i) throws OutOfBoundsException;
}

class ListImpl<T> implements List<T> {

	// add an element at position i
    public void add(int i) { }

    void helper() throws OtherException {
	throw new OtherException();
    }

	// get the element at position i
    public T get(int i) throws OutOfBoundsException {
	if (i < 0)
	    throw new OutOfBoundsException("negative index");
	    // ...

	if (i > 1000)
	    throw new FatalError();
	try {
	    this.helper();
	} catch(OtherException e) {
	    System.out.println("caught the exception");
	}
	    // can have multiple catch blocks
	// catch(AnotherException e) {
// 		// ...
// 	}
	return null;

    }

}