%include "mac.inc"
section .bss
	buffer resb 10000
	fd resb 1000
	len resb 10000
	result resb 1
	count resb 1
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
	mov edx, 10000
	int 0x80
	
	mov [len], eax
	mov bl, 10
	
	convert:
		cmp al, 0
		je Continue
		
		add byte[count], 1
		mov bl, 10
		div bl
		
		push ax
		xor ah, ah
		
		jmp convert
	Continue:
		mov ecx, [count]
		Printf:
		pop ax
		push ecx
		
		add ah, 0x30
		mov [result], ah
		print result, 1
		pop ecx
	loop Printf
	
	mov eax, 1
	mov ebx, 0
	int 0x80
