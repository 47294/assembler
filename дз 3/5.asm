%include "mac.inc"
section .bss
	fd resb 2000
	len resb 4
	buffer resb 2000
	x resb 4
	y resb 4
section .text
	global _start
_start:
	pop ebx
	pop ebx
	pop ebx
	mov eax, 5
	mov ecx, 0
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
	find:
		push ecx
		lodsb
		cmp ax, 0xA
		je m1
		add esi, 1
		inc word[x]
		pop ecx
	loop find
	m1:
	mov ecx, [len]
	out:
		push ecx
		add esi, 1
		lodsb
		cmp ax, 0xA
		je m2
		mov [y], ax
		print y, 2
		pop ecx
	loop out
	m2:
	mov eax, 1
	mov ebx, 0
	int 0x80
