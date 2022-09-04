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

    archivo db "archivo.txt",0
    archivoDest db "destino.txt",0

section .bss
idArchivo resd 1
contenido resb 50000 ; Almacenar n cantidad de bytes

idArchivoDest resd 1
contenidoDest resb 50000;

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

    mov esi, contenido; dirección de memoria de contenido

    jmp atoi

error:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgError
    mov edx, len
    int 0x80

; https://stackoverflow.com/questions/19461476/convert-string-to-int-x86-32-bit-assembler-using-nasm
; el resultado se guarda en edi (rdi)
atoi:
    xor edi, edi ; zero a "result so far"
top:
    movzx ebp, byte [esi] ; get a character
    inc esi ; ready for next one
    cmp ebp, '0' ; valid?
    jb done
    cmp ebp, '9'
    ja done
    sub ebp, '0' ; "convert" character to number
    imul edi, 10 ; multiply "result so far" by ten
    add edi, ebp ; add in current digit
    jmp top ; until done
done:
    ; Cierra el archivo
    mov eax, 6
    mov ebx, [idArchivo]
    int 0x80

    jmp salir

salir:
    mov eax,1
    mov ebx,0
    int 0x80