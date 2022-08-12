from concurrent.futures import thread
import os, sys

appName = sys.argv[1]
threadNo = sys.argv[2]

# Step 1: Executing MINPSID Workflow
os.chdir(appName + "/GeorgeX-workflow/" + appName)
cmd2 = "python3 runGA.py 30 50"
# cmd2 = "python3 runGA.py 10 20"
os.system(cmd2)
os.chdir("../../../")

# Step2: Copy Fuzzing result to per-inst-fi base, and perform per-instruction fault injection.
cmd3 = "cp " + appName + "/GeorgeX-workflow/" + appName + "/input-list.txt ./" + appName + "/perInstFi/"
os.system(cmd3)
if(appName == "bfs" or appName == "kmeans"):
    os.chdir(appName + "/GeorgeX-workflow/" + appName)
    cmd1 = "python3 mvInpData.py"
    os.system(cmd1)
    os.chdir("../../../")
os.chdir(appName + "/perInstFi")
cmd4 = "python generate-folder.py " + appName + ' ' + threadNo
os.system(cmd4)
cmd5 = "bash run.sh"
os.system(cmd5)
cmd6 = "python generate-sublevel-costbenefit.py " + appName
os.system(cmd6)
os.chdir("../../")
