#!usr/bin/env Rscript

##------------------------------------------
## Name: DataHandling.R
## Description: This script loads the data and do some cleaning and data preparation
##              for further model fitting and analysis
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: November 2022
##------------------------------------------

# Clean environments
rm(list = ls())
graphics.off()

# Load libraries
require(tidyverse)

# Load data
df <- read.csv("../data/LogisticGrowthData.csv")
df_metadata <- read.csv("../data/LogisticGrowthMetaData.csv")


#############################################################
###             DATA WRANGLING AND EXPLORATION            ###
#############################################################
dir.create("../results/cleaned_data/", showWarnings = FALSE)

growth_data <- df[,-1]

# Removing PopBio lower than zero
growth_data <- subset(growth_data, growth_data$PopBio > 0)
growth_data <- subset(growth_data, growth_data$Time >= 0)

# In some of the papers we found the time to be mistyped
# https://doi.org/10.1016/0740-0020(87)90033-5
citations <- growth_data[growth_data$Time > 1000,]
citation_IDs <- unique(citations$Citation)
citation_IDs
# So I have transformed their experiment hours into days
# Which actually correspond to the actual experiment hours, as seen in the paper
growth_data$Time[growth_data$Citation == citation_IDs[2]] <- (growth_data$Time[growth_data$Citation == citation_IDs[2]] / 24)

# Log Transformation of the Population Biomass
growth_data <- growth_data %>% 
  mutate(Log_PopBio = log(PopBio))  

# Create single IDs for unique combinations
growth_data <- growth_data %>% 
  group_by(Medium, Species, Temp, Citation) %>% 
  mutate(ID = cur_group_id())
# Removing IDs with less than 5 observations
growth_data <- growth_data %>% 
  group_by(ID) %>% 
  filter(n() > 5)
growth_data$ID <- as.factor(growth_data$ID)

write.csv(growth_data, "../results/cleaned_data/growth_data.csv", row.names = F)
