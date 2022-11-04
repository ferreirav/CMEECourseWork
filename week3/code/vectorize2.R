#!usr/bin/env Rscript

##------------------------------------------
## Name: vectorize2.R
## Description: This script contains  one solution for the problem of the Ricker
##              model provided by Samraat Pawar located in the TheMulQuaBio repo
##              (https://mhasoba.github.io/TheMulQuaBio/notebooks/08-Data_R.html#id3)
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: none
## Outputs: none
## Options: none
##------------------------------------------

# Clean enviroment
rm(list = ls())


# Runs the stochastic Ricker equation with gaussian fluctuations
set.seed(12345)

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}


# Stochastic Rickel function vectorized
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  
  N <- matrix(NA, numyears, length(p0))  # Initialize empty matrix
  
  
  # My proposal of efficiency for the model is to remove one loop that would 
  # iterate over the populations and provide a vector with same size of population
  # with random numbers at each year
  
  N[1, ] <- p0 # Here we set initial parameters for the populations at Year 1
               # according to the random numbers generated from runif()
  
  for (yr in 2:numyears){ # Here we will loop over the years across all populations
      
      N[yr, ] <- N[yr-1, ] * exp(r * (1 - N[yr - 1, ] / K) + rnorm(length(p0), 0, sigma))
      
    }
    
  return(N)
}


# Printing system times
print("Vectorized Stochastic Ricker takes:")
print(system.time(res <- stochrick()))

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2 <- stochrickvect()))

