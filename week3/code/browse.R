#!usr/bin/env Rscript

##------------------------------------------
## Name: browse.R
## Description: This script tests for debugging steps using different functions
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------


# Clean enviroment
rm(list = ls())


# Testing browser() function
Exponential <- function(N0 = 1, r = 1, generations = 10) {
  # Runs a simulation of exponential growth
  # Returns a vector of length generations
  
  N <- rep(NA, generations)    # Pre-allocation of memory in empty vector
  
  N[1] <- N0
  for (t in 2:generations) {
    N[t] <- N[t-1] * exp(r)
    # browser()
  }
  return (N)
}

Exponential(10)
plot(Exponential(), type="l", main="Exponential growth")

# # Rscript produces unwanted file, which is removed below
# invisible(file.exists("Rplots.pdf"))
# invisible(file.remove("Rplots.pdf"))
