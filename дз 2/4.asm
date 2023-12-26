%include "mac.inc"
section .data
	s db ' '
	one db '1'
	zero db '0'
section .bss
	buffer resb 2000
	fd resb 100
	x resb 4
	len resb 4
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
	
	mov [len], eax
	
	lea esi, [buffer]
	
	mov ax, [len]
	mov bl, 4
	div bl
	mov [len], al
	
	cmp ah, 0
	jg summ
	jmp h1
	
	summ:
		mov eax, [len]
		add ecx, 1
	h1:
		lea esi, [buffer]
		mov ecx, [len]
		Tran:
			push ecx
			lodsb
			xor [x], eax
			
			pop ecx
			loop Tran
			
	mov eax, [x]
	mov ecx, 32
	ToBinary:
		push ecx
		rol eax, 1
		push eax
		
		jc Printone
		print zero, 1
		jmp Next
		
		Printone:
		print one, 1
		
		Next:
		pop eax
		pop ecx
		
	loop ToBinary
	print s, 1
	mov eax, 1
	mov ebx, 0
	int 0x80
