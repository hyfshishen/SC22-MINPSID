import os, sys
import subprocess

appName = sys.argv[1]
threadNo = sys.argv[2]

os.chdir(appName)
# Step 1: Generate FI base.
cmd1 = "python generate-ran-inst-fi.py " + appName + ' ' +  threadNo
os.system(cmd1)
print("Baseline Protection Instruction Instrumented!")
print("Random Fault Injection base created!")

# Step2: Random Fault Injection.
os.chdir(appName)
cmd2 = "bash run.sh"
os.system(cmd2)
os.chdir("../")

# Step3: Obtain Results.
cmd3 = "python count-result.py " + appName + ' ' + threadNo
raw_result = subprocess.getoutput(cmd3)
os.chdir("../")

# Step4: Clean Results.
red_line_list = [0.0, 0.0, 0.0]
baseline_protection_file = "./baseline-protection/" + appName + "-protection-info/cost-benefit-curve.txt"
file_open = open(baseline_protection_file, 'r')
raw_cont = file_open.read()
file_open.close()
for item in raw_cont.split('\n'):
    if("0.3," in item):
        red_line_list[0] = float(item.split(',')[1])
    if("0.5," in item):
        red_line_list[1] = float(item.split(',')[1])
    if("0.7," in item):
        red_line_list[2] = float(item.split(',')[1])
raw_result_list = raw_result.split('\n')
raw_SDC_rate = float(raw_result_list[1])
if(raw_SDC_rate == 0):
    raw_SDC_rate += 0.001
state = 0
'''
state = 0 "ini"
state = 1 "0.3"
state = 2 "0.5"
state = 3 "0.7"
'''
raw_list30 = [1, 0.0]
raw_list50 = [1, 0.0]
raw_list70 = [1, 0.0]
for i in range(len(raw_result_list)):
    if("#" in raw_result_list[i] and "0.3" in raw_result_list[i]):
        state = 1
        continue
    if("#" in raw_result_list[i] and "0.5" in raw_result_list[i]):
        state = 2
        continue
    if("#" in raw_result_list[i] and "0.7" in raw_result_list[i]):
        state = 3
        continue
    # update results for 30 protection level    
    if(state == 1):
        temp = float(raw_result_list[i])
        if(temp < raw_list30[0]):
            raw_list30[0] = temp
        if(temp > raw_list30[1]):
            raw_list30[1] = temp
    # update results for 50 protection level    
    if(state == 2):
        temp = float(raw_result_list[i])
        if(temp < raw_list50[0]):
            raw_list50[0] = temp
        if(temp > raw_list50[1]):
            raw_list50[1] = temp
    # update results for 70 protection level    
    if(state == 3):
        temp = float(raw_result_list[i])
        if(temp < raw_list70[0]):
            raw_list70[0] = temp
        if(temp > raw_list70[1]):
            raw_list70[1] = temp
list30 = [0.0, 0.0, 0.0]
list50 = [0.0, 0.0, 0.0]
list70 = [0.0, 0.0, 0.0]
# update theoretical
list30[2] = red_line_list[0]
list50[2] = red_line_list[1]
list70[2] = red_line_list[2]
# update 30
list30[0] = (raw_SDC_rate - raw_list30[0])/raw_SDC_rate
if(list30[0] < 0):
    list30[0] = 0.0
list30[1] = (raw_SDC_rate - raw_list30[1])/raw_SDC_rate
if(list30[1] < 0):
    list30[1] = 0.0
# update 50
list50[0] = (raw_SDC_rate - raw_list50[0])/raw_SDC_rate
if(list50[0] < 0):
    list50[0] = 0.0
list50[1] = (raw_SDC_rate - raw_list50[1])/raw_SDC_rate
if(list50[1] < 0):
    list50[1] = 0.0
# update 70
list70[0] = (raw_SDC_rate - raw_list70[0])/raw_SDC_rate
if(list70[0] < 0):
    list70[0] = 0.0
list70[1] = (raw_SDC_rate - raw_list70[1])/raw_SDC_rate
if(list70[1] < 0):
    list70[1] = 0.0

# Finally, print all the cleaned results.
print("Benchmark: " + appName)
print("======30 Protection Level======")
print("Red Bar: " + str(list30[2]))
print("Max Cov: " + str(list30[0]))
print("Min Cov: " + str(list30[1]))
print("======50 Protection Level======")
print("Red Bar: " + str(list50[2]))
print("Max Cov: " + str(list50[0]))
print("Min Cov: " + str(list50[1]))
print("======70 Protection Level======")
print("Red Bar: " + str(list70[2]))
print("Max Cov: " + str(list70[0]))
print("Min Cov: " + str(list70[1]))
print("\"Red bar\" in paper and above means theoretical cov.")