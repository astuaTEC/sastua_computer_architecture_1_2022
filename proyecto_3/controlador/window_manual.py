from tkinter import *
import tkinter

def manualWindow(window): 
      
    
    
    manualWind = Toplevel(window) 
  
    window.withdraw()
    
    #Config
    manualWind.title("Modo Manual") 
    manualWind.geometry("500x500")
    #Fondo

    bd_img2= PhotoImage(file="resources/fondo_manual.png")
    Label(manualWind, image = bd_img2).place(x=0,y=0)

    #imagenes
    adelant_button = PhotoImage(file = "resources/adelante.png")
    atras_button = PhotoImage(file="resources/atras.png")
    izq_button = PhotoImage(file="resources/izq.png")
    derec_button = PhotoImage(file="resources/derec.png")
    cerrar_button = PhotoImage(file="resources/cerrar.png")

    #Botones
    button_adelat = Button(manualWind, image=adelant_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=187, y=193)
    button_atras = Button(manualWind, image=atras_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=210, y=396)
    button_izq = Button(manualWind, image=izq_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=38, y=296)
    button_derec = Button(manualWind, image=derec_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black').place(x=346, y=296)
    button_cer = Button(manualWind, image=cerrar_button,  highlightbackground = "black", highlightthickness = 2, bd=0, bg='black',command=lambda:close(window,manualWind)).place(x=449, y=471)


    manualWind.mainloop()

def close(window, manuWind):
        manuWind.destroy()
        window.deiconify()
