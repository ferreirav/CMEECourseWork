#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: This script merges two files
# Arguments: Three files are given as arguments
# Date: Oct 2022

# Inspecting if arguments were provided by the user
if [ -z "$1" ]
    then
        echo "No argument supplied!!!"
    exit
fi

if [ $# -eq 1 ]
    then
        echo "Missing one argument to be merged!"
    exit
fi

# Arguments $1 and $2 are given by the user to be merged to be merged

echo -e "\nPlease provide the name for the output file:"
read a
cat $1 > ../results/$a
cat $2 >> ../results/$a
echo "Your file $a is ready!"
echo
cat ../results/$a


#exit
