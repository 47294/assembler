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
    unimacro TASK7, 00h, '#'

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

TASK7:
    MOV SI, AX
    MOV DL, BYTE[SI] ; save prev
    MOV BYTE[SI], BL
    MOV BX, 1
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
    
RET

;===[ Начало сегмента данных ]==========================================