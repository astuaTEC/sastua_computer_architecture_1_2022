
def abrirImg():
    file = open('./asm/destino.txt', 'r')
    
    completeArray = file.readlines()
    completeArray.pop()
    #print(completeArray)
    array = []
    matrix = []
    for line in completeArray:
        arr = line[:-1].split(';')
        for ele in arr:
            e = limpiarNum(ele)
            array.append(int(e))
        matrix.append(array)
        array = []

    #data = im.fromarray(out)

    #data.show()

def limpiarNum(elemento):
    final = elemento[-1]
    while(final == ' ' or final == '\n'):
        elemento = elemento[:-1]
        final = elemento[-1]

    return elemento


if __name__ == "__main__":
    abrirImg()