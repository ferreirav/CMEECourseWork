#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: csvtospace.sh
# Description: This script takes csv files and convert these to space separated values file.
# Arguments: CSV file
# Date: Oct 2022


# Testing if arguments were supplied
if [ $# -eq 0 ]
    then
        echo "Please provide a csv file to convert"
    exit
fi

# Removing extension
FILENAME=$(basename $1 .csv)

# Conversion Process
echo "Creating a spaced delimited version of the $FILENAME..."
cat $1 | tr -s "," " " > ../results/$FILENAME.txt
echo -e "Conversion is completed!!\nFile is located in ../results/ directory!"

exit


#exit
