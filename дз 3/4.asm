%include "mac.inc"
section .bss
	buffer resb 100
	len resb 4
	gamma resb 4
section .text
	global _start
_start:
	mov word[gamma], 1234
	input buffer, 100
	mov [len], eax
	
	lea edi, [buffer]
	lea esi, [buffer]
	mov edx, [gamma]
	
	mov ecx, [len]
	
	Encrypt:
		lodsd
		xor eax, edx
		stosd
		sub esi, 3
		sub edi, 3
	loop Encrypt
	print buffer, [len]
	
	mov eax, 1
	mov ebx, 0
	int 0x80
