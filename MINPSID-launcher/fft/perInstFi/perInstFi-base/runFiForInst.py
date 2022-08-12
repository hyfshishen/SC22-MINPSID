import os, sys
import subprocess
import resource
import time

###############################
bmName = sys.argv[1]
theInput = sys.argv[2]
noOfThreads = int(sys.argv[3])
###############################

# Maximal virtual memory for subprocesses (in bytes).
MAX_VIRTUAL_MEMORY = 1024 * 1024 * 1024 # 1 GB

def limit_virtual_memory():
    # The tuple below is of the form (soft limit, hard limit). Limit only
    # the soft part so that the limit can be increased later (setting also
    # the hard limit would prevent that).
    # When the limit cannot be changed, setrlimit() raises ValueError.
    resource.setrlimit(resource.RLIMIT_AS, (MAX_VIRTUAL_MEMORY, resource.RLIM_INFINITY))

# Read input list
instList = open('inst_list.txt', 'r').readlines()

jobQ = []
for eachInst in instList:
	if eachInst != "\n":
		
		# Launch FI for the inst
		eachInst = eachInst.replace("\n", "")
		instFolderName = bmName + "-" + eachInst
		os.system("cp -r base " + instFolderName)
		os.chdir(instFolderName)
		# Replace XXXX in input.yaml with inst index
		inf = open("input.yaml", 'r') 
		newInp = inf.read().replace("XXXX", eachInst)
		outf = open("input.yaml", 'w')
		outf.write(newInp)
		inf.close()
		outf.close()
		p = subprocess.Popen(["python", "runFi.py", bmName, theInput], preexec_fn=limit_virtual_memory)
		jobQ.append(p)			
		os.chdir("../")


		# Check if there is empty slot
		print("******************* JOB Q SIZE: " + str(len(jobQ)) + "**********************\n")
		while len(jobQ) >= noOfThreads:
			time.sleep(1)
			for eachP in jobQ:
				if eachP.poll() is not None: # the job finishes
					jobQ.remove(eachP)
