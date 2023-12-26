%include "mac.inc"
section .bss
	x resb 4
	y resb 4
	result resb 4
	f resb 1
section .text
	procedure:
	mov byte[f], 1
	
	mov ax, [x]
	cmp dword[x], 9
	jg double_digit_x
	and dword[x], 0x0F
	jmp check_y
	
	double_digit_x:
	and dword[x], 0xF0F
	mov ax, [x]
	xchg al, ah
	shl ah, 4
	xor al, ah
	mov [x], al
	
	check_y:
	cmp dword[y], 9
	jg double_digit_y
	print f, 1
	and dword[y], 0x0F
	add byte[f], 1
	jmp operation
	
	double_digit_y:
	and dword[y], 0xF0F
	mov bx, [y]
	xchg bl, bh
	shl bh, 4
	xor bl, bh
	mov [y], bl
	
	operation:
	cmp byte[f], 2
	je op1
	mov al, [x]
	mov bl, [y]
	adc al, bl
	daa
	jc m1
	
	mov ah, al
	shr ah, 4
	and al, 0xF
	add ax, 0x3030
	xchg ah, al
	mov [result], ax
	
	jmp m2
	
	m1:
	mov ah, al
	shr ah, 4
	and al, 0xF
	add ax, 0x3030
	xchg ah, al
	mov [result], ax
	
	mov byte[y], 1
	add byte[y], 0x30
	;print y, 1
	jmp m2
	
	op1:
	mov al, [x]
	mov bl, [y]
	adc al, bl
	daa
	jc opm1
	add al, 0x30
	mov [result], al
	jmp m2
	
	opm1:
	add al, 0x30
	mov [result], al
	
	mov byte[y], 1
	add byte[y], 0x30
	;print y, 1
	jmp m2
	
	m2:
	ret
	global _start
_start:
	input x, 4
	input y, 4
	
	call procedure
	;print result, 3
	
	mov eax, 1
	mov ebx, 0
	int 0x80
