/* adapted from "Smashing the Stack for Fun and Profit"
   http://www.insecure.org/stf/smashstack.txt
*/

#include <stdio.h>

void function() {
    char buffer[8];
    int i;
    int* ret;

    i = 0;

    printf("i was %d\n", i);

    buffer[-4] = 5;

    printf("i is now %d\n", i);

    ret = (int*) &buffer[16];
    printf("ret is %x\n", *ret);
    *ret += 8;

}

int main() {
    int x = 34;
    function();
    printf("x is %d\n", x);
    return 0;
}
