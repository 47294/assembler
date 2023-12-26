%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro
%macro input 2
mov eax, 3
mov ebx, 0
mov ecx, %1
mov edx, %2
int 0x80
%endmacro
