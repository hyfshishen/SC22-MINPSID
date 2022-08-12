import os, sys

appName = sys.argv[1]

# read instruction from file, return as a dict {int(index):str(content)}
def get_instruction_list(file_path):
    read_file = open(file_path, 'r')
    file_content_list = read_file.read().split('\n')
    read_file.close()
    inst_list = []
    for item in file_content_list:
        if(", !llfi_index !" in item):
            temp_list = item.split(", !llfi_index !")
            inst_list.append(temp_list[0])
    return inst_list

# given a raw inst string, return its type.
def get_inst_type(raw_inst):
    raw_inst = raw_inst.lstrip()
    if(raw_inst[0] == "%"):
        return raw_inst.split(' ')[2]
    else:
        return raw_inst.split(' ')[0]

os.system("instrument --readable ./base/" + appName + ".ll")
IR_path = "./base/llfi/" + appName + '-llfi_index.ll'
inst_list = get_instruction_list(IR_path)
inst_type = ""
for item in inst_list:
    inst_type += get_inst_type(item) + '\n'
os.system("rm -rf ./base/llfi*")

write_file = open('inst-type.txt', 'w')
write_file.write(inst_type)
write_file.close()