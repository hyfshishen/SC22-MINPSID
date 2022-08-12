import os, sys
import filecmp

bmName = sys.argv[1]
progInput = sys.argv[2]

# get the cost (i.e. dynamic cycle) of given instruction
def get_cost_perinst():
    temp_path = "./llfi.stat.prof.txt"
    temp_cost_file = open(temp_path, "r")
    temp_cost = int(temp_cost_file.read().split("\n")[2].replace("total_cycle=", ""))
    temp_cost_file.close()
    return temp_cost

# get the SDC rate of given instruction
def get_SDC_rate_perinst():
    temp_path = "./llfi/"
    file_gld_out = temp_path + "baseline/output.prof.dat"
    run_count = 100
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
	# if no outputfile, SDC!
        try:
            file_output_txt = open(file_out)
            file_output_txt_content = ""
            file_output_txt.close()
        except IOError:
            file_output_txt_content = "NOOUTPUTTXT!"
        if("hang" in error_msg):
            hang_count += 1
        elif("crash" in error_msg):
            crash_count += 1
        elif("NOOUTPUTTXT!" in file_output_txt_content):
            SDC_count += 1
        elif(filecmp.cmp(file_out, file_gld_out)):
            benign_count += 1
        else:
            SDC_count += 1
    return float(SDC_count)/float(run_count)

# Get inst type list
inst_path = "../inst-type.txt"
type_file = open(inst_path, 'r')
inst_list = type_file.read().split("\n")
type_file.close()

# Get current inst number
cur_num = int(os.getcwd().split('/')[-1].split('-')[1])
cur_type = inst_list[cur_num - 1]

# Perform instrument - profiling - FI
if(cur_type == 'ret' or cur_type == 'alloca' or cur_type == 'call' or cur_type == 'phi'):
    os.system("instrument --readable " + bmName + ".ll -lm")
    os.system("profile llfi/" + bmName + "-profiling.exe " + progInput)
    print("Dangerous instruction type, stop injecting faults!")
    cur_cost = get_cost_perinst()
    cur_sdc_rate = "NoFI"
else:
    os.system("instrument --readable " + bmName + ".ll -lm")
    os.system("profile llfi/" + bmName + "-profiling.exe " + progInput)
    fiString = "injectfault llfi/" + bmName + "-faultinjection.exe " + progInput
    print("Run FI with this command: " + fiString)
    print(fiString)
    os.system(fiString)
    cur_cost = get_cost_perinst()
    if(cur_cost > 0):
        cur_sdc_rate = get_SDC_rate_perinst()
    else:
        cur_sdc_rate = '?'

# Write files
write_cost = open("cost.txt", 'w')
write_cost.write(str(cur_cost))
write_cost.close()
write_sdc_rate = open("SDC-rate.txt", 'w')
write_sdc_rate.write(str(cur_sdc_rate))
write_sdc_rate.close()

# In order to save the storage, remove all temporay FI data. 
os.system("rm -rf llfi*")
