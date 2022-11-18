import serial

def enviar(modo,letra):
    try:
        ser = serial.Serial("com3",9600)
        if(modo == "Manual"):
            if(letra == "A"):
                ser.write(b'A')
            elif(letra == "B"):
                ser.write(b'B')
            elif(letra == "I"):
                ser.write(b'I')
            elif(letra == "D"):
                ser.write(b'D')
        elif(modo == "Automatico"):
            if(letra == "S"):
                ser.write(b'S')
            elif(letra == "E"):
                ser.write(b'E')
        if(letra == "C"):
            ser.close()


    except TimeoutError:
        print("error")
    finally:
        print("done")
