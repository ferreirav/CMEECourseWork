#!usr/bin/env Rscript

##------------------------------------------
## Name: apply2.R
## Description: Testing family of apply functions
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------


# Clean enviroment
rm(list = ls())


#=============================
# Using apply() functions
#=============================
set.seed(10)

SomeOperation <- function(v){
  if (sum(v) > 0) {
    return(v * 100)
  } else {
    return (v)
  }
}

M <- matrix(rnorm(100), 10, 10)
print(apply(M, 1, SomeOperation))

# Apply function here feeds the whole row of matrix (M) into the function;
# evaluates it as the sum(v), this case is sum(M[1,]), and it will store as column
# which needs to be transposed afterwards to return to its original structure
a <- apply(M, 1, SomeOperation)
a <- t(a)
a

