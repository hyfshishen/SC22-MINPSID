import os, sys

appName = sys.argv[1]

inp_file = open("./input-list.txt", "r")
inp_list = inp_file.read().split('\n')
inp_file.close()
if(inp_list[-1] == ''):
    del inp_list[-1]

for inp in inp_list:
    # Get all folder and files.
    folder = appName + "-" + inp.replace(' ', '-')
    os.chdir(folder)
    raw_list = os.listdir("./")
    # Trim, only reserve folders with "appName-InstNo"
    # Get the total index of current per-inst-FI base.
    folder_list = []
    for item in raw_list:
        if(appName + '-' in item and "cost" not in item and "SDC-rate" not in item):
            folder_list.append(item)
    total_index = len(folder_list)
    # Merge all distributed data to one appName-cost.txt and appName-SDC-rate.txt in current path.
    cost_file_path = './' + appName + '-cost.txt'
    cost_file_content = ""
    rate_file_path = './' + appName + '-SDC-rate.txt'
    rate_file_content = ""
    for i in range(total_index):
        sub_folder = appName + '-' + str(i+1)
        temp_cost_file = open(sub_folder + '/cost.txt', 'r')
        cost_file_content += temp_cost_file.read() + '\n'
        temp_cost_file.close()
        temp_rate_file = open(sub_folder + '/SDC-rate.txt', 'r')
        rate_file_content += temp_rate_file.read() + '\n'
        temp_rate_file.close()
    # Write file content.
    cost_file = open(cost_file_path, 'w')
    cost_file.write(cost_file_content)
    cost_file.close()
    rate_file = open(rate_file_path, 'w')
    rate_file.write(rate_file_content)
    rate_file.close()
    # Back to up layer
    os.chdir("../")