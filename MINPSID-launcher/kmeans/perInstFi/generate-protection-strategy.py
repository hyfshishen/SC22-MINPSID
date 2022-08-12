import os, sys

# get name of existing HPC program
appName = sys.argv[1]
    
# get cost (i.e. dynamic cycle) list
# in fft, normalization times is 10.
def get_cost_list(appName):
    cost_file = open(appName + "-cost.txt", "r")
    cost_list = cost_file.read().split("\n")
    if(cost_list[-1] == ""):
        del cost_list[-1]
    cost_file.close()
    test_list = []
    for item in cost_list:
        test_list.append(str(int(int(item)/1000)))
    return test_list

# get SDC rate list
def get_SDC_rate_list(appName):
    SDC_rate_file = open(appName + "-SDC-rate.txt", "r")
    SDC_rate_list = SDC_rate_file.read().split("\n")
    if(SDC_rate_list[-1] == ""):
        del SDC_rate_list[-1]
    SDC_rate_file.close()
    return SDC_rate_list

# get total cost (total dynamic cycle)
def get_total_cost(cost_list):
    total_cost = 0
    for i in range(len(cost_list)):
        total_cost += int(cost_list[i])
    return total_cost

# get program overall SDC rate (formulation can be found in Peppa-X)
def get_overall_SDC_rate(total_cost, cost_list, SDC_rate_list):
    overall_SDC_rate = 0.0
    for i in range(len(cost_list)):
        if(SDC_rate_list[i] != "0.0" and SDC_rate_list[i] != '?' and SDC_rate_list[i] != 'NoFI'):
            overall_SDC_rate += float(cost_list[i])*float(SDC_rate_list[i])
    overall_SDC_rate = overall_SDC_rate / total_cost
    return overall_SDC_rate

# clean data to proper input of knapsack.py
def get_knapsack_input(total_cost, cost_list, SDC_rate_list):
    string_input = ""
    for i in range(len(cost_list)):
        if(SDC_rate_list[i] == "0.0" or SDC_rate_list[i] == '?' or SDC_rate_list[i] == 'NoFI'):
            string_input += cost_list[i] + "-" + "0.0,"
        else:
            string_input += cost_list[i] + "-" + str(float(SDC_rate_list[i])*float(cost_list[i])) + ","
    return string_input[:-1]

# clean knapsack output to a clear format: max_profit (how much weighted SDC rate can be covered), which instruction to duplicate:[...]
def get_knapsack_output(raw_string):
    max_profit = float(raw_string.split("optimal indices:\n")[0].split("max-profit:")[1])
    raw_list = raw_string.split("optimal indices:\n")[1].split('\n')[:-1]
    inst_list = []
    for item in raw_list:
        inst_list.append(int(item) + 1)
    return max_profit, inst_list

# get information
cost_list = get_cost_list(appName)
SDC_rate_list = get_SDC_rate_list(appName)
total_cost = get_total_cost(cost_list)
overall_SDC_rate = get_overall_SDC_rate(total_cost, cost_list, SDC_rate_list)
input_string = get_knapsack_input(total_cost, cost_list, SDC_rate_list)

print(overall_SDC_rate)

# calculate strategy and write to file
os.system("mkdir protection-info")
protection_curve_data = ""
for i in range(21):
    max_cost = int(i * 0.05 * total_cost)
    max_cost_for_file = round(0.05*i, 2)
    raw_string = os.popen("python knapsack.py " + input_string + " " + str(max_cost)).read()
    max_profit, inst_list = get_knapsack_output(raw_string)
    max_protection = float(max_profit)/total_cost/overall_SDC_rate
    protection_curve_data += str(max_cost_for_file) + ',' + str(max_protection) + '\n'
    temp_protection_strategy = ""
    for inst in inst_list:
        temp_protection_strategy += str(inst) + '\n'
    temp_protection_strategy_file = open("./protection-info/" + appName + '-' + str(max_cost_for_file) + ".txt", "w")
    temp_protection_strategy_file.write(temp_protection_strategy[:-1])
    temp_protection_strategy_file.close()
    print("Cost " + str(max_cost_for_file) + "\tstrategy done!")
protection_file = open("./protection-info/cost-benefit-curve.txt", "w")
protection_file.write(protection_curve_data[:-1])
protection_file.close()

# manually setup 100% protection as duplicating all executed instructions
cost_file = open(appName + "-cost.txt", "r")
cost_list = cost_file.read().split("\n")
if(cost_list[-1] == ""):
    del cost_list[-1]
cost_file.close()
all_pro_path = "./protection-info/" + appName + "-1.0.txt"
all_pro_content = ""
for i in range(len(cost_list)):
    index = i + 1
    if(int(cost_list[i]) != 0):
        all_pro_content += str(index) + '\n'
write_all_pro = open(all_pro_path, 'w')
write_all_pro.write(all_pro_content[:-1])
write_all_pro.close()