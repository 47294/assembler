%macro unimacro 2
    MOV AX, %2
    CALL %1
%endmacro

;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—
    
    unimacro TASK3_PAS, 00h   ; use task3 for init strings
    unimacro TASK3_C, 20h   ; use task3 for init strings
    unimacro TASK41, 00h
    unimacro TASK42, 20h    

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
    mov AX, 4C00h
    int 21h

TASK3_PAS:
    MOV SI, AX
    MOV CX, 12
    MOV [SI], CX
    INC SI
  NEXT1:
    MOV BYTE[SI], '#'
    INC SI
    LOOP NEXT1   

RET

TASK3_C:
    MOV SI, AX
    MOV CX, 15
  NEXT11:
    MOV BYTE[SI], '#'
    INC SI
    LOOP NEXT11

    MOV BYTE[SI], 00h

RET

TASK41:
    MOV SI, AX
    MOV BL, BYTE[SI] ; result in BL
RET

TASK42:
    MOV SI, AX
    MOV BX, 0
  NEXT2:
    MOV CL, BYTE[SI + BX]
    INC BX
    CMP CL, 00h
    JNE NEXT2
    DEC BX     ; dec becouse last char is 00h
    MOV CX, BX ; result in CX
RET

;===[ Начало сегмента данных ]==========================================