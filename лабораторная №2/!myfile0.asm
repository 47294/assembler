
%macro init 2
	MOV dh, %1
	MOV dl, %2
	CALL TASK0
%endmacro

;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—

init 10, 40

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
mov AX, 4C00h
int 21h

TASK0:
    mov ah,00h
	mov al, 3 	; видеорежим (используем 3-й)
	int 10h   	; включение 3го текстового режима + очистка экрана и курсор в (0,0)

	mov ah,02h
	mov bh, 0	; видеостраница (0-я - это экран, но есть другие за его пределами)
	int 10h  	; переместить курсор в указанную позицию

RET
;===[ Начало сегмента данных ]==========================================
