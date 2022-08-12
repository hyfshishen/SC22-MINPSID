import os, sys

inpFilePath = "input-list.txt"
fileOpen = open(inpFilePath, 'r')
fileCont = fileOpen.read().split('\n')[1:-1]
fileOpen.close()

for item in fileCont:
    genInp = item.replace("graph", '').replace(".txt", '')
    os.system("./GeneticEngine/fitness-function/graphgen " + genInp + ' ' + genInp)

os.system("mv ./graph*.txt ../../perInstFi/perInstFi-base/base/")
