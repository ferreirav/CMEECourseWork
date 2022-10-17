#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: tiff2png.sh
# Description: Looks for TIFF in data and makes conversion to PNG
# Arguments: none
# Date: Oct 2022

# This script takes all TIFF files na convert these into PNG files

for f in ../data/*.tiff; 
    do  
	echo $f
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tiff).png";
        echo "Conversion completed!" 
    done

mv *.png ../results/
