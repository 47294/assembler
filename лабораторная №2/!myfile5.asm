%macro init2 3
	MOV dh, %1
	MOV dl, %2
	MOV bl, %3
	CALL TASK5
%endmacro


;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—

init2 5, 15, 00010010b

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
mov AX, 4C00h
int 21h

;---[ Начало подпрограммы ]-----------------------------------------------------------—


TASK5:
    mov ah,00h
    mov al, 3
    int 10h

    mov ah, 02h
    mov bh, 0
    int 10h

    mov ah, 13h
    mov al, 0
    mov cx, 20
    mov bp, top
    int 10h
    
    mov ah, 13h
    mov al, 0
    mov cx, 20
    inc dh
    mov bp, stih1
    int 10h

    mov ah, 13h
    mov al, 0
    mov cx, 20
    inc dh
    mov bp, stih2
    int 10h

    mov ah, 13h
    mov al, 0
    mov cx, 20
    inc dh
    mov bp, stih3
    int 10h

    mov ah, 13h
    mov al, 0
    mov cx, 20
    inc dh
    mov bp, stih4
    int 10h    

    mov ah, 13h
    mov al, 0
    mov cx, 20
    inc dh
    mov bp, bottom
    int 10h
RET

;===[ Начало сегмента данных ]==========================================
top    db 201,205,205,205,'Pushkin A.S.'205,205,205,,187
stih1  db 186,' Vody glubokiye   ',186
stih2  db 186,' Plavno tekut.    ',186
stih3  db 186,' Lyudi premudryye ',186
stih4  db 186,' Tikho zhivut.    ',186
bottom db 200,205,205,205.205,205,205,205,205,205.205,205,205,205,205,205.205,205,205,188