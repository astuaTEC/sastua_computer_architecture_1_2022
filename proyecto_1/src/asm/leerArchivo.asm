@ ;Programa para leer un archivo de texto

@ section .data
@     archivo db "archivo.txt", 0
@     handler dw ?
@     msgError1 db 10, 13, "Error: No se pudo abrir el archivo. $"
@     msgError2 db 10, 13, "Error: No se pudo leer el archivo. $"
@     fragmento db 11 dup("$")
@     limpiar db 11 dup("$")

@ section .text
@ global _start

@ ;org 100h

@ ; Definicion de macro
@ %macro imprimir macro texto
@     mov ah, 9
@     mov dx, offset texto
@     int 21h
@ %endmacro
@ ; Fin de macro

@ _start:
@     mov ah, 3dh
@     mov al, 0 ; modo lectura
@     mov dx, offset archivo
@     int 21h
@     jc err1
@     mov handler, ax

@ leer:
@     mov ah, 3fh
@     mov bx, handler
@     mov dx, offset fragmento
@     mov cx, 10 ; leer de 10 en 10
@     int 21h
@     jc err2
@     cmp ax, 0 ; si ax = 0 significa EOF
@     jz fin
@     imprimir fragmento

@ limpiar:
@     mov si, offset limpiar
@     mov di, offset fragmento
@     mov cx, 10
@     rep movsb
@     jmp leer

@ err1:
@     imprimir msgError1

@ err2:
@     imprimir msgError2

@ fin:
@     ; cerrar el archivo
@     mov ah, 3eh
@     mov bx, handler
@     int 21h
@     ret