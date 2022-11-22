from tkinter import *
import tkinter
from window_auto import autoWindow
from window_manual import manualWindow
from arduino_connection import enviar


def mWindow(window):
    enviar("Manual", "1")
    manualWindow(window)

def aWindow(window):
    enviar("Automatico","2")
    autoWindow(window)

window1 = Tk() 
window1.title("TA-Limpio Controller")
window1.geometry("500x500")
img = PhotoImage(file='resources/icono.png')
window1.call('wm', 'iconphoto', window1._w, img)



#Imagenes
bd_img= PhotoImage(file="resources/fondo1.png")
manual_button = PhotoImage(file = "resources/manual.png")
auto_button= PhotoImage(file="resources/automatico.png")


#Imagen de fondo
bd_f = Label(window1, image = bd_img).place(x=0,y=0)

#Botones
button_m = Button(window1, image=manual_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black',command=lambda:mWindow(window1)).place(x=190, y=330)
button_a = Button(window1,  highlightbackground = "black", highlightthickness = 2, bd=0, image=auto_button, bg='black',command=lambda:aWindow(window1)).place(x=164, y=390)


window1.mainloop()


