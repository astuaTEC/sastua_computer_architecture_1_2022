import serial

def enviar(modo,letra):
    try:
        ser = serial.Serial("com15",9600, timeout=1)
        if(modo == "Manual"):
            if(letra == "1"):
                ser.write(b'1')
            elif(letra == "A"):
                ser.write(b'A')
            elif(letra == "B"):
                ser.write(b'B')
            elif(letra == "I"):
                ser.write(b'I')
            elif(letra == "D"):
                ser.write(b'D')
        elif(modo == "Automatico"):
            if(letra == "2"):
                ser.write(b'2')
            elif(letra == "S"):
                ser.write(b'S')
            elif(letra == "E"):
                ser.write(b'E')
        if(letra == "C"):
            ser.write(b'S')
            ser.close()


    except TimeoutError:
        print("error")
    finally:
        print("done")
