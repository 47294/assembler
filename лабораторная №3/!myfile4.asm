%macro task4 3
	mov ah, 3Ch             ;Функция DOS 3Ch (создание файла)
    mov dx, %1	            ;Указатель на начало строки в памяти (имя файла)
    mov si, %2
    mov di, %3
    mov cx, 0                ;Нет атрибутов - обычный файл
	call read_file
 
%endmacro

;===[ Начало сегмента кода ]============================================
MYCODE: segment .code
org 100h ; Обязательная директива ТОЛЬКО для COM-файлов
START:
;---[ Точка старта ]-------------------------------------------------------------------—

task4 file_name, buffer, 2

;---[ Стандартное завершение программы ]----------------------—
mov AX, 4C00h
int 21h

; Процедура вывода сообщения об ошибке
error_msg:
    mov ah,9
    mov dx,s_error
    int 21h                 ;Вывод сообщения об ошибке
    ret


;==================================================================

read_file:
    mov al,0                	;Режим открытия - только чтение
    int 21h                 		;Обращение к функции DOS
    jnc NO_ERR2             	;Если нет ошибки, то продолжаем
    call error_msg          	;Иначе вывод сообщения об ошибке
    jmp exit2               	;Выход из программы
NO_ERR2:
    mov [handle],ax         	;Сохранение дескриптора файла

    mov bx,[handle]         	;Дескриптор файла
    mov ah,3Fh              	;Функция DOS 3Fh (чтение из файла)
    mov dx,si          	        ;Адрес буфера для данных
    mov cx,80               	;Максимальное кол-во читаемых байтов
    int 21h                     ;Обращение к функции DOS
    jnc READ1     	            ;Если нет ошибки, то продолжаем
    call error_msg          	;Вывод сообщения об ошибке
    jmp close_file          	;Закрыть файл и выйти из программы
 
READ1:
    mov bx,buffer
    add bx,ax               	;В AX количество прочитанных байтов
    mov byte[bx],'$'        	;Добавление символа '$'
    
    mov bx, buffer
    mov bp, bx
    mov cx, 0 
    
  next: 
    mov bp, si
    
    mov dx, [bx]
    inc bx
    
    cmp dx,'$'
    jne print
    cmp dx,13
    jne next
    mov si,bx
    inc cx
    cmp cx,di
    jne next

  print:
    mov ah,9
    mov dx,bp
    int 21h                 		;Вывод содержимого файла
    mov dx,endline
    int 21h                 		;Вывод перехода на новую строку
 
close_file:
    mov ah,3Eh              	;Функция DOS 3Eh (закрытие файла)
    mov bx,[handle]         	;Дескриптор
    int 21h                 		;Обращение к функции DOS
    jnc exit2               	;Если нет ошибки, то выход из программы
    call error_msg          	;Вывод сообщения об ошибке 

exit2:
    mov ah,9                	;Вывод строки 'All is ok!'
    mov dx,s_pak
    int 21h
RET

;==================================================================

;===[ Начало сегмента данных ]==========================================
file_name 	db 'new_file.txt',0
message	    db 'HeLLo',13,10,'message!'
size      	db 15
s_error   	db 'Error!',13,10,'$'
s_pak     	db 'All is ok!$'
endline   	db 13,10,'$'
handle    	dw 1              ;Дескриптор файла
buffer:     times 100 db 0
buffer2:     times 100 db 0
