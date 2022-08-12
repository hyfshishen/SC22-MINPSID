import math
import random
import os
import subprocess
from datetime import datetime

# Calculate Euclidean distance between two list
# Two list must with the same length!!!
def calculate_euclidean_distance(list1, list2):
        value_count = 0.0
        for i in range(len(list1)):
                value_count += (list1[i] - list2[i]) ** 2
        return value_count ** 0.5

# Read weighted-CFG from a file, and return a list with float type elements.
def read_weighted_CFG(file_path):
        file_open = open(file_path, 'r')
        file_list = file_open.read().split('\n')
        file_open.close()
        if(file_list[-1] == ''):
                del file_list[-1]
        tar_list = [float(item) for item in file_list]
        return tar_list

memY = {}

class Chromosome:
    def __init__(self, bounds):
        self.noOfArgs = len(bounds)
        self.x = []
        self.inputString = ""
        
        for i in range(0, self.noOfArgs):
                self.x.append(random.randint(bounds[i][0], bounds[i][1]))
                if(i == 0):
                        orgX = int(self.x[0])
                        newX = int(orgX) * 16
                        self.x[0] = newX
                        self.inputString = self.inputString + str(self.x[i])
                else:
                        self.inputString = self.inputString + " " + str(self.x[i])
        self.y = 0
        self.cc = 0

    def func(self):
        global memY

        # Update values
        self.inputString = ""
        for i in range(0, self.noOfArgs):
                if i == 0:
			##################
			# For needle
                        orgX = int(self.x[0])
                        newX = int(orgX / 16) * 16
                        if newX == 0:
                                newX = 16
                        self.x[0] = newX
			##################
			##################
                        self.inputString = self.inputString + str(self.x[i])
                else:
                        self.inputString = self.inputString + " " + str(self.x[i])

        if self.inputString in memY:
                self.y = memY[self.inputString]

        else:
                # If this is the first generator
                count_cmd = "ls memory/total-memory/ | wc -l"
                mem_count = int(subprocess.getoutput(count_cmd))
                if(mem_count <= 5):
                        self.y = random.random()
                        self.cc = 0
                        os.chdir("./fitness-function")
                        print(" -- Evaluating First-gen input: " + self.inputString)
                        os.system("python3 runWithInput.py \"" + self.inputString + "\"")
                        os.system("cp ./weighted-cfg ../memory/total-memory/weighted-cfg-" + self.inputString.replace(' ', '-'))
                        os.chdir("../")
                else:
                        os.chdir("./fitness-function/")
                        print(" -- Evaluating input: " + self.inputString)
                        os.system("python3 runWithInput.py \"" + self.inputString + "\"")
                        os.system("cp ./weighted-cfg ../memory/total-memory/weighted-cfg-" + self.inputString.replace(' ', '-'))
                        os.chdir("../")
                        cur_CFG_list = read_weighted_CFG("./fitness-function/weighted-cfg")
                        tar_CFG_path = os.listdir("./memory/best-memory/")
                        cur_score = 0.0
                        for file_name in tar_CFG_path:
                                path = "./memory/best-memory/" + file_name
                                temp_CFG_list = read_weighted_CFG(path)
                                cur_score += calculate_euclidean_distance(cur_CFG_list, temp_CFG_list)
                        self.y = cur_score / len(tar_CFG_path)
                        memY[self.inputString] = self.y
                        if os.path.exists("code-coverage.txt") == True:
                                cf = open("code-coverage.txt", 'r')
                                cc = float(cf.read().replace("\n", ""))
                                self.cc = cc
                                cf.close()
                        else:
                                self.cc = 0

        logF = open("ga-output.log", 'a')
        logF.write("Evaluating input: " + self.inputString + "; CFG AVG Euclidean Distance: " + str(self.y) + "\n") 
     
        now = datetime.now()
        dt_string = now.strftime("%d/%m/%Y %H:%M:%S")

        logF.write("**** [TIME] **** : " + str(dt_string) + "\n" )
        logF.close()


if __name__ == '__main__':
    a = [[1, 100], [4, 50]]
    chromosome = Chromosome(a)
    chromosome.func()
    for j in range(0, len(chromosome.x)):
        print(chromosome.x[j])
