section .bss
	buffer resb 2000
	fd1 resb 1000
	fd2 resb 1000
	fd3 resb 1000
	x resb 10
	
section .text
	global _start
_start:
	mov eax, 5
	pop ebx
	pop ebx
	pop ebx
	mov ecx, 0
	mov edx, 0
	int 0x80
	
	mov [fd1], eax
	
	mov eax, 5
	pop ebx
	mov ecx, 0
	mov edx, 0
	int 0x80
	
	mov [fd2], eax
	
	mov eax, 8
	pop ebx
	mov ecx, 300
	int 0x80
	
	mov [fd3], eax
	
	mov eax, 3
	mov ebx, [fd1]
	mov ecx, buffer
	mov edx, 2000
	int 0x80
	
	mov [x], eax
	
	mov eax, 4
	mov ebx, [fd3]
	mov ecx, buffer
	mov edx, [x] 
	int 0x80
	
	mov eax, 3
	mov ebx, [fd2]
	mov ecx, buffer
	mov edx, 2000
	int 0x80
	
	mov [x], eax
	
	mov eax, 4
	mov ebx, [fd3]
	mov ecx, buffer
	mov edx, [x] 
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
