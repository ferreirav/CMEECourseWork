#!/bin/bash

# Author: Vitor Ferreira f.ferreira@imperial.ac.uk
# Script: CompileLatex.sh
# Description: This script captures the tex argument provided and convert it to pdf file
# Arguments: none
# Date: Oct 2022


# Ask user for the input file and proceed with convertion
echo "Enter the file to Compile without extension"
read a
pdflatex $a.tex
bibtex $a
pdflatex $a.tex
pdflatex $a.tex
mv $a.pdf ../results/
evince ../results/$a.pdf &

# After compilation, files created will be removed
rm *.aux
rm *.log
rm *.bbl
rm *.blg

#exit
