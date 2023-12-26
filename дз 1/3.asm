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
	mul bl
	mov bx, 0
	f1:
		inc bx
		sub ax, 10
	jge f1
	add ax, 10
	add ax, 0x30
	sub bx, 1
	add bx, 0x30
	mov [x], ax
	mov [y], bx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, y
	mov edx, 4
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 4
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80
