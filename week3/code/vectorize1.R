#!usr/bin/env Rscript

##------------------------------------------
## Name: vectorize.R
## Description: This script illustrates the differences using normal operations
##              against in-built functions that uses vectorization
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clear environmnet
rm(list = ls())


#===========================
# Vectorization
#===========================


M <- matrix(runif(1000000), 1000, 1000)

SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot <- Tot + M[i, j]
    }
  }
  return(Tot)
}


print("Testing loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))


