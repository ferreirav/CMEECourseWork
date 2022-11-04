#!usr/bin/env Rscript

##------------------------------------------
## Name: control_flow.R
## Description: Script illustrating the use of control flow statements
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

# IF statements

a <- TRUE
if (a == TRUE) {
  print("a is TRUE")
} else {
  print("a is FALSE")
}


# Generates uniform random numbers
z <- runif(1)
if (z <= 0.5) {
  print ("Less than a half")
}


# FOR loops
for (i in 1:10) {
  j <- i * i
  print(paste(i, "squared is", j))
}


# FOR loops on strings
for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
  print(paste('The species is', species))
}


# WHILE loops
i <- 0
while (i < 10) {
  i <- i+1
  print(i^2)
}


print("Script is completed!!!!")


