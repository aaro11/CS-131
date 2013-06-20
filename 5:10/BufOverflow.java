/* from "Smashing the Stack for Fun and Profit"
   http://www.insecure.org/stf/smashstack.txt
*/

class BufOverflow {
    static void func(char[] str) {
	char buf[] = new char[126];
	for (int i = 0; i < str.length; i++) {
	    buf[i] = str[i];
	}
    }

    public static void main(String[] args) {
	char large[] = new char[256];
	
	for(int i = 0; i < 256; i++)
	    large[i] = 'A';
	func(large);
    }
}
