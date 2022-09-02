import os
import sys
from asyncio import sleep
from asyncio.windows_events import NULL
from email.mime import image
from os import getcwd

import cv2
import numpy as np
from PyQt5 import QtGui, uic
from PyQt5.QtGui import QImage
from PyQt5.QtWidgets import (QApplication, QErrorMessage, QFileDialog,
                             QMainWindow)

from interBilinial import *

class Ui_MainWindow(QMainWindow):

    image = np.ndarray(shape=(0, 0))
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
    
    def limpiar(self):
        self.labelImgOrigin.clear()
        self.labelImgDest.clear()
        self.image = np.ndarray(shape=(0, 0))

    def cargarImagen(self):
        filename, _ = QFileDialog.getOpenFileName(self, "Seleccionar imagen",
                                                getcwd(), "Imagen (*.jpg *.png)", 
                                                options=QFileDialog.Options())
        self.image = cv2.imread(filename, 0)
        if self.image.shape != (390, 390):
            error_dialog = QErrorMessage(self)
            error_dialog.showMessage('Por favor seleccione una imagen 390x390')
            self.image = np.ndarray(shape=(0, 0))
        else:
            self.setPhoto(self.image)

    def setPhoto(self, image):
        frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgOrigin.setPixmap(QtGui.QPixmap.fromImage(image))
    
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

    
    # https://answers.opencv.org/question/173852/how-to-split-image-into-small-blocks-process-on-them-and-then-join-all-the-blocks-together-again/
    def divImage(self, row, col):
        img = self.image
        
        h, w = img.shape

        if not os.path.exists('patches'):
            os.makedirs('patches')
        
        roi = img[row*h//4 : row*h//4 + h//4, col*w//4 : col*w//4 + w//4]

        newFilename = 'patches/patch_' + str(row) + str(col) + ".jpg"

        cv2.imwrite(newFilename, roi)   
        cv2.waitKey(0)

        self.imageToMatrix(roi)

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
                    file.write(str(img[i][j]))
                else:
                    file.write(str(img[i][j]) + ", ")

        file.close()

        frame = interpolacionBilineal()
        frame = np.array(frame)
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgDest.setPixmap(QtGui.QPixmap.fromImage(image))
        

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = Ui_MainWindow()
    gui.show()
    sys.exit(app.exec_())
