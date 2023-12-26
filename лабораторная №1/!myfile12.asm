%macro unimacro 3
    MOV AX, %2
    MOV BX, %3
    CALL %1
%endmacro

%macro initstr 1
    MOV AX, %1
    CALL INITSTR1 
%endmacro

;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—
    
    initstr 00h
    unimacro TASK12, 00h, '#'

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
    mov AX, 4C00h
    int 21h

INITSTR1:
    MOV SI, AX
    MOV BX, 0
    MOV DX, 0
    MOV AX, 'A'
   REPEAT:
    MOV BYTE[SI+BX], '#'
    INC BX
    MOV CX, 5
   NEXTCHAR:
    MOV BYTE[SI+BX], AL
    INC BX
    INC AX
    LOOP NEXTCHAR
    INC DX
    CMP DX, 4
    JNE REPEAT 
    MOV BYTE[SI+BX], '#'
    INC BX
    MOV BYTE[SI+BX], 00h
RET

TASK12:    
    MOV SI, AX
    MOV DL, BL ; symbol
    MOV CX, 0
    MOV BX, 0
  NEXT1:
    
    CMP BX, 31
    JE  EXIT
    MOV AL, BYTE[SI+BX]
    INC BX
    CMP AL, 00h
    JE  EXIT
    CMP AL, DL
    JNE NEXT1
    INC CX
    JMP NEXT1
  EXIT:
    MOV AX, CX
RET
;===[ Начало сегмента данных ]==========================================