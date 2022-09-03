section .data
    msgError db "Se produjo un error",0xa,0xd
    lon equ $-msgError

    msgExito db "Archivo abierto con exito",0xa,0xd
    lonExito equ $-msgExito

    archivo db "../image.txt",0

section .bss
idArchivo resd 1
contenido resb 50000 ; Almacenar n cantidad de bytes

section .text
global _start

_start:
    ; Interrupcion para abrir el archivo
    mov eax, 5
    mov ebx, archivo
    mov ecx, 0002h ;lectura y escritura
    int 0x80

    cmp eax, 0 ; ver si su pudo abrir el archivo
    jl error

    mov dword[idArchivo], eax ; trasladar 4 bytes a idArchivo

    ; Imprimir mensaje de exito
    mov eax, 4
    mov ebx, 1
    mov ecx, msgExito
    mov edx, lonExito
    int 0x80

    ; Transferir txt a la dirección de memoria "contenido"
    mov eax, 3 ;Indicar al sistema para leer contenido
    mov ebx, [idArchivo] ; De donde hay que leer
    mov ecx, contenido ; Almacenar contenido del archivo
    mov edx, 50000 ; leer cierta cantidad de bytes
    int 0x80

    ; Imprimir lo que hay en la dirección "contenido"
    mov eax, 4
    mov ebx, 1 ; Escribir en consola
    mov ecx, contenido
    mov edx, 3 ; Bytes a imprimir
    int 0x80

    ; Cerrar el archivo
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

