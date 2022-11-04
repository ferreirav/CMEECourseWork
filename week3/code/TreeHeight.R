#!usr/bin/env Rscript

##------------------------------------------
## Name: TrreHeight.R
## Description: This function calculates heights of trees given distance of 
##              each tree from its base and angle to its top
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: ../data/trees.csv
## Arguments: degress and distance
## Outputs: Height of trees, using same units as "distance"
##------------------------------------------

# To calculate the heights of trees, given the distance of each tree from its 
# base and angle to its top, it was used a trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)


# Clear environment
rm(list = ls())


# Defining function
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  # print(paste("Tree height is:", height))
  return (height)
}


# Loading data
tree_data <- read.csv("../data/trees.csv")

print("Calculating Tree Heights...")

# Calculating Tree Heights from trees.csv 
Height <- TreeHeight(tree_data$Angle.degrees, tree_data$Distance.m)
tree_data <- cbind(tree_data, Height)


##------------------------------------------
# Writing output to file
write.table(tree_data, "../results/TreeHts.csv", row.names = FALSE)
print("File saved in Results folder!!!")
