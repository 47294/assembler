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
    
    initstr 40h
    unimacro TASK9, 40h, '#'

;---[ Стандартное завершение программы - НЕ СТИРАТЬ НИКОГДА !!! ]----------------------—
    mov AX, 4C00h
    int 21h

INITSTR1:
    MOV SI, AX
    MOV BX, 0
    MOV CX, 16
    MOV AX, 'A'
   NEXTCHAR:
    MOV BYTE[SI+BX], AL
    INC BX
    INC AX
    LOOP NEXTCHAR
    
    MOV BYTE[SI+BX], '#'
    INC BX
    MOV CX, 12
   NEXTCHAR2:
    MOV BYTE[SI+BX], AL
    INC BX
    DEC AX
    LOOP NEXTCHAR2  
    MOV BYTE[SI+BX], 00h
RET

TASK9:    
    MOV SI, AX
    MOV DL, BL
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
    MOV AL, BL ; found! copy to AL
  EXIT:
RET

;===[ Начало сегмента данных ]==========================================