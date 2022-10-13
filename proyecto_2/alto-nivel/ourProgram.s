
_start:
    JALI r0, 1806
    APR r1, r0 ; Apear de memoria mem[1806]
    JALI r0, 1
    CMP r0, r1 ; Verificar si iniciar algoritmo
    BCI algoritmo ; Brinco a algoritmo si es igual
    B _start

algoritmo:
    JALI r11, 32 ; offset1 = 32, Donde comienza el texto
    JALI r12, 1056 ; donde hay que guardar el texto desencriptado
    JALI r10, 100 ; iteraciones maximas
    JALI r9, 0 ; contador
    JALI r8, 2
    APR r8, r8 ; Apear mem[2] valor de d - y
    JALI r7, 8
    APR r7, r7 ; Apear mem[8] valor de n - p

RSA:
    APR r0, r11 ; Se obtiene la primera letra (carga 32 bits de un solo)
    JALI r1, 1 ; res
    MOD r0, r0, r7 ; x = x % p
    JALI r2, 0
    CMP r0, r2 ; if (x == 0)
    BCI guardarCero ; if (x == 0) return 0;

while:
    JALI r2, 0
    CMP r8, r2
    BCI returnRes

    JAL r3, r8
    JALI r2, 1
    AND r3, r2, r3
    CMP r3, r2 ; if ((y & 1) == 1) :
    JAL r13, r15 ; se guarda PC + 1
    BEQ actualizarRes

    DLD r8, r8, r2 ; y = y >> 1	 # y = y/2
    MUL r0, r0, r0 ; x= x* x
    MOD r0, r0, r7 ; x % p

    BI while

actualizarRes:
    MUL r1, r1, r0 ; res = res * x
    MOD r1, r1, r7 ; res = res % p
    BIR r13 ; Brinco incondicional a registro

guardarCero:
    JALI r0, 0
    ECH r12, r0 ; mem[offset r12] = r0 ECHAR
    SUM r9, r9, 1 ; actualiza contador
    SUM r11, r11, 1 ;  se actualiza el offset de la palabra a leer
    SUM r12, r12, 1 ; se actualiza el offset de donde escribir
    CMP r9, r10 ; se comparan las iteraciones maximas
    BCI salir ; si es igual se sale

    BI RSA

returnRes:
    ECH r12, r1 ; ECHAR mem[offset r12] = r1
    SUM r9, r9, 1 ; actualiza contador
    SUM r11, r11, 1 ;  se actualiza el offset de la palabra a leer
    SUM r12, r12, 1 ; se actualiza el offset de donde escribir
    CMP r9, r10 ; se comparan las iteraciones maximas
    BCI salir ; si es igual se sale
    BI RSA

salir:
    JALI r0, 1