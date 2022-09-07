import numpy as np
from PIL import Image as im

def interpolacionBilineal():
    file = open('image.txt', 'r')
    
    completeArray = file.readlines()
    array = []
    matrix = []
    for line in completeArray:
        arr = line.strip().split(' ')
        for ele in arr:
            array.append(int(ele))
        matrix.append(array)
        array = []

    out = np.zeros((289, 289), dtype=np.uint8)
    out = bilinearInterpolation(matrix, 97, 97, out)
      
    # show the shape of the array
    #print(out)
    #imageToMatrix(out)
    
    # creating image object of
    # above array
    data = im.fromarray(out)

    #data.show()
    return data.convert('RGB')


def bilinearInterpolation(matrixIn, widthIn, heightIn, arrayOut):
    
    for row1 in range(heightIn - 1): # filas
        for col1 in range(widthIn - 1): #columnas

            # Vertices de la submatriz 2x2
            v1 = matrixIn[row1][col1]
            v2 = matrixIn[row1][col1+1]
            v3 = matrixIn[row1+1][col1]
            v4 = matrixIn[row1+1][col1+1]

            a = int( 2/3*v1 + 1/3*v2 )
            b = int( 1/3*v1 + 2/3*v2 )
            c = int( 2/3*v1 + 1/3*v3 )
            g = int( 1/3*v1 + 2/3*v3 )
            k = int( 2/3*v3 + 1/3*v4 )
            l = int( 1/3*v3 + 2/3*v4 )
            f = int( 2/3*v2 + 1/3*v4 )
            j = int( 1/3*v2 + 2/3*v4 )

            d = int( 2/3*c + 1/3*f )
            e = int( 1/3*c + 2/3*f )
            h = int( 2/3*g + 1/3*k )
            i = int( 1/3*g + 2/3*k )

            row2 = row1*3
            col2 = col1*3

            if row1 == 0:
                if col1 == 0:
                    arrayOut[row2][col2] = v1
                arrayOut[row2][col2+1] = a
                arrayOut[row2][col2+2] = b
                arrayOut[row2][col2+3] = v2

            if col1 == 0:
                arrayOut[row2+1][col2] = c
                arrayOut[row2+2][col2] = g
                arrayOut[row2+3][col2] = v3    
            
            arrayOut[row2+1][col2+1] = d
            arrayOut[row2+1][col2+2] = e
            arrayOut[row2+1][col2+3] = f
            arrayOut[row2+2][col2+1] = h
            arrayOut[row2+2][col2+2] = i
            arrayOut[row2+2][col2+3] = j

            arrayOut[row2+3][col2+1] = k
            arrayOut[row2+3][col2+2] = l
            arrayOut[row2+3][col2+3] = v4

    return arrayOut

def imageToMatrix(img):

        newArray = []
        open('result.txt', 'w').close() # clear the file
        file = open("result.txt", "a")
        for i in range (289): #traverses through height of the image
            if i != 0 : file.write("\n")
            for j in range (289): #traverses through width of the image
                newArray.append(img[i][j])
                if j == img.shape[1] - 1:
                    file.write( "{0:0=3d}".format( img[i][j] ))
                else:
                    file.write("{0:0=3d}".format( img[i][j])  + " ")

        file.close()


if __name__ == '__main__':
    interpolacionBilineal()

