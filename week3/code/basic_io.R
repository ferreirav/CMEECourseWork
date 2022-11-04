#!usr/bin/env Rscript

##------------------------------------------
## Name: basic_io.R
## Description: Simple script illustrating R inputs and outputs
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------

# Clean enviroment
rm(list = ls())

# Inspecting how to work with Inputs and Outputs in R

# Load data
MyData <- read.csv("../data/trees.csv", header = TRUE) # with headers imported

# Write new file
write.csv(MyData, "../results/MyData.csv")

# Appending row to table
# This line of code only works ignoring the column names (setting append = FALSE)
write.table(MyData[1,], file = "../results/MyData.csv", append=F)

# Including row names
write.csv(MyData, "../results/MyData.csv", row.names=TRUE, col.names = FALSE)

# Ignoring column names
write.table(MyData, "../results/MyData.csv", col.names=FALSE)

# Including column names
write.table(MyData, "../results/MyData.csv", row.names=F, col.names=T)

print("Script Complete!!!")

