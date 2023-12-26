section .bss
	x resb 4
section .text
	global _start
_start:
	mov eax, 3
	mov ebx, 0
	mov ecx, x
	mov edx, 4
	int 0x80
	cmp byte[x], 0x5A
	je f1
	cmp byte[x], 0x7A
	je f1
	
	add byte[x], 1
	int 0x80
	
	
	f1:
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 4
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
