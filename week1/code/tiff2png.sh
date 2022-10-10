#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: tiff2png.sh
# Description: This script looks for TIFF files on a specific directory and converts these to PNG
# Arguments: none
# Date: Oct 2022


for f in ../data/*.tiff; 
    do  
	echo $f
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tiff).png";
        echo "Conversion completed!" 
    done

mv *.png ../results/
