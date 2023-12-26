section .data
	s db ' '
section .bss
	buffer resb 2000
	fd resb 100
	len resb 100
section .text
	procedure:
	mov bx, 7
	mul bx
	add ax, 17
	mov bx, 256
	div bx
	mov ax, dx
	xor dx, dx
	ret
	
	global _start
_start:
	pop ebx
	pop ebx
	pop ebx
	mov eax, 5
	mov ecx, 2
	mov edx, 0
	int 0x80
	
	mov [fd], eax
	
	mov eax, 3
	mov ebx, [fd]
	mov ecx, buffer
	mov edx, 2000
	int 0x80
	
	mov ecx, eax
	mov [len], eax
	lea esi, [buffer]
	lea edi, [buffer]
	mov ax, 195
	Rw:
		push ecx
		call procedure
		stosw
		pop ecx
	loop Rw
	
	mov eax, 19
	mov ebx, [fd]
	mov ecx, 0
	mov edx, 0
	int 0x80 
	
	mov eax, 4
	mov ebx, [fd]
	mov ecx, buffer
	mov edx, [len]
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
