import os, sys
import subprocess

appName = sys.argv[1]
threadNo = sys.argv[2]

os.chdir(appName + "/randomFi")
cmd = "python generate-ran-inst-fi.py " + appName + ' ' +  threadNo
os.system(cmd)
os.chdir("../../")
print("MINPSID Protection Instruction Instrumented!")
print("Protected LLVM IR generated! Path:")
print("~/" + appName + "/randomFi/" + appName + "/" + appName + "-$PROTECTION-LEVEL$/base/" + appName + "-$PROTECTION-LEVEL$.ll")