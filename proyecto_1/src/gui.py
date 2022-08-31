from asyncio.windows_events import NULL
from os import getcwd
import sys
from PyQt5 import uic, QtGui
from PyQt5.QtWidgets import QMainWindow, QApplication, QFileDialog
from PyQt5.QtGui import QImage, QPen, QPainter, QPixmap
from PyQt5.QtCore import Qt
import cv2
import imutils
import matplotlib.image as imread
import numpy as np
import os

class Ui_MainWindow(QMainWindow):

    def __init__(self):
        super().__init__()
        uic.loadUi("gui.ui", self)
        self.abrirBtn.clicked.connect(self.cargarImagen)
        self.cancelarBtn.clicked.connect(self.labelImgOrigin.clear)
        self.startBtn.clicked.connect(self.startProcess)
        self.actionOpen.triggered.connect(self.cargarImagen)
        self.actionExit.triggered.connect(self.salir)

    def cargarImagen(self):
        filename, _ = QFileDialog.getOpenFileName(self, "Seleccionar imagen",
                                                getcwd(), "Imagen (*.jpg *.png)", 
                                                options=QFileDialog.Options())
        self.image = cv2.imread(filename)
        matrix = imread.imread(filename)
        matrix = np.array2string(matrix, precision=2, separator=',',
                      suppress_small=False)
        file1 = open("MyFile.txt", "w")
        file1.write(matrix)
        file1.close() 
        self.setPhoto(self.image)

    def setPhoto(self, image):
        image = imutils.resize(image, width=390, height=390)
        frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgOrigin.setPixmap(QtGui.QPixmap.fromImage(image))
    
    def startProcess(self):
        quadrant = int(self.comboBox.currentText())

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

    def salir(self):
        sys.exit()

    # https://answers.opencv.org/question/173852/how-to-split-image-into-small-blocks-process-on-them-and-then-join-all-the-blocks-together-again/
    def divImage(self, row, col):
        img = self.image
  
        # cv2.imread() -> takes an image as an input
        h, w, _ = img.shape

        if not os.path.exists('patches'):
            os.makedirs('patches')
        
        roi = img[row*h//4:row*h//4 + h//4 ,col*w//4:col*w//4 + w//4]

        cv2.imwrite('patches/patch_'+str(row)+str(col)+".jpg", roi)   

        cv2.waitKey(0)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = Ui_MainWindow()
    gui.show()
    sys.exit(app.exec_())