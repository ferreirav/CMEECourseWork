#!usr/bin/env Rscript

##------------------------------------------
## Name: break.R
## Description: Script illustrating the implementation of break argument
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

# Making use of break over a while loop
i <- 0 # setting variable

while (i < Inf) {
  if (i == 10) {
    break 
  } else { # Break out of the while loop!  
    cat("i equals " , i , " \n")
    i <- i + 1 # Updates i for every iteration
  }
}