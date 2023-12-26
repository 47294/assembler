%macro unimacro 4
    MOV AX, %2
    MOV BX, %3
    MOV CX, %4
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
    unimacro TASK8, 00h, 05h, '#'

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
    
    MOV CX, 12
   NEXTCHAR2:
    MOV BYTE[SI+BX], AL
    INC BX
    DEC AX
    LOOP NEXTCHAR2  
    MOV BYTE[SI+BX], 00h
RET

TASK8:
    MOV SI, AX
    CMP BX, 0
    JB  EXIT 
    CMP BX, 31    
    JA  EXIT
    
    MOV DL, BYTE[SI+BX-1] ; save prev
    MOV BYTE[SI+BX-1], CL
  NEXT1:
    CMP BX, 31
    JE  SETNULL 
    MOV AL, BYTE[SI+BX] ; save actual
    MOV BYTE[SI+BX], DL ; set prev
    MOV DL, AL          ; set prev = actual
    INC BX
    CMP DL, 00h
    JNE NEXT1
  SETNULL:
    MOV BYTE[SI+BX], 00h
  EXIT:
RET

;===[ Начало сегмента данных ]==========================================