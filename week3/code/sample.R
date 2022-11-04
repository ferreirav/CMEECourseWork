#!usr/bin/env Rscript

##------------------------------------------
## Name: sample.R
## Description: This script tests a compilation of techniques using normal operations,
##              Loops, List on vectors, with and without pre-allocation of memory,
##              and also the use o apply family functions such as SAPPLY for vector 
##              output, or LAPPY for lists output
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

#==============================
# LAPPLY and SAPPLY functions
#==============================

########## FUNCTIONS ###########

# --- Sample Function ------
# A function to take a sample size n from a population "popn" and returns its mean
myexperiment <- function(popn, n){
  pop_sample <- sample(popn, n, replace = FALSE)
  return(mean(pop_sample))
}


#----------------------
# --- Function 1 ------
# Calculate means using FOR loop on a vector without pre-allocation:
loopy_sample1 <- function(popn, n, num){
  result1 <- vector() # Empty vector of size 1
  for (i in 1:num){
    result1 <- c(result1, myexperiment(popn, n))
  }
  return(result1)
}


#----------------------
# --- Function 2 ------
# Runs "num" of iterations of the experiment using FOR loop on a VECTOR with preallocation
loopy_sample2 <- function(popn, n, num){
  result2 <- vector( , num) # Pre-allocate size
  for (i in 1:num){
    result2[i] <- myexperiment(popn, n)
  }
  return(result2)
}


#----------------------
# --- Function 3 ------
# Runs "num" of iterations of the experiment using FOR loop on a LIST with preallocation
loopy_sample3 <- function(popn, n, num){
  result3 <- vector("list", num) # Pre-allocate size
  for (i in 1:num){
    result3[[i]] <- myexperiment(popn, n)
  }
  return(result3)
}

#----------------------
# --- Function 4 ------
# Run "num" iterations of the experiment using LAPPLY:
lapply_sample <- function(popn, n, num){
  result4 <- lapply(1:num, function(i) myexperiment(popn, n))
  return(result4)
}


#----------------------
# --- Function 5 ------
# Run "num" iterations of the experiment using SAPPLY:
sapply_sample <- function(popn, n, num){
  result5 <- sapply(1:num, function(i) myexperiment(popn, n))
  return(result5)
}


###################################
### INITIALIZING SIMULATIONS ###
###################################

#---------- SETTING SEED ----------
set.seed(12345)
popn <- rnorm(10000)
hist(popn)

#------ SETTING SIMULATION PARAMETERS ------
n <- 1000 # sample size of experiment
num <- 100 # number of experimental iterations 


print("Using loops without preallocation on a vector took:" )
print(system.time(loopy_sample1(popn, n, num)))

print("Using loops with preallocation on a vector took:" )
print(system.time(loopy_sample2(popn, n, num)))

print("Using loops with preallocation on a list took:" )
print(system.time(loopy_sample3(popn, n, num)))

print("Using the vectorized sapply function (on a list) took:" )
print(system.time(sapply_sample(popn, n, num)))

print("Using the vectorized lapply function (on a list) took:" )
print(system.time(lapply_sample(popn, n, num)))
