# RSA Algorithm

from hashlib import new
from modularExponentiation import *

# Function from https://www.delftstack.com/howto/python/convert-string-to-ascii-python/
def text2ascii(text):
    ascii_values = []
    for character in text:
        ascii_values.append(ord(character))
    
    return ascii_values

# Function from https://stackoverflow.com/questions/180606/how-do-i-convert-a-list-of-ascii-values-to-a-string-in-python
def ascii2string(asciiList):
    mystring = ""
    for char in asciiList:
        mystring += chr(char)
    return mystring

def readFile(path):
    with open(path, 'r') as f:
        lines = f.readlines()
        string = ''
        for e in lines:
            string += e
        return string

def writeFile(path, text):
    with open(path, 'w') as f:
        f.write(text)

def encrypt(asciiList, e, n):
    newList = []
    for element in asciiList:
        c = power(element, e, n)
        newList.append(c)

    return newList

def decrypt(encryptedtList, d, n):
    newList = []
    for element in encryptedtList:
        m = power(element, d, n)
        newList.append(m)
    
    return newList

if __name__ == "__main__":
    e = 4399
    d = 439
    n = 4757
    # Reads the input file
    string = readFile("textoEntrada.txt")
    # Convert to ascii array
    asciiList = text2ascii(string)
    # Obtain the encrypted text
    encryptedList = encrypt(asciiList, e, n)
    # Write the encrypted text into a file
    writeFile("textoEncriptado.txt", str(encryptedList))

    # decrypt the encrypted message with the private key
    decryptedList = decrypt(encryptedList, d, n)
    # Convert the result into a string
    decryptedString = ascii2string(decryptedList)
    # Write the result into a file
    writeFile("textoDesencriptado.txt", decryptedString)

