from os import getcwd
import sys
from PyQt5 import uic, QtGui
from PyQt5.QtWidgets import QMainWindow, QApplication, QFileDialog
from PyQt5.QtGui import QImage
import cv2
import imutils

class Ui_MainWindow(QMainWindow):

    def __init__(self):
        super().__init__()
        uic.loadUi("gui.ui", self)
        self.abrirBtn.clicked.connect(self.cargarImagen)
        self.cancelarBtn.clicked.connect(self.label.clear)
        self.actionOpen.triggered.connect(self.cargarImagen)
        self.actionExit.triggered.connect(self.salir)

    def cargarImagen(self):
        filename, _ = QFileDialog.getOpenFileName(self, "Seleccionar imagen",
                                                getcwd(),
                                                "Imagen (*.jpg *.png)", options=QFileDialog.Options())
        self.image = cv2.imread(filename)
        self.setPhoto(self.image)

    def setPhoto(self, image):
        image = imutils.resize(image, width=390, height=390)
        frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = QImage(frame, frame.shape[1], frame.shape[0], frame.strides[0], QImage.Format_RGB888)
        self.label.setPixmap(QtGui.QPixmap.fromImage(image))

    def salir(self):
        sys.exit()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = Ui_MainWindow()
    gui.show()
    sys.exit(app.exec_())