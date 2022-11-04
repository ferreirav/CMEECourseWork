#!usr/bin/env Rscript

##------------------------------------------
## Name: try.R
## Description: This script illustrate the use of techniques to capture errors
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())


# Defining function
doit <- function(x) {
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) { # ensuring enough sample size
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique values!")
  }
}


# Generating population
set.seed(1345)
popn <- rnorm(50)
hist(popn)

# Sampling over for 15 times
# lapply(1:15, function(i) doit(popn)) # It will generaly break
result <- lapply(1:15, function(i) try(doit(popn), TRUE)) # here silent is set to FALSE
result


# Example of storing manually the results above
result <- vector("list", 15)  # pre allocation of memory space
for (i in 1:15){
  result[[i]] <- try(doit(popn), TRUE)  # did not set silent as it is by default set to FALSE
}

