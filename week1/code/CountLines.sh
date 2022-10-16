#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: CountLines.sh
# Description: This script count the number of lines in a given argument
# Arguments: 1
# Date: Oct 2022

if [ -z "$1" ]
    then
        echo "At least one argument must be provided!"
    exit
fi


FILENAME=$(basename $1)

NumLines=`wc -l < $1` #Capture the input from the argument given
echo -e "\nThe file $FILENAME has $NumLines lines." #Print the result to the terminal
echo

#exit