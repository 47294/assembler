section .bss
	x resb 4
	y resb 4
section .text
	global _start
_start:
	mov eax, 3
	mov ebx, 0
	mov ecx, x
	mov edx, 4
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, y
	mov edx, 4
	int 0x80
	
	mov al, [x]
	sub al, 0x30
	mov bl, [y]
	sub bl, 0x30
	
	div bl
	
	add al, 0x30
	mov [x], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 2
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
