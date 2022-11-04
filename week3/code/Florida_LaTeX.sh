#!/bin/bash

# Author: Vitor Ferreira f.ferreira22@imperial.ac.uk
# Script: Florida_LaTeX.sh.sh
# Description: This script captures the tex argument, runs the Rscript to produce the figures needed for the consequent tex document and converts it to pdf.
# Arguments: A LaTeX file should be provided
# Date: Oct 2022



# Asking for input from the user
if [ $# -eq 0 ]
    then
        echo "A TEX file should be supplied!"
    exit
fi

# Running Florida.R script to produce the graphs that will be pulled from results directory
Rscript Florida.R

# Get the argument and strip the extension
a=`basename -s .tex $1`

# Initiate the Compilation of .tex file
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
