import numpy as np
from PIL import Image as im

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

    out = np.zeros((289, 289), dtype=np.uint8)
    for i in range(289):
        for j in range(289):
            out[i][j] = matrix[i][j]
        
    print(out)
    data = im.fromarray(out)

    data.show()

def limpiarNum(elemento):
    final = elemento[-1]
    while(final == ' ' or final == '\n'):
        elemento = elemento[:-1]
        final = elemento[-1]

    return elemento


if __name__ == "__main__":
    abrirImg()