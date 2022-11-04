#!usr/bin/env Rscript

##------------------------------------------
## Name: R_conditional.R
## Description: R script for testing functions with conditionals
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())


print("Testing functions with conditionals:")


# Check if integer is even or odd!!!
is.even <- function(n = 2) {
  print(paste("*** Is even or odd? n =", n, "***"))
  if (n %% 2 == 0) {
    return(paste(n,'is even!'))
  } else {
    return(paste(n,'is odd!'))
  }
}
print(is.even(6))


##------------------------------------------
# Checks if a number is a power of 2
is.power2 <- function(n = 2) {
  print(paste("*** Is",  n, "the power of 2 ***"))
  if (log2(n) %% 1==0) {
    return(paste(n, 'is a power of 2!'))
  } else {
    return(paste(n,'is not a power of 2!'))
  }
}

print(is.power2(4))


##------------------------------------------
# Checks if a number is prime
is.prime <- function(n) {
  print(paste("*** Is",  n, "a prime? ***"))
  if (n==0) {
    return(paste(n,'is a zero!'))
  } else if (n==1) {
    return(paste(n,'is just a unit!'))
  }
  
  ints <- 2:(n-1)
  
  if (all(n%%ints!=0)) {
    return(paste(n,'is a prime!'))
  } else {
    return(paste(n,'is a composite!'))
  }
}

print(is.prime(3))




