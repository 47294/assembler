section .bss
	buffer resb 2000
	fd1 resb 1000
	len resb 1000
	name resb 10
	file resb 8
section .text
	global _start
_start:
	pop ebx
	pop ebx
	pop ebx
	mov eax, 5
	mov ecx, 2
	mov edx, 0
	int 0x80
	
	mov [fd1], eax
	
	mov eax, 3
	mov ebx, [fd1]
	mov ecx, buffer
	mov edx, 2000
	int 0x80
	
	mov [len], eax
	
	lea esi, [buffer]
	lea edi, [buffer]
	mov ecx, [len]
	
	Change:
	
	push ecx
	lodsb
	mov ah, 0x7A
	cmp al, ah
	jg skip
	
	mov ah, 0x61
	cmp al, ah
	jl skip
	
	sub al, 0x20
	stosb
	
	skip:
	pop ecx
	loop Change
	
	mov eax, 19
	mov ebx, [fd1]
	mov ecx, 0
	mov edx, 0
	int 0x80 
	
	mov eax, 4
	mov ebx, [fd1]
	mov ecx, buffer
	mov edx, [len]
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
