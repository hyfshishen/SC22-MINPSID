import os, sys
import subprocess

inp_string = sys.argv[1]

def generate_weighted_list(inp_string):
    # Generate Static CFG
    genStatCFGCMD = "opt -load ../../../LLVM-3.4-Passes/GenerateStaticCFG.so ./kmeans-llfi_index.ll -GenStatCFG > temp_out"
    BB_start_idx = subprocess.getoutput(genStatCFGCMD).split('\n')
    os.system("rm -rf temp_out")
    # Generate Weighted Dynamic CFG
    preCMD1 = "opt -load ../../../LLVM-3.4-Passes/RecordControlFlow.so ./kmeans-llfi_index.ll -RecordCF -o unlinkable.ll"
    preCMD2 = "clang -S -emit-llvm external.c -o external.ll"
    preCMD3 = "llvm-link unlinkable.ll external.ll -o linkable.ll"
    preCMD4 = "llvm-dis linkable.ll -o readable.ll"
    os.system(preCMD1 + " && " + preCMD2 + " && " + preCMD3 + " && " + preCMD4)
    os.system("lli readable.ll " + inp_string)
    os.system("rm -rf unlinkable.ll external.ll linkable.ll readable.ll")
    # Generate Weighted CFG List
    dynamicCFG_file = open("./controlFlow.txt", 'r')
    dynamicCFG_raw = dynamicCFG_file.read().split('\n')
    if(dynamicCFG_raw[-1] == ""):
        del dynamicCFG_raw[-1]
    dynamicCFG_file.close()
    total_cycle = 0
    dynamicCFG = []
    for item in dynamicCFG_raw:
        total_cycle += int(item.split(' ')[2])
        dynamicCFG.append([item.split(' ')[0], int(item.split(' ')[2])])
    weighted_CFG = []
    for BB in BB_start_idx:
        cur_cycle = 0
        for item in dynamicCFG:
            if(BB == item[0]):
                cur_cycle += item[1]
        weighted_CFG.append(float(cur_cycle)/total_cycle)
    # Write Weighted CFG to file.
    weightedCFG_file = open("weighted-cfg", 'w')
    for item in weighted_CFG:
        weightedCFG_file.write(str(item) + '\n')
    weightedCFG_file.close()

if __name__ == "__main__":
    # Remove last time results.
    os.system("rm -rf controlFlow.txt weighted-cfg")
    # Get current results.
    generate_weighted_list(inp_string)
    # Remove input data
    os.system("rm -rf *_*.txt")