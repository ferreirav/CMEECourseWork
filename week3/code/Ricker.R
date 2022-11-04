#!usr/bin/env Rscript

##------------------------------------------
## Name: Ricker.R
## Description: Script with Ricker Population Model function
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------


# This script introduce the Ricker model (1954) which is a population model of 
# recruitment stock in fisheries. It gives the expected density of individuals
# in generation as function of previous number of individuals from previous generation

Ricker <- function(N0=1, r=1, K=10, generations=50){
  
  # Runs simulation of the Ricker model
  # Returns a vector of length generations
  
  N <- rep(NA, generations) # Creates a vector of NA
  
  N[1] <- N0
  for (t in 2:generations)
  {
    N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K)))
  }
  return(N)
}

plot(Ricker(generations = 10), type="l")

# Rscript produces unwanted file, which is removed below
invisible(file.exists("Rplots.pdf"))
invisible(file.remove("Rplots.pdf"))
