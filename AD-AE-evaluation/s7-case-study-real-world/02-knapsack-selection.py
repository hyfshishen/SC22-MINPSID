import os, sys

appName = sys.argv[1]
threadNo = sys.argv[2]

os.chdir(appName + "/perInstFi/")
# Step 1: Collect FI results.
print("Now collecting FI results......")
cmd1 = "python generate-sublevel-costbenefit.py " + appName
os.system(cmd1)

# Step 2: Reprioritization.
print("Now reprioritizing cost and benefits.")
cmd2 = "python generate-protection-YF-Tech.py " + appName
os.system(cmd2)

# Step 3: Knapsack algorithm.
print("Knapsack calculating......")
cmd3 = "python generate-protection-strategy.py " + appName
os.system(cmd3)

os.chdir("../../")