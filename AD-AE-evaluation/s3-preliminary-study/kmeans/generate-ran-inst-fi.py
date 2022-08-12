import os, sys

appName = sys.argv[1]
threadNo = int(sys.argv[2])
runCount = 1000/threadNo
input_list = "./input-list.txt"

os.system("mkdir " + appName)
os.system("clang -S -emit-llvm external.c -o external.ll")
# os.system("cp -r ../perInstFi/protection-info ./" + appName + "-protection-info")

# Create -cost base.
for i in range(10):
    overhead = (i + 1) * 0.1
    # Create folder
    os.system("cp -r ./randomFi-base ./" + appName + '/' + appName + "-" + str(overhead))
    temp_path = "./" + appName + '/' + appName + "-" + str(overhead)
    # Update input_list.txt
    os.system("cp " + input_list + ' ' + temp_path + "/input_list.txt")
    # Update input.yaml by threadNo and runCount
    in_yaml = open(temp_path + "/base/input.yaml", 'r')
    new_yaml = in_yaml.read().replace("numOfRuns: 20", "numOfRuns: " + str(runCount)) 
    out_yaml = open(temp_path + "/base/input.yaml", 'w')
    out_yaml.write(new_yaml)
    in_yaml.close()
    out_yaml.close()
    # Update .ll by SelectiveInstructionDuplication pass and protection-info
    new_IR_path = appName + "-" + str(overhead) + ".ll"
    os.system("opt -load ./SelectiveInstructionDuplication.so ./compiled-benchmarks/" + appName + '/' + appName + 
              "-llfi_index.ll -bishe_insert -select_set_file=" + appName + "-protection-info/" + appName + '-'
              + str(overhead) + ".txt" + " -o temp-no-link.ll")
    os.system("llvm-link external.ll temp-no-link.ll -o temp-unreadable.ll")
    os.system("llvm-dis temp-unreadable.ll -o " + new_IR_path)
    os.system("rm temp-*")
    os.system("cd " + temp_path + "/base/ && " + "rm *.ll " + "&& " + "mv ../../../" + new_IR_path + " ./")

# Create -ori base.
os.system("cp -r ./randomFi-base ./" + appName + '/' + appName + "-ori")
temp_path = "./" + appName + '/' + appName + "-ori"
# Update input_list.txt
os.system("cp " + input_list + ' ' + temp_path + "/input_list.txt")
# Update input.yaml by threadNo and runCount
in_yaml = open(temp_path + "/base/input.yaml", 'r')
new_yaml = in_yaml.read().replace("numOfRuns: 20", "numOfRuns: " + str(runCount)) 
out_yaml = open(temp_path + "/base/input.yaml", 'w')
out_yaml.write(new_yaml)
in_yaml.close()
out_yaml.close()
# Update .ll
ori_app_path = "compiled-benchmarks/" + appName + '/' + appName + '.ll'
os.system("cd " + temp_path + "/base/ && " + "rm *.ll " + "&& " + "cp ../../../" + ori_app_path + " ./")
os.system("rm external.ll")

# Target execution level
prot_level = ["ori", "0.3", "0.5", "0.7"]
run_file = ""
for level in prot_level:
    cmd1 = "cd " + appName + "-" + level
    if(level == "ori"):
        cmd2 = "python runFiForInputs.py " + appName + " " + str(threadNo)
    else:
        cmd2 = "python runFiForInputs.py " + appName + "-" + level + " " + str(threadNo)
    cmd3 = "cd ..\n"
    run_file += cmd1 + " && " + cmd2 + " && " + cmd3

run_file_open = open("./" + appName + "/run.sh", 'w')
run_file_open.write(run_file)
run_file_open.close()