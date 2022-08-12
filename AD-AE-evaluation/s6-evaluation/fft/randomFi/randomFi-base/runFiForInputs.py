import os, sys
import subprocess

###############################
bmName = sys.argv[1]
noOfThreads = int(sys.argv[2])
###############################

# Read input list
inputList = open('input_list.txt', 'r').readlines()

for eachInput in inputList:
	if eachInput != "\n":
		
		# Launch FI for the input
		eachInput = eachInput.replace("\n", "")
		inputFolderName = bmName + "-" + eachInput.replace(" ", "-")
		os.system("mkdir " + inputFolderName)
		os.chdir(inputFolderName)
		# Launch multiple threads for the FI of the input
		jobQ = []
		for t in range(0, noOfThreads):
			os.system("cp -r ../base fi-" + str(t))
			os.chdir("fi-" + str(t))
			p = subprocess.Popen(["python", "runFi.py", bmName, eachInput])
			jobQ.append(p)			
			os.chdir("../")
		# Check if current inputs of all threads finish
		allDone = 0
		while allDone == 0:
			allDone = 1
			for eachP in jobQ:
				if eachP.poll() is None:
					allDone = 0
					break

		os.chdir("../")
