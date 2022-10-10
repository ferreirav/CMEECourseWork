#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: variable.sh
# Description: Script illustrating the use of different variable types in BASH
# Arguments: several
# Date: Oct 2022

### llustration of multiple use of variables ###

# Use of special variables provided by the user
echo
echo "***This script starts with the insertion of 2 arguments in the $0 ***"
echo "This script is called $0."
echo "This script was entered $# arguments."
echo -e "\nThe arguments are as follow:\n$@."
echo "Being the first argument: $1;"
echo -e "and the second argument it is: $2."
echo
echo

sleep 1 # Provides a pause whilst running the script!


# Assigned varibles whilst runnig the script
# Below we illustrate the change of a variable fed by the user

MY_VAR="Hello world!!!"
echo "***Now we will be looking at example of assigned variables***"
echo "The current value of the variable it is: $MY_VAR"
echo "Please enter a new string:"
read MY_VAR
echo "The variable has now been assigned to: $MY_VAR"
echo
echo


sleep 1 # Provides a pause whilst running the script!


# Assigning variables - Reading multiple inputs from user
echo "***For last, we will use inputs from user to execute COMMAND inside the script***"
echo "Enter two numbers separated by space:"
read a b
echo
echo -e "The values enteres are $a and $b.\nTheir sum it is:"
MY_SUM=$(expr $a + $b)
echo $MY_SUM
echo
echo
echo -e "You have now completed the $0 script!\n"