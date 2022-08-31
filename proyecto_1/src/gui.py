from email.mime import image
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
        pixmap = QPixmap(self.labelImgOrigin.size())
        qp = QPainter(pixmap)
        pen = QPen(Qt.red, 3)
        qp.setPen(pen)
        qp.drawLine(10, 10, 50, 50)
        qp.end()
        #self.labelImgOrigin.setPixmap(pixmap)

    def setPhoto(self, image):
        image = imutils.resize(image, width=390, height=390)
        frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.labelImgOrigin.setPixmap(QtGui.QPixmap.fromImage(image))
        self.divImage()

    def salir(self):
        sys.exit()

    def divImage(self):
        img = self.image
  
        # cv2.imread() -> takes an image as an input
        h, w, channels = img.shape

        if not os.path.exists('patches'):
            os.makedirs('patches')

        for i in range(0, 4):
            for j in range(0, 4):
                roi = img[i*h//4:i*h//4 + h//4 ,j*w//4:j*w//4 + w//4]
                #cv2.imshow('rois'+str(i)+str(j), roi)
                cv2.imwrite('patches/patch_'+str(i)+str(j)+".jpg", roi)
                

        cv2.waitKey(0)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = Ui_MainWindow()
    gui.show()
    sys.exit(app.exec_())