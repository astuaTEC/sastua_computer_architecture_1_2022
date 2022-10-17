.global _start
_start:
	MOV r0, #1806
	LDR r1, [r0] // acceder al switch
	MOV r0, #1
	CMP r0, r1
	BEQ algoritmo
	
	B _start
	
algoritmo:
	MOV r11, #32     // offset1 = 32, Donde comienza el texto
    MOV r12, #1056   // donde hay que guardar el texto
	MOV r10, #100 // iteraciones maximas
	MOV r9, #0 // contador
	MOV r8, #2
	LDR r8, [r8] // se carga el valor de d - y
	MOV r7, #8
	LDR r7, [r7] // se carga el valor de n - p
	

RSA:
	LDR r0, [r11] // Se obtiene la primera letra (carga 32 bits de un solo)
	MOV r1, #1 // res
	MOV r0, r0 MOD r7// x = x % p
	MOV r2, #0
	CMP r1, r2
	BEQ guardarCero // if (x == 0) return 0;
	
while:
	MOV r2, #0
	CMP r8, r2
	BEQ returnRes
	
	MOV r3, r8
	AND r3, r3, #1
	MOV r4, #1
	CMP r3, r4 // if ((y & 1) == 1) :
	MOV r13, r15 // se guarda el pc+1
	BEQ actualizarRes // res = (res * x) % p
	
	LSR r8, r8, #1 // y = y >> 1	 # y = y/2
	MUL r0, r0, r0 // (x * x)
	MOV r0, r0 MOD r7 // x % p
	
	B while


actualizarRes:
	MUL r1, r1, r0
	MOV r1, r1 MOD r7
	BLX r13
	
guardarCero:
	MOV r0, #0
	STR r0, [r12] // se guarda un cero
	ADD r9, #1 // actualiza contador
	ADD r11, #1 // se actualiza el offset de la palabra a leer
	ADD r12, #1 // se actualiza el offset de donde escribir
	CMP r9, r10 // se comparan las iteraciones maximas
	BNE RSA
	B salir
	
returnRes:
	STR r1, [r12] // se guarda un res
	ADD r9, #1 // actualiza contador
	ADD r11, #1 // se actualiza el offset de la palabra a leer
	ADD r12, #1 // se actualiza el offset de donde escribir
	CMP r9, r10 // se comparan las iteraciones maximas
	BNE RSA
	
salir:
	MOV r0, #0