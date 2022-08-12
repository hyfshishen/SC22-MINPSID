import os, sys

inpFilePath = "input-list.txt"
fileOpen = open(inpFilePath, 'r')
fileCont = fileOpen.read().split('\n')[1:-1]
fileOpen.close()

for item in fileCont:
    genInp = item.split(' ')[1].replace("_34f.txt", '')
    os.system("./GeneticEngine/fitness-function/datagen " + genInp + " -f")

os.system("mv ./*_* ../../perInstFi/perInstFi-base/base/")