import os, sys

appName = sys.argv[1]
threadNo = sys.argv[2]

inp_file = open("./input-list.txt", "r")
inp_list = inp_file.read().split('\n')
inp_file.close()
if(inp_list[-1] == ''):
    del inp_list[-1]

bash_file_content = ""

for inp in inp_list:
    folder = appName + "-" + inp.replace(' ', '-')
    os.system("cp -r perInstFi-base " + folder)
    bash_file_content += "cd " + folder
    bash_file_content += " && " + "python profileInstType.py " + appName
    bash_file_content += " && " + "python runFiForInst.py " + appName + " \"" + inp + "\" " + threadNo
    bash_file_content += " && " + "cd ..\n"

bash_file = open("run.sh", "w")
bash_file.write(bash_file_content)
bash_file.close()