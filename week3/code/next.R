#!usr/bin/env Rscript

##------------------------------------------
## Name: next.R
## Description: Script illustrating the implementation of the next argument
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

for (i in 1:10) {
  if ((i %% 2) == 0) # checking if number is odd!!
    next # pass to next iteration
  print(i)
}