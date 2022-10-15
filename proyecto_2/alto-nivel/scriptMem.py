
def readFile(path):
    with open(path, 'r') as f:
        line = f.readline()
        res = line.split(" ")
        
        return res

def formatNumIfDecimal(list):
    newList = []
    for e in list:
        newList.append( "{0:016b}".format( int(e) )) 

    return newList

def formatNumIfBinary(list):
    newList = []
    for e in list:
        newList.append( e ) 

    return newList

def writeFile(list):
    formatList = formatNumIfBinary(list)
    file = open("mem2.txt", "w")
    # Writing data to a file
    for e in formatList:
        file.write(e)
        file.write("\n")

    file.close()

if __name__ == "__main__":
    myList = readFile("textoEncriptadoProfe2.txt")
    writeFile(myList)