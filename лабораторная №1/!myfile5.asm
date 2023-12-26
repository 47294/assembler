%macro unimacro 3
    MOV AX, %2
    MOV BX, %3
    CALL %1
%endmacro

;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—
    
    MOV AX, 00h
    CALL INITSTR
    unimacro TASK5, 00h, 'H'
    unimacro TASK5, 00h, 'E'
    unimacro TASK5, 00h, 'L'
    unimacro TASK5, 00h, 'L'
    unimacro TASK5, 00h, 'O'

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
    mov AX, 4C00h
    int 21h

INITSTR:
    MOV SI, AX
    MOV BYTE[SI], 00h
RET

TASK5:
    MOV SI, AX
    MOV CX, BX
    MOV BX, 0
  NEXT1:
    MOV DL, BYTE[SI+BX]
    INC BX
    CMP DL, 00h
    JNE NEXT1
    DEC BX
    MOV [SI+BX], CX
    MOV BYTE[SI+BX+1], 00h
    
RET

;===[ Начало сегмента данных ]==========================================