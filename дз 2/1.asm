%include "mac.inc"
section .data
	s db ' '
section .bss
	buffer resb 2000
	fd resb 100
	a resb 4
	b resb 4
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
	lea esi, [buffer]
	Hex:
		push ecx
		mov eax, 0
		
		lodsb
		
		mov bl, 0x10
		div bl
		
		cmp al, 0x0a
		jl p1
		add al, 0x07
		
		p1:
		mov [a], al
		add byte[a], 0x30
		
		cmp ah, 0x0a
		jl p2
		add ah, 0x07
		
		p2:
		mov [b], ah
		add byte[b], 0x30
		
		print a, 4
		print b, 4
		print s, 1
		
		pop ecx
	loop Hex
	
	mov eax, 1
	mov ebx, 0
	int 0x80
