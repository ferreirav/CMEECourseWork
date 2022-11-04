#!usr/bin/env Rscript

##------------------------------------------
## Name: apply1.R
## Description: Testing family of apply functions
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

#=============================
# Using apply() functions
#=============================

# Build random matrix
M <- matrix(rnorm(100), 10, 10)

# Function execution by ROW
# Take the mean on each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)

# Calculating variance also
RowVars <- apply(M, 1, var)
print(RowVars)


# Function execution by COLUMN
# Take the mean on each row
ColMeans <- apply(M, 2, mean)
print(ColMeans)

# Calculating variance also
ColVars <- apply(M, 2, var)
print(ColVars)
