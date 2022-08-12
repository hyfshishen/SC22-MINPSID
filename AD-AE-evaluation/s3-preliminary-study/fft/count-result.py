import os, sys

appName = sys.argv[1]
threadNo = int(sys.argv[2])

inp_file = open("./input-list.txt", "r")
inp_list = inp_file.read().split('\n')
inp_file.close()
if(inp_list[-1] == ''):
    del inp_list[-1]

prot_level = ["ori", "0.3", "0.5", "0.7"]

base_path = "./" + appName + "/"
for level in prot_level:
    temp_path = base_path + appName + '-' + level + '/'
    print("##########In " + level + " protection overhead##########")
    for inp in inp_list:
        if(level == "ori"):
            sub_temp_path = temp_path + appName + '-' + inp.replace(' ', '-')
        else:
            sub_temp_path = temp_path + appName + '-' + level + '-' + inp.replace(' ', '-')
        SDC_count = 0
        for i in range(threadNo):
            sub_sub_temp_path = sub_temp_path + "/fi-" + str(i) + '/SDC-number.txt'
            read_number_file = open(sub_sub_temp_path, 'r')
            SDC_count += int(read_number_file.read())
            read_number_file.close()
        print(float(SDC_count)/1000.0)