import os, sys

appName = sys.argv[1]

# generate dynamic cycle list of SDC rate list of one input
def get_cycle_and_sdc_rate_list(inp):
    folder_path = appName + '-' + inp.replace(' ', '-')
    # get dynamic cycle list, str type for each instruction
    dynamic_cycle_path = folder_path + '/' + appName + "-cost.txt"
    dynamic_cycle_file = open(dynamic_cycle_path, 'r')
    dynamic_cycle_list = dynamic_cycle_file.read().split('\n')
    if(dynamic_cycle_list[-1] == ''):
        del dynamic_cycle_list[-1]
    dynamic_cycle_file.close()
    # get sdc rate list, str type for each instruction
    sdc_rate_path = folder_path + '/' + appName + "-SDC-rate.txt"
    sdc_rate_file = open(sdc_rate_path, 'r')
    sdc_rate_list = sdc_rate_file.read().split('\n')
    if(sdc_rate_list[-1] == ''):
        del sdc_rate_list[-1]
    sdc_rate_file.close()
    return dynamic_cycle_list, sdc_rate_list

# get total dynamic cycle of dynamic cycle list of one input
def get_total_cycle(cost_list):
    total_cycle = 0
    for i in range(len(cost_list)):
        total_cycle += int(cost_list[i])
    return total_cycle

# Read input list, here inp_list[0] is the reference input mentioned in the benchmark website.
file_path = "./input-list.txt"
file_open = open(file_path, 'r')
inp_list = file_open.read().split("\n")
file_open.close()
if(inp_list[-1] == ''):
    del inp_list[-1]

# Get NoFI instructions
nofi_cycle_path = appName + '-' + inp_list[0].replace(' ', '-') + '/' + appName + "-SDC-rate.txt"
nofi_cycle_file = open(nofi_cycle_path, 'r')
nofi_cycle_list = nofi_cycle_file.read().split('\n')
if(nofi_cycle_list[-1] == ''):
    del nofi_cycle_list[-1]
nofi_cycle_file.close()
nofi_list = []
for i in range(len(nofi_cycle_list)):
    if(nofi_cycle_list[i] == "NoFI"):
        nofi_list.append(i + 1)

# Total list of dynamic cycle list and sdc rate list per input
totalListDynamicCycle = []
totalListSDCRate = []
for inp in inp_list:
    temp_dynamic_cycle_list, temp_sdc_rate_list = get_cycle_and_sdc_rate_list(inp)
    totalListDynamicCycle.append(temp_dynamic_cycle_list)
    totalListSDCRate.append(temp_sdc_rate_list)

# Total total cycle list per input
total2CycleList = []
for cost_list in totalListDynamicCycle:
    total_cycle = get_total_cycle(cost_list)
    total2CycleList.append(total_cycle)

# Get total incubative instruction list (a set)
totalIncubativeInstList = []
for inp1 in inp_list:
    inp1_dc_list, inp1_sr_list = get_cycle_and_sdc_rate_list(inp1)
    for inp2 in inp_list:
        inp2_dc_list, inp2_sr_list = get_cycle_and_sdc_rate_list(inp2)
        for i in range(len(inp1_dc_list)):
            if((i+1) not in nofi_list and inp1_sr_list[i] != '?' and inp2_sr_list[i] != '?'):
                if(float(inp1_sr_list[i]) == 0.0 and float(inp2_sr_list[i]) > 0.0):
                    totalIncubativeInstList.append(i+1)
totalIncubativeInstList = list(set(totalIncubativeInstList))
print(len(totalIncubativeInstList))

# Generate target cost list
target_cycle_list = []
for i in range(len(totalListDynamicCycle[0])):
    target_cycle_list.append(totalListDynamicCycle[0][i])

# Generate target SDC rate list
target_SDC_rate_list = []
for i in range(len(totalListSDCRate[0])):
    if(i+1 in nofi_list):
        target_SDC_rate_list.append("NoFI")
    elif(i+1 in totalIncubativeInstList):
        temp_max = 0.0
        for j in range(len(inp_list)):
            if(totalListSDCRate[j][i] != '?' and float(totalListSDCRate[j][i]) > temp_max):
                temp_max = totalListSDCRate[j][i]
        target_SDC_rate_list.append(str(temp_max))
    else:
        target_SDC_rate_list.append(totalListSDCRate[0][i])

# Write File
SDC_rate_file = appName + "-SDC-rate.txt"
cost_file = appName + "-cost.txt"
os.system("touch " + SDC_rate_file)
os.system("touch " + cost_file)
with open(SDC_rate_file, "w") as f:
    for item in target_SDC_rate_list:
        f.write(str(item)+"\n")
with open(cost_file, "w") as f:
    for item in target_cycle_list:
        f.write(str(item)+"\n")