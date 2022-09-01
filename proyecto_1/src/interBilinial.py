from array import array
import os
from unittest import result

def interpolacionBilineal():
    print("XD")
    file = open('image.txt', 'r')
    
    completeArray = file.readlines()
    array = []
    matrix = []
    for line in completeArray:
        arr = line.strip().split(', ')
        for ele in arr:
            ele = ele.split(',')[0]
            array.append(int(ele))
        matrix.append(array)
        array = []

    file.close()
    result = [
        x[0:2]
        for x in matrix[4:6]
    ]
    #print(result)

    print( interpolacionBilinealAux(result) )

def interpolacionBilinealAux(matrix2x2):
    a = int( 2/3*matrix2x2[0][0] + 1/3*matrix2x2[0][1] )
    b = int( 1/3*matrix2x2[0][0] + 2/3*matrix2x2[0][1] )
    c = int( 2/3*matrix2x2[0][0] + 1/3*matrix2x2[1][0] )
    g = int( 1/3*matrix2x2[0][0] + 2/3*matrix2x2[1][0] )
    k = int( 2/3*matrix2x2[1][0] + 1/3*matrix2x2[1][1] )
    l = int( 1/3*matrix2x2[1][0] + 2/3*matrix2x2[1][1] )
    f = int( 2/3*matrix2x2[0][1] + 1/3*matrix2x2[1][1] )
    j = int( 1/3*matrix2x2[0][1] + 2/3*matrix2x2[1][1] )

    d = int( 2/3*c + 1/3*f )
    e = int( 1/3*c + 2/3*f )
    h = int( 2/3*g + 1/3*k )
    i = int( 1/3*g + 2/3*k )

    matrix = [
        [matrix2x2[0][0], a, b, matrix2x2[0][1]],
        [c, d, e, f],
        [g, h, i, j],
        [matrix2x2[1][0], k, l, matrix2x2[1][1]]
    ]

    return matrix

if __name__ == '__main__':
    interpolacionBilineal()