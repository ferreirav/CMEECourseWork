#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: CountLines.sh
# Description: This script count the number of lines in a give argument
# Arguments: 1
# Date: Oct 2022

FILENAME=$(basename $1)

NumLines=`wc -l < $1` #Capture the input from the argument given
echo "The file $FILENAME has $NumLines lines." #Print the result to the terminal
echo

#exit