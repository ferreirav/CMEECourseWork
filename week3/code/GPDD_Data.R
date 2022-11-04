#!usr/bin/env Rscript

##------------------------------------------
## Name: GPDD_Data.R
## Description: This script plots the distributions of populations form GPDD database
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: GPDDFiltered.RData
## Outputs: GPDD_populations.pdf
##------------------------------------------


# Clean enviroment
rm(list = ls())

# # Clear graphics
# graphics.off()

# Load libraries
suppressMessages(require(tidyverse, quietly = T))
suppressMessages(require(maps, quietly = T))

# Load data
load("../data/GPDDFiltered.RData")

# Get the world data for the outlines of continents
world_data <- map_data("world")

print("Creating world map distribution of populations from GPDD database...")

# Plotting the world map
wmap <- ggplot() +
  geom_polygon(data = world_data, aes(x = long, y = lat, group = group), 
               fill = "light grey", color = "black") +
  coord_fixed(1.3) +
  geom_point(data = gpdd, aes(x = long, y = lat), col = "red", size = 0.8) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank()
  )

pdf("../results/GPDD_populations.pdf", width = 11.7, height = 8.3)
print(wmap)
dev.off()

print("Done!!! Populations distribution map can be found in the results folder!!!")


#--------------------------------#
#         Comments               #
#--------------------------------#


# It is to note that the distribution of the populations is biased towards north.
# Most of the species found in the dataset are located either in North America or Europe.
# It is suggested that the analysis of this dataset should be done carefully and accounting for this effect.
# 
#

