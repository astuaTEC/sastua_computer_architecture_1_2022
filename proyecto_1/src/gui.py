import os
import subprocess
import sys
from os import getcwd

import cv2
import numpy as np
from PyQt5 import QtGui, uic
from PyQt5.QtGui import QImage
from PyQt5.QtWidgets import (QApplication, QErrorMessage, QFileDialog,
                             QMainWindow)


"""
    Clase que maneja la ventana principal del programa
"""
class Ui_MainWindow(QMainWindow):

    image = np.ndarray(shape=(0, 0)) #imagen vacía
    def __init__(self):
        super().__init__()
        uic.loadUi("gui.ui", self)
        self.abrirBtn.clicked.connect(self.cargarImagen)
        self.limpiarBtn.clicked.connect(self.limpiar)
        self.startBtn.clicked.connect(self.startProcess)
        self.actionOpen.triggered.connect(self.cargarImagen)
        self.actionExit.triggered.connect(self.salir)

    def salir(self):
        sys.exit()
    
    # Método que limpia los label donde pueden haber imágenes
    def limpiar(self):
        self.labelImgOrigin.clear()
        self.labelImgDest.clear()
        self.image = np.ndarray(shape=(0, 0))

    # Método para cargar una imagen desde la computadora
    def cargarImagen(self):
        filename, _ = QFileDialog.getOpenFileName(self, "Seleccionar imagen",
                                                getcwd(), "Imagen (*.jpg *.png)", 
                                                options=QFileDialog.Options())
        self.image = cv2.imread(filename, 0) #Se extrae solo en escala de grises
        if self.image.shape != (390, 390):
            error_dialog = QErrorMessage(self)
            error_dialog.showMessage('Por favor seleccione una imagen 390x390')
            self.image = np.ndarray(shape=(0, 0))
        else:
            self.setPhoto(self.image)

    # Método para colocar la imagen seleccionana en un label
    def setPhoto(self, image):
        frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgOrigin.setPixmap(QtGui.QPixmap.fromImage(image))
    
    # Método para iniciar la interpolación bilineal
    # Este método llama a la función para tomar
    # el trozo de imagen según el cuadrante seleccionado
    def startProcess(self):
        quadrant = int(self.comboBox.currentText())

        if self.image.shape != (0, 0):
            if quadrant == 1:  # Row 1
                print('0, 0')
                self.divImage(0, 0)
            elif quadrant == 2:
                print('0, 1')
                self.divImage(0, 1)
            elif quadrant == 3:
                print('0, 2')
                self.divImage(0, 2)
            elif quadrant == 4:
                print('0, 3')
                self.divImage(0, 3)
            elif quadrant == 5: # Row 2
                print('1, 0')
                self.divImage(1, 0)
            elif quadrant == 6:
                print('1, 1')
                self.divImage(1, 1)
            elif quadrant == 7:
                print('1, 2')
                self.divImage(1, 2)
            elif quadrant == 8:
                print('1, 3')
                self.divImage(1, 3)
            elif quadrant == 9: # Row 3
                print('2, 0')
                self.divImage(2, 0)
            elif quadrant == 10:
                print('2, 1')
                self.divImage(2, 1)
            elif quadrant == 11:
                print('2, 2')
                self.divImage(2, 2)
            elif quadrant == 12:
                print('2, 3')
                self.divImage(2, 3)
            elif quadrant == 13: # Row 4
                print('3, 0')
                self.divImage(3, 0)
            elif quadrant == 14:
                print('3, 1')
                self.divImage(3, 1)
            elif quadrant == 15:
                print('3, 2')
                self.divImage(3, 2)
            elif quadrant == 16:
                print('3, 3')
                self.divImage(3, 3)

    # Método para dividir una imagen según la fila y columna seleccionada
    # Este método manda a llamar otra función para guardar la imagen en un archivo txt
    # https://answers.opencv.org/question/173852/how-to-split-image-into-small-blocks-process-on-them-and-then-join-all-the-blocks-together-again/
    def divImage(self, row, col):
        img = self.image
        
        h, w = img.shape

        if not os.path.exists('patches'):
            os.makedirs('patches')
        
        roi = img[row*h//4 : row*h//4 + h//4, col*w//4 : col*w//4 + w//4]

        # newFilename = 'patches/patch_' + str(row) + str(col) + ".jpg"

        # cv2.imwrite(newFilename, roi)   
        # cv2.waitKey(0)

        self.imageToMatrix(roi)

    # Método para convertir el cuadrante seleccionado en una matriz de valores
    # entre [0 - 255] y guardarla en un txt con cierto formato
    # https://stackoverflow.com/questions/33388534/how-to-get-grayscale-image-pixel-matrix-values-within-the-0-255-range-python
    def imageToMatrix(self, img):

        newArray = []
        open('image.txt', 'w').close() # clear the file
        file = open("image.txt", "a")
        for i in range (img.shape[0]): #traverses through height of the image
            if i != 0 : file.write("\n")
            for j in range (img.shape[1]): #traverses through width of the image
                newArray.append(img[i][j])
                if j == img.shape[1] - 1:
                    file.write( "{0:0=3d}".format( img[i][j] ))
                else:
                    file.write("{0:0=3d}".format( img[i][j])  + " ")

        file.close()
        subprocess.run('./asm/main') # Se llama al algoritmo implementado en ensamblador x86
        self.readImageAsm() # se llama el método para leer el resultado
    
    # Método para leer el archivo que contiene el resultado
    # del algoritmo de interpolación bilineal hecho en ensamblador
    # Adicionalmente este método coloca la imagen interpolada en
    # el label correspondiente
    def readImageAsm(self):
        file = open('destino.img', 'r')
    
        completeArray = file.readlines()
        array = []
        matrix = []
        for line in completeArray:
            arr = line[:-1].split(';')
            for ele in arr:
                e = self.limpiarNum(ele)
                array.append(int(e))
            matrix.append(array)
            array = []

        out = np.array(matrix, dtype=np.uint8)
            
        #print(out)
        frame = cv2.cvtColor(out, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgDest.setPixmap(QtGui.QPixmap.fromImage(image))

    # Método auxiliar para limpiar caracteres indeseados
    # dentro de un string dado (elemento)
    def limpiarNum(self, elemento):
        final = elemento[-1]
        while(final == ' ' or final == '\n'):
            elemento = elemento[:-1]
            final = elemento[-1]

        return elemento


if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = Ui_MainWindow()
    gui.show()
    sys.exit(app.exec_())
