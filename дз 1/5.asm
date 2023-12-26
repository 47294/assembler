section .bss
	x resb 20
section .text
	global _start
_start:
	mov eax, 3
	mov ebx, 0
	mov ecx, x
	mov edx, 20
	int 0x80
	
	mov bl, byte[x]
	mov cl, byte[x+3]
	mov byte[x], cl
	mov byte[x+3], bl
	
	mov bl, byte[x+2]
	mov cl, byte[x+7]
	mov byte[x+2], cl
	mov byte[x+7], bl
	
	mov eax, 4
	mov ebx, 1
	mov ecx, x
	mov edx, 20
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80

	
