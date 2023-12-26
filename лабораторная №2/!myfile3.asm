%macro init2 5
	MOV dh, %1
	MOV dl, %2
    MOV si, %3
	MOV cx, %4
	MOV bl, %5
	CALL TASK3
%endmacro


;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—

init2 5, 15, 10, 20, 00010010b

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
mov AX, 4C00h
int 21h

;---[ Начало подпрограммы ]-----------------------------------------------------------—


TASK3:
    mov di, top
    mov BYTE[di], 201
    mov di, center
    mov BYTE[di], 186
    mov di, bottom
    mov BYTE[di], 200
    push bx
    push cx
    sub cx, 2
    mov bx, 1
   repeat1:
    mov di, top
    mov BYTE[di+bx], 205
    mov di, center
    mov BYTE[di+bx], 32
    mov di, bottom
    mov BYTE[di+bx], 205
    inc bx
    loop repeat1
    
    mov BYTE[di+bx], 188
    mov BYTE[di+bx+1], 00h
    mov di, top
    mov BYTE[di+bx], 187
    mov BYTE[di+bx+1], 00h
    mov di, center
    mov BYTE[di+bx], 186
    mov BYTE[di+bx+1], 00h

    pop cx
    pop bx

    mov ah,00h
    mov al, 3
    int 10h

    mov ah, 02h
    mov bh, 0
    int 10h
    
    mov di, cx
    mov ah, 13h
    mov al, 0
    mov bp, top
    int 10h

   repeat2:
    inc dh
    dec si
    mov ah, 13h
    mov al, 0
    mov cx, di
    mov bp, center
    int 10h
    cmp si, 1
    jne repeat2
    
    mov ah, 13h
    mov al, 0
    mov cx, di
    inc dh
    mov bp, bottom
    int 10h
    

RET

;===[ Начало сегмента данных ]==========================================
top:    times 100 db 0
center: times 100 db 0
bottom: times 100 db 0
