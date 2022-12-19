#!usr/bin/env python3

"""This script loads and executes an fmr.R file, the uses python process wrappers to inform about success of execution"""

# Imports
import subprocess


### Loading the file into subprocess using shell environment
print("Processing R script file...")

p = subprocess.Popen("Rscript --verbose fmr.R > ../results/fmrR.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait()

if p == 0:
    print("The Rscript file execution has completed successfully!!!")
elif p == 1:
    print("RScript file has run into error!!!")
    print("********************************")
    print("Error details:")
    subprocess.run(["cat", "../results/fmr_errFile.Rout"])
else:
    print("Process has failed!!!")

