/* from "Smashing the Stack for Fun and Profit"
   http://www.insecure.org/stf/smashstack.txt
*/

#include <string.h>

void mystrcpy(char* dest, const char* src) {
    int i = 0;
    while(src[i]) {
	dest[i] = src[i];
	i++;
    }
}

void func(char *str) {
    char buf[126];
    strcpy(buf, str);
}

int main() {
    char large[256];
    int i;

    for(i = 0; i < 256; i++)
	large[i] = 'A';
    func(large);

    return 0;
}
