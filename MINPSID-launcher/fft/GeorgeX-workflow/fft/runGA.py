import os, sys

if __name__ == '__main__':

    if(len(sys.argv) != 3):
        print("Template input:")
        print("python3 runGA.py <num_of_input_you_want> <num_of_generation_in_each_GA>")
        print("e.g. python3 runGA.py 10 10")
        sys.exit()

    num_inp = int(sys.argv[1])
    num_gen = sys.argv[2]

    for i in range(num_inp):
        # Delete former results.
        os.system("rm -rf GeneticEngine/ga-output.log")
        os.system("rm -rf GeneticEngine/memory/total-memory/*")
        os.system("rm -rf GeneticEngine/memory/best-memory/*")
        # Run GA for search
        os.chdir("GeneticEngine/")
        os.system("python3 GeneticAlgorithm.py " + num_gen)
        os.chdir("../")
        # Read best score in temp GA
        log_path = "GeneticEngine/ga-output.log"
        log_file = open(log_path, 'r')
        log_cont = log_file.read().split('\n')
        log_file.close()
        best_score_so_far = log_cont[-3].split(' ')[-1]
        # Trim file content
        log_info = []
        for item in log_cont:
            if("Evaluating input:" in item):
                log_info.append(item)
        # Get Current Input
        tar_input = ""
        for item in log_info:
            if(best_score_so_far in item):
                tar_input = item.split(';')[0].replace("Evaluating input: ", '')
        # Write info for each GA
        write_input = open('input-list.txt', 'a')
        write_input.write(tar_input + '\n')
        write_input.close()