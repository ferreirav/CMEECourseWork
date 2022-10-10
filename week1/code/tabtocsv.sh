#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: tabtocsv.sh
# Description: changes tab separated files into csv files
# Arguments: tab delimited file
# Date: Oct 2022


# Testing if arguments were supplied
if [ -z "$1" ]
    then
        echo "No argument supplied!!!"
    exit
fi


# Removing extension
FILENAME=$(basename $1 .txt)
#This script has a limitation that it only takes *.txt file

# Doing conversion
echo "Creating a comma delimited version of the $FILENAME..."
cat $1 | tr -s '\t' ',' > ../results/$FILENAME.csv
echo -e "Conversion is completed!!\nFile is located in ../results/ directory!"

exit