section .data
    msgError db "Se produjo un error",0xa,0xd
    lon equ $-msgError

    msgExito db "Archivo abierto con exito",0xa,0xd
    lonExito equ $-msgExito

    archivo db "archivo.txt",0

section .bss
idArchivo resd 1
contenido resb 16384

section .text
global _start

_start:
    mov eax, 5
    mov ebx, archivo
    mov ecx, 0002h ;lectura y escritura
    int 0x80

    cmp eax, 0
    jl error

    mov dword[idArchivo], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msgExito
    mov edx, lonExito
    int 0x80

    mov eax, 3
    mov ebx, [idArchivo]
    mov ecx, contenido
    mov edx, 16384
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, contenido
    mov edx, 16384
    int 0x80

    mov eax, 6
    mov ebx, [idArchivo]
    int 0x80

    jmp salir

error:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgError
    mov edx, lon
    int 0x80

salir:
    mov eax,1
    mov ebx,0
    int 0x80

