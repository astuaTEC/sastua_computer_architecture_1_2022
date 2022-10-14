import sys
import re

### Se definen los registros
REGISTERS = {
    "r0": 0,
    "r1": 1,
    "r2": 2,
    "r3": 3,
    "r4": 4,
    "r5": 5,
    "r6": 6,
    "r7": 7,
    "r8": 8,
    "r9": 9,
    "r10": 10,
    "r11": 11,
    "r12": 12,
    "r13": 13,
    "r14": 14,
    "r15": 15
}

### Se define las intruciones
INSTRUCIONES = {
    "ECH":	{"OP": 1, "category": "STW"},  # Guardar palabra
    "JALI":	{"OP": 2, "category": "MOVI"},  # Mover inmediato
    "JAL":	{"OP": 3, "category": "MOV"},  # Mover
    "OUT":	{"OP": 4, "category": "OUT"},   # ???
    "SUM":	{"OP": 5, "category": "ART"},  # Suma
    "MOD":	{"OP": 6, "category": "ART"},  # Resta
    "APR":	{"OP": 7, "category": "LDW"},  # Cargar palabra
    "AND":	{"OP": 8, "category": "ART"},  # O bit a bit
    "DLD":	{"OP": 9, "category": "ART"},  # Desplazamiento lateral izquierda
    "CMP":	{"OP": 10, "category": "CMP"},  # Comparar
    "BCI":	{"OP": 11, "category": "BI"},  # Salto si igual que a Label
    "BIR":	{"OP": 12, "category": "BR"},  # Salto a registro incondicional
    "BCM":	{"OP": 13, "category": "BI"},  # Salto si menor que a Label
    "MUL":	{"OP": 14, "category": "ART"},  # Multiplicacion
    "BI":	{"OP": 15, "category": "BI"},  # Salto a Label incondicional

}


# Encuentra las etiquetas usando el carácter ":", asigna el nombre de la rama a la línea de instrucción
# y elimina la rama del texto para tener sólo intrusiones para compilar.
# El diccionario del nombre de la rama y el número de la instrucción se utiliza para las futuras instrucciones de las ramas como un inmediato
def BuscarBrincos(text):
    brincos = {}
    i = 0
    while i < len(text):
        if (":" in text[i]):
            brincos[text[i][:-1]] = i
            text.pop(i)
        i += 1
    return brincos


#Acooda el codigo de manera tal que se eliminan los epaciones en blanco y las tabulaciones
#Para el el preoceso de compilacion sea mas sencillo
def AcomodoDeTexto(text):
    codigoO = []
    for l in text.split("\n"):
        line = l.split(";")[0]
        line = line.replace("\t", " ")
        line = line.strip()
        if (line == ""):
            continue
        codigoO += [re.sub(' +', ' ', line)]

    return codigoO

def generadorB(valorBinario, BRANCHES):

    for (i, l) in enumerate(text):
        instr = l.split(" ")[0]
        params = "".join(l.split(" ")[1:]).split(",")
        if(not INSTRUCIONES.get(instr)):
            raise Exception("OP NOT RECOGNIZED LINE ({}) '{}'".format(i, l))

        result = "Instrucción actual: {1}OP{0}({0:04b})".format(
            INSTRUCIONES[instr]["OP"], l.ljust(28, "_"))

# Separa las intrucines por tipo
        category = INSTRUCIONES[instr]["category"]
        if (category == "ART"):
            for r in params:
                result += "R{0}({0:04b})".format(REGISTERS[r])
        elif (category == "BI"):
            result += "I{0}('0000'{0:016b})".format(int(BRANCHES[params[0]]))
        elif (category == "BR"):
            result += "R{0}('0000'{0:04b})".format(REGISTERS[params[0]])
        elif (category == "LDW"):
            for r in params:
                result += "R{0}({0:04b})".format(REGISTERS[r])
        elif (category == "STW"):
            result += "('0000')"
            for r in params:
                result += "R{0}({0:04b})".format(REGISTERS[r])
        elif (category == "MOVI"):
            result += "R{0}({0:04b})".format(REGISTERS[params[0]])
            result += "I{0}({0:016b})".format(int(params[1]))   
        elif (category == "CMP"):
            result += "('0000')"
            for r in params:
                result += "R{0}({0:04b})".format(REGISTERS[r])
        elif (category == "OUT"):
            result += "('0000')"
            result += "R{0}({0:04b})".format(REGISTERS[params[0]])
        elif (category == "MOV"):
            for r in params:
                result += "R{0}({0:04b})".format(REGISTERS[r])

        print(result)
        valorBinario += result + "\n"
    
    return valorBinario

# Se obtiene los bits dentro de la compilacion 
def obtencionDeBits(binResult):
    final = []
    i = 0
    while (i < len(binResult)):
        if (binResult[i] == "("):
            i += 1
            while (binResult[i] != ")"):
                if (binResult[i] == "1" or binResult[i] == "0"):
                    final.append(binResult[i])
                i += 1
        if (binResult[i] == "\n"):
            final.append("\n")
        i += 1
    final = "".join(final)
    final = final.split("\n")
    final = [x.ljust(24, "0") for x in final]

    outFile = open("instruction-file.txt", "w")
    outFile.write("\n".join(final))
    print("¡Compilado correctamente!")


if __name__ == "__main__":
    file = open("ourProgram.s")
    text = file.read()
    text = AcomodoDeTexto(text)
    BRINCOS = BuscarBrincos(text)
    binResult = ""
    binResult = generadorB(binResult, BRINCOS)
    obtencionDeBits(binResult)