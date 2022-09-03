%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data
    msgError db "Se produjo un error",0xa,0xd
    len equ $-msgError

    ln db 0xA,0xD
    lenln equ $-ln

    space db 0x20
    lenSpace equ $-space

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

    mov ebp, contenido
    ;mov edi, 1

    mov esp, 0

    ; Imprimir lo que hay en la dirección "contenido"
    ; mov eax, 4
    ; mov ebx, 1 ; Escribir en consola
    ; mov ecx, contenido
    ; mov edx, 3 ; Bytes a imprimir
    ; int 0x80

    ; Cerrar el archivo
    ; mov eax, 6
    ; mov ebx, [idArchivo]
    ; int 0x80

    ; jmp salir

filas:
    mov edi, 1 ; se limpia el contador de columnas
    cmp esp, 97 ; se compara el contador de filas
    jb ciclo ; si es menor, se imprime una nueva columna

    ; Cierra el archivo
    mov eax, 6
    mov ebx, [idArchivo]
    int 0x80

    jmp salir

ciclo:
    imprime ebp, 3 ;imprime 3 bytes
    imprime space, lenSpace ; imprime un espacio

    add ebp, 4 ;dirección de memoria del archivo
    add edi, 3 ;ya imprimi 3 bytes, actualiza contador

    cmp edi, 291
    jb ciclo

    add esp, 1 ;se actualiza el contador de filas
    imprime ln, lenln ; se imprime un salto de linea
    jmp filas


error:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgError
    mov edx, len
    int 0x80

salir:
    mov eax,1
    mov ebx,0
    int 0x80

