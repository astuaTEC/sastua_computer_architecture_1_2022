import numpy as np
from PIL import Image as im

def abrirImg():
    file = open('./asm/destino.img', 'r')
    
    completeArray = file.readlines()
    array = []
    matrix = []
    for line in completeArray:
        arr = line[:-1].split(';')
        for ele in arr:
            e = limpiarNum(ele)
            array.append(int(e))
        matrix.append(array)
        array = []

    out = np.array(matrix, dtype=np.uint8)
        
    #print(out)
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