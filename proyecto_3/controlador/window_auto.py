from tkinter import *
import tkinter

def autoWindow(window): 

    autoWind = Toplevel(window) 
  
    window.withdraw()
    
    #Config
    autoWind.title("Modo Automatico") 
    autoWind.geometry("300x300")
    #Fondo

    bd_img2= PhotoImage(file="resources/fondo_auto.png")
    Label(autoWind, image = bd_img2).place(x=0,y=0)

    #imagenes
    inicio_button = PhotoImage(file = "resources/iniciar.png")
    detener_button = PhotoImage(file="resources/detener.png")
    cerrar_button = PhotoImage(file="resources/cerrar.png")

    #Botones
    button_ini = Button(autoWind, image=inicio_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=103, y=145)
    button_det = Button(autoWind, image=detener_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=96, y=203)
    button_cer = Button(autoWind, image=cerrar_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black',command=lambda:close(window,autoWind)).place(x=253, y=271)

    autoWind.mainloop()

def close(window, autoWind):
        autoWind.destroy()
        window.deiconify()
