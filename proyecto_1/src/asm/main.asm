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

    strResult db 16 dup (0) ; string buffer to store results

section .bss
idArchivo resd 1
contenido resb 50000 ; Almacenar n cantidad de bytes

idArchivoDest resd 1
contenidoDest resb 50000

a resd 1
b resd 1
c resd 1
d resd 1
e resd 1
f resd 1
g resd 1
h resd 1
i resd 1
j resd 1
k resd 1
l resd 1

v1 resd 1
v2 resd 1
v3 resd 1
v4 resd 1

row2 resd 1
col2 resd 1

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

    mov r8, 0 ;contador de filas


loopFilas:
    mov r9, 0 ; se limpia el contador de columnas
    cmp r8, 97 ; se compara el contador de filas
    jb loopCol ; si es menor, se imprime una nueva columna    

loopCol:

getV1:
    mov r10, contenido
    imul r11, r8, 16 ; se obtiene la fila
    imul r12, r9, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    mov rsi, r10
    call atoi 
    mov [v1], edi

getV2:
    mov r10, contenido
    imul r11, r8, 16 ; se obtiene la fila
    mov r12, r9
    inc r12 ; col + 1
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion
    
    mov rsi, r10 
    call atoi
    mov [v2], edi
    
getV3:
    mov r10, contenido
    mov r11, r8
    inc r11; row + 1
    imul r11, 16 ; se obtiene la fila
    imul r12, r8, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    mov rsi, r10 
    call atoi

    mov [v3], edi

getV4:
    mov r10, contenido
    mov r11, r8
    inc r11 ; row + 1
    imul r11, 16 ; se obtiene la fila
    mov r12, r9
    inc r12 ; col + 1
    imul r12, 4 ; se obtiene la columna
    
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    mov rsi, r10 
    call atoi

    mov [v4], edi

getA:
    imul r10d, [v1], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [v2]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [a], r10d

getB:
    mov r10d, [v1]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [v2], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [b], r10d

getC:
    imul r10d, [v1], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [v3]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [c], r10d

getG:
    mov r10d, [v1]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [v3], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [g], r10d

getK:
    imul r10d, [v3], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [v4]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [k], r10d

getL:
    mov r10d, [v3]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [v4], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [l], r10d

getF:
    imul r10d, [v2], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [v4]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [f], r10d

getJ:
    mov r10d, [v2]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [v4], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [j], r10d

getD:
    imul r10d, [c], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [f]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [d], r10d

getE:
    mov r10d, [c]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [f], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [e], r10d

getH:
    imul r10d, [g], 2
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    mov r11d, [k]
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [h], r10d

getI:
    mov r10d, [g]
    mov rdx, 0
    mov eax, r10d
    mov ebx, 3

    div ebx
    mov r10d, eax

    imul r11d, [k], 2
    mov rdx, 0
    mov eax, r11d
    mov ebx, 3

    div ebx
    mov r11d, eax

    add r10d, r11d

    mov [i], r10d

    mov eax, [v1]    ; number to be converted
    call int_to_string

    jmp done

    imul r11, r8, 3
    imul r12, r9, 3
    mov [row2], r11d ; row2 = row*3
    mov [col2], r12d ; col2 = col*3

validateRowColumn:
    cmp r8, 0
    jne validateColumn1

    cmp r9, 0
    jne validateColumn2
    ; arrayOut[row2][col2] = v1

validateColumn2:
    ; arrayOut[row2][col2+1] = a
    ; arrayOut[row2][col2+2] = b
    ; arrayOut[row2][col2+3] = v2

validateColumn1:
    cmp r9, 0
    jne continue

continue:
; arrayOut[row2+1][col2+1] = d
; arrayOut[row2+1][col2+2] = e
; arrayOut[row2+1][col2+3] = f
; arrayOut[row2+2][col2+1] = h
; arrayOut[row2+2][col2+2] = i
; arrayOut[row2+2][col2+3] = j

; arrayOut[row2+3][col2+1] = k
; arrayOut[row2+3][col2+2] = l
; arrayOut[row2+3][col2+3] = v4

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
    movzx ebp, byte [rsi] ; get a character
    inc rsi ; ready for next one
    cmp ebp, '0' ; valid?
    jb done_m
    cmp ebp, '9'
    ja done_m
    sub ebp, '0' ; "convert" character to number
    imul edi, 10 ; multiply "result so far" by ten
    add edi, ebp ; add in current digit
    jmp top ; until done
done_m:
    ret

int_to_string:
    mov ecx, 10         ; divisor
    xor bx, bx          ; count digits

divide:
    xor edx, edx        ; high part = 0
    div ecx             ; eax = edx:eax/ecx, edx = remainder
    push rdx             ; DL is a digit in range [0..9]
    inc bx              ; count digits
    test eax, eax       ; EAX is 0?
    jnz divide          ; no, continue

    ; POP digits from stack in reverse order
    mov cx, bx          ; number of digits
    lea esi, strResult   ; DS:SI points to string buffer

next_digit:
    pop ax
    add ax, '0'         ; convert to ASCII
    mov [esi], ax        ; write it to the buffer
    inc si
    loop next_digit
    ret

done:
    ;Cierra el archivo
    mov eax, 6
    mov ebx, [idArchivo]
    int 0x80

    jmp salir

salir:
    mov eax,1
    mov ebx,0
    int 0x80