targetFile = "mem3.txt"
resultFile = "result.txt"

def readFile():
    with open(targetFile) as file:
        content = file.readlines()
    return content

def writeFile(content):
    count = 0
    with open(resultFile, 'w') as file:
        while(count<len(content)):
            var = chr(int(content[count][:8], 2))
            file.write(var)
            count+=1

writeFile(readFile())
    
