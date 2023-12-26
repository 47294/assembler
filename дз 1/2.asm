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
	add al, bl
	cmp eax, 10
	jl f1
	
	mov bx, 10
	sub ax, bx
	mov [x], eax
	mov byte[y], 1
	add word[x], 0x30
	add byte[y], 0x30
	mov eax, 4
	mov ebx, 1
	mov ecx, y
	mov edx, 1
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 4
	int 0x80
	
	jmp f2
	
	f1:
	
	mov [x], ax
	add word[x], 0x30
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 4
	int 0x80

	f2:
	mov eax, 1
	mov ebx, 0
	int 0x80
