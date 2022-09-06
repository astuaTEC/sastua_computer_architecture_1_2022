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

    strResult db "" ; string buffer to store results
    lenstr equ $-strResult

section .bss
idArchivo resd 1
contenido resb 50000 ; Almacenar n cantidad de bytes

idArchivoDest resd 1
contenidoDest resb 500

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
    cmp r8, 3 ; se compara el contador de filas
    jb loopCol ; si es menor, se imprime una nueva columna  
    jmp done  

updateRowCount:
    inc r8
    jmp loopFilas

loopCol:
    cmp r9, 3
    je updateRowCount

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

    ; Convertir a string el numero
    ; mov eax, [v1]    ; number to be converted
    ; mov edi, strResult
    ; call int_to_string
    ; mov r11, contenidoDest
    ; mov r12, [strResult]
    ; mov [r11], r12

    imul r11d, r8d, 3
    imul r12d, r9d, 3
    mov [row2], r11d ; row2 = row*3
    mov [col2], r12d ; col2 = col*3

validateRowColumn:
    cmp r8d, 0
    jne validateColumn1

    cmp r9d, 0
    jne validateColumn2

    ; arrayOut[row2][col2] = v1
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2] 
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [v1]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

validateColumn2:
    ; arrayOut[row2][col2+1] = a

    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    inc r12
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [a]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    ; arrayOut[row2][col2+2] = b

    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r12, 2
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [b]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    ; arrayOut[row2][col2+3] = v2

    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r12, 3
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    mov r14, r12 ; auxiliar para saber si hay salto de línea o no
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [v2]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

validateColumn1:
    cmp r9, 0
    jne continue

    mov r15, 10
    ;arrayOut[row2+1][col2] = c
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    inc r11
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [c]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    ;arrayOut[row2+2][col2] = g
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11, 2
    imul r11, 40 ; se obtiene la fila
    imul r12, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [g]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    ;arrayOut[row2+3][col2] = v3 
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11, 3
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [v3]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    mov r15, contenidoDest

continue:
; arrayOut[row2+1][col2+1] = d
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    inc r11d
    inc r12d
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [d]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+1][col2+2] = e
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    inc r11d
    add r12d, 2
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [e]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+1][col2+3] = f
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    inc r11d
    add r12d, 3
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    mov r14, r12 ; auxiliar para saber si hay salto de línea o no
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [f]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+2][col2+1] = h
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11d, 2
    inc r12d
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [h]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+2][col2+2] = i
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11d, 2
    add r12d, 2
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [i]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+2][col2+3] = j
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11, 2
    add r12, 3
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    mov r14, r12 ; auxiliar para saber si hay salto de línea o no
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [j]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+3][col2+1] = k
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11d, 3
    inc r12d
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [k]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+3][col2+2] = l
    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11d, 3
    add r12d, 2
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [l]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

; arrayOut[row2+3][col2+3] = v4

    mov r10, contenidoDest
    mov r11d, [row2]
    mov r12d, [col2]
    add r11, 3
    add r12, 3
    imul r11d, 40 ; se obtiene la fila
    imul r12d, 4 ; se obtiene la columna
    mov r14, r12 ; auxiliar para saber si hay salto de línea o no
    add r11, r12 ; se suma fila + columna
    add r10, r11 ; se suma a la posicion

    ; Convertir a string el numero
    mov eax, [v4]    ; number to be converted
    mov edi, strResult
    call int_to_string
    mov r11d, [strResult]

    mov dword[r10], r11d ; se guarda el resultado
    ; add r10, 3
    ; mov byte[r10], ' ' ; se agrega un espacio
    call verifyEndLine

    inc r9 
    jmp loopCol

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

; Input
; EAX = pointer to the int to convert
; EDI = address of the result
; Output:
; None
; https://stackoverflow.com/questions/13523530/printing-an-int-or-int-to-string
int_to_string:
    xor   ebx, ebx        ; clear the ebx, I will use as counter for stack pushes
push_chars:
    xor edx, edx          ; clear edx
    mov ecx, 10           ; ecx is divisor, devide by 10
    div ecx               ; devide edx by ecx, result in eax remainder in edx
    add edx, 0x30         ; add 0x30 to edx convert int => ascii
    push dx              ; push result to stack
    inc ebx               ; increment my stack push counter
    test eax, eax         ; is eax 0?
    jnz push_chars       ; if eax not 0 repeat

pop_chars:
    pop ax               ; pop result from stack into eax
    stosb                ; store contents of eax in at the address of num which is in EDI
    dec ebx               ; decrement my stack push counter
    cmp ebx, 0            ; check if stack push counter is 0
    jg pop_chars         ; not 0 repeat
    mov eax, 0x0
    stosb         ; add line feed
    ret                   ; return to main

verifyEndLine:
    cmp r14, 36
    je endLine
    add r10, 3
    mov byte[r10], ' ' ; se agrega un espacio
    ret

endLine:
    add r10, 3
    mov byte[r10], 10 ; se agrega un salto
    mov r14, 0
    ret

done:
    ;Cierra el archivo
    mov eax, 6
    mov ebx, [idArchivo]
    int 0x80

    ;abre otro archivo
    mov eax, 5
    mov ebx, archivoDest
    mov ecx, 002h
    int 0x80

    cmp eax, 0
    jl error

    mov dword[idArchivoDest], eax

    ; Imprimir mensaje de exito
    mov eax, 4
    mov ebx, 1
    mov ecx, msgExito
    mov edx, lonExito
    int 0x80

    mov eax, 4
    mov ebx, [idArchivoDest]
    mov ecx, contenidoDest
    mov edx, 400  
    int 0x80

    ;Cierra el archivo
    mov eax, 6
    mov ebx, [idArchivoDest]
    int 0x80

    jmp salir

salir:
    mov eax,1
    mov ebx,0
    int 0x80