#!usr/bin/env Rscript

##------------------------------------------
## Name: preallocate.R
## Description: This script is testing pre-allocation of memory
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clear environmnet
rm(list = ls())

#==============================
# Pre-allocate
#==============================


# Initially we create an empty vector but without any pre-allocated memory in space
NoPreAllocFunc <- function(x){
  print(paste("No allocated memory for", x, "iterations!!!"))
  a <- vector()
  for (i in 1:x){
    a <- c(a, i)
    # print(a)
    # print(object.size(a))
  }
}
print("Runtime of function without pre-allocating any memory in space:")
print(system.time(NoPreAllocFunc(10000)))


# In the following example we are pre-allocating memory space to execute the functions
PreAllocFun <- function(x){
  print(paste("Pre-allocating memory space for", x, "iterations!!!"))
  a <- rep(NA, x) # here we assigned empty space to "x" values
  for (i in 1:x){
    a[i] <- i
    # print(a)
    # print(object.size(a))
  }
}

print("Runtime of function where we pre-allocate memory previously:")
print(system.time(PreAllocFun(10000)))
