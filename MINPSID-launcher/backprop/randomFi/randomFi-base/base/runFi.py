import os, sys
import filecmp

bmName = sys.argv[1]
progInput = sys.argv[2]
tar_path = os.getcwd()
appName = bmName.split('-')[0]

# We do not clone instructions if(opcode == 28 || opcode < 8 || opcode >= 45 || opcode == 26)
no_dup_inst = ["store", 
               "ret", "br", "switch", "indirectbr", "invoke", "resume", "unreachable",
               "phi", "call", "select", "userop1", "userop2", "vaarg", "extractelement", "insertelement", "shufflevector", "extractvalue", "insertvalue", "landingpad",
               "alloca"]


# get index of temp trial
def get_temp_index(path):
    read_file = open(path, "r")
    file_content = read_file.read().split(', ')
    index = 0
    for item in file_content:
        if("fi_index=" in item):
            index = int(item.replace("fi_index=", ''))
            break
    read_file.close()
    return index

# judge if the index has been protected under contemprory strategy
def judge_protection(index):
    strategy = bmName.split('-')[-1]
    protection_path = "../../../../" + appName + "-protection-info/" + appName + '-' + strategy + ".txt"
    protection_file = open(protection_path, 'r')
    protection_list = protection_file.read().split("\n")
    protection_file.close()
    if(str(index) in protection_list):
        return False
    else:
        return True

# read instruction from file, return as a dict {int(index):str(content)}
def get_instruction_dict(file_path):
    read_file = open(file_path, 'r')
    file_content_list = read_file.read().split('\n')
    read_file.close()
    inst_dict = {}
    for item in file_content_list:
        if(", !llfi_index !" in item):
            temp_list = item.split(", !llfi_index !")
            inst_dict[int(temp_list[1])] = temp_list[0]
    return inst_dict

# given a raw inst string, return its type.
def get_inst_type(raw_inst):
    raw_inst = raw_inst.lstrip()
    if(raw_inst[0] == "%"):
        return raw_inst.split(' ')[2]
    else:
        return raw_inst.split(' ')[0]

# align two protected_instructions with original_instructions, return a dict for geting its original instruction index.
def align_index(ori_inst_dict, pro_inst_dict):
    pro_index_list = list(pro_inst_dict)
    # strip check_flag instructions.
    trimmed_index_dict = {}
    for i in range(len(pro_index_list)):
        temp_index = i + 1
        if(i == 0 or i >= len(pro_index_list) - 2):
            trimmed_index_dict[temp_index] = pro_inst_dict[temp_index]
            continue
        if(get_inst_type(pro_inst_dict[temp_index + 2]) == "call" and "@check_flag()" in pro_inst_dict[temp_index + 2]):
            continue
        elif(get_inst_type(pro_inst_dict[temp_index + 1]) == "call" and "@check_flag()" in pro_inst_dict[temp_index + 1]):
            continue
        elif(get_inst_type(pro_inst_dict[temp_index]) == "call" and "@check_flag()" in pro_inst_dict[temp_index]):
            continue    
        elif(get_inst_type(pro_inst_dict[temp_index - 1]) == "call" and "@check_flag()" in pro_inst_dict[temp_index - 1]):
            continue
        else:
            trimmed_index_dict[temp_index] = pro_inst_dict[temp_index]
    trimmed_list = list(trimmed_index_dict)
    # get aligned_dict, using for aligned_dict[pro_inst_index] = ori_index or "notification"
    ori_flag = 1
    checker = 0
    aligned_dict = {}
    for temp_index in trimmed_list:
        # judge global variables.
        if(ori_flag < len(ori_inst_dict)):
            while("@_ZNSt8ios_base4InitC1Ev" in ori_inst_dict[ori_flag] or "@__cxx_global_var_init" in ori_inst_dict[ori_flag]):
                if("@_ZNSt8ios_base4InitC1Ev" in ori_inst_dict[ori_flag]):
                    ori_flag += 3
                if("@__cxx_global_var_init" in ori_inst_dict[ori_flag]):
                    ori_flag += 2
        # assign value to aligned_dict
        if(temp_index < 5):
            aligned_dict[temp_index] = "external check_flag() function"
        elif((not judge_protection(ori_flag)) and (get_inst_type(ori_inst_dict[ori_flag]) not in no_dup_inst) and checker == 0):
            aligned_dict[temp_index] = ori_flag
            checker = 1
        elif(checker == 1):
            aligned_dict[temp_index] = ori_flag
            ori_flag += 1
            checker = 0
        elif(ori_flag > len(ori_inst_dict)):
            aligned_dict[temp_index] = "end of program"
        else:
            aligned_dict[temp_index] = ori_flag
            ori_flag += 1
    return aligned_dict

# get the SDC rate of given instruction
def get_SDC_number():
    if("ori" not in tar_path):
        ori_inst_dict = get_instruction_dict("../../../../compiled-benchmarks/" + appName + '/' + appName + "-llfi_index.ll")
        pro_inst_dict = get_instruction_dict(tar_path + "/llfi/" + tar_path.split('/')[-3] + "-llfi_index.ll")
        aligned_dict = align_index(ori_inst_dict, pro_inst_dict)

    temp_path = "./llfi/"
    file_gld_out = temp_path + "baseline/output.prof.dat"
    run_count = 50
    SDC_count = 0
    benign_count = 0
    crash_count = 0
    hang_count = 0
    # print("\rChecking files in " + temp_path + " ......")
    for f in range(run_count):
        file_out = temp_path + "prog_output" + "/output.0-" + str(f) + ".dat"
        try:
            file_err = open(temp_path + "error_output" + "/errorfile-run-0-" + str(f))
            error_msg = file_err.read()
            file_err.close()
        except IOError: # no error output
            error_msg = ""
        #####
        try:
            file_out_content = open(file_out)
            file_output_txt = ""
            file_out_content.close()
        except IOError: # no error output
            file_output_txt = "YAFANOUTPUT!"
        #####
        if("hang" in error_msg):
            hang_count += 1
        elif("crash" in error_msg):
            crash_count += 1
        elif("YAFAN" in file_output_txt):
            if("ori" not in tar_path):
                specific_path = temp_path + "llfi_stat_output/llfi.stat.fi.injectedfaults.0-" + str(f) + ".txt"
                temp_pro_index = get_temp_index(specific_path)
                temp_ori_index = aligned_dict[temp_pro_index]
                temp_type = get_inst_type(ori_inst_dict[temp_ori_index])
                if(judge_protection(temp_ori_index)):
                    SDC_count += 1
            else:
                SDC_count += 1
        elif(filecmp.cmp(file_out, file_gld_out)):
            benign_count += 1
        else:
            if("ori" not in tar_path):
                specific_path = temp_path + "llfi_stat_output/llfi.stat.fi.injectedfaults.0-" + str(f) + ".txt"
                temp_pro_index = get_temp_index(specific_path)
                temp_ori_index = aligned_dict[temp_pro_index]
                temp_type = get_inst_type(ori_inst_dict[temp_ori_index])
                if(judge_protection(temp_ori_index)):
                    SDC_count += 1
            else:
                SDC_count += 1
    return SDC_count


os.system("instrument --readable " + bmName + ".ll -lm")
os.system("profile llfi/" + bmName + "-profiling.exe " + progInput)
fiString = "injectfault llfi/" + bmName + "-faultinjection.exe " + progInput
print("Run FI with this command: " + fiString)
print(fiString)
os.system(fiString)
sdc_number = get_SDC_number()

# Write files
write_sdc_rate = open("SDC-number.txt", 'w')
write_sdc_rate.write(str(sdc_number))
write_sdc_rate.close()

# In order to save the storage, remove all temporay FI data. 
os.system("rm -rf llfi*")
