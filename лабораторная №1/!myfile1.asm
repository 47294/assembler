;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—

    MOV AX, 00h
    CALL TASK1
    MOV AX, 20h
    CALL TASK1
    MOV AX, 40h
    CALL TASK1

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
    mov AX, 4C00h
    int 21h

TASK1:
    MOV SI, AX
    MOV AX, 00h
    MOV [SI], AX
RET
;===[ Начало сегмента данных ]==========================================
