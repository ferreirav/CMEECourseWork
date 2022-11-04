#!usr/bin/env Rscript

##------------------------------------------
## Name: PP_Dists.R
## Description: This script analyses the Bodymass distributions and produces 
##              individual and ratio plots, and a results summary file
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: EcolArchives-E089-51-D1.csv
## Outputs: Pred_subplots.pdf, Prey_subplots.pdf, SizeRatio_subplots.pdf,
##          PP_results.csv
##------------------------------------------

# Clean enviroment
rm(list = ls())

# Clear graphics
graphics.off()

# Load libraries
suppressMessages(require(tidyverse, quietly = T))

# Initialising analysis
print("Running Bodymass Distributions...")

# Load data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
# glimpse(MyDF)  # Inspecting data structure

# Factoring variables
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)

# Adjusting measures of weight and units
MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] <-  MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] / 1000
MyDF[MyDF == "mg"] = "g"

# Data Histogram
hist(log10(MyDF$Predator.mass), breaks = 20, col = rgb(1, 0, 0, 0.5),
     xlab = "Log10(Body Mass (g))", ylab = "Count",
     main = "Predator-prey size overlap")
hist(log10(MyDF$Prey.mass), breaks = 20, add = T, col = rgb(0, 1, 0, 0.5))
legend("topleft", c("Predator", "Prey"),
       fill = c(rgb(1, 0, 0, 0.50), rgb( 0, 1, 0, 0.5)))



##----------------------------------#
#           Plotting                #
##----------------------------------#

# Predator Biomass Distribution
pdf("../results/Pred_subplots.pdf",  # Opening PDF
    width = 11.7, height = 8.3)     # Setting document dimensions in inches
hist(log10(MyDF$Predator.mass), breaks = 20, col = rgb(1, 0, 0, 0.5),
     xlab = "Log10(Body Mass (g))", ylab = "Count",
     main = "Predator Bodymass")
dev.off()

# Prey Biomass Distribution
pdf("../results/Prey_subplots.pdf",
    width = 11.7, height = 8.3)
hist(log10(MyDF$Prey.mass), breaks = 20, col = rgb(0, 1, 0, 0.5),
     xlab = "Log10(Body Mass (g))", ylab = "Count",
     main = "Prey Bodymass")
dev.off()

# Prey-Predator Mass Ratios
MyDF <- MyDF %>% 
  mutate(PPMR = log10(Prey.mass / Predator.mass))

# Plotting rations

pdf("../results/SizeRatio_subplots.pdf", width = 11.7, height = 8.3)
par(mfrow = c(3, 2))  # defining plotting parameters
for (guild in unique(MyDF$Type.of.feeding.interaction)){
  temp <- subset(MyDF, MyDF$Type.of.feeding.interaction == guild)
  hist(temp$PPMR, breaks = 20, main = guild,
       xlab = "Predator-Prey Mass Ratios",
       ylab = "Counts")
  rm(temp)
  }
dev.off()



##----------------------------------#
#       Centrality Measures         #
##----------------------------------#

# Log Means and Medians Calculation

Centrality_feeding <- MyDF %>% 
  group_by(Type.of.feeding.interaction) %>% 
  summarise(LogPred_mean = round(mean(log10(Predator.mass)), 3),
            LogPred_median = round(median(log10(Predator.mass)), 3),
            LogPrey_mean = round(mean(log10(Prey.mass)), 3),
            LogPrey_median = round(median(log10(Prey.mass)), 3),
            LogPPMR_mean = round(mean(PPMR), 3),
            LogPPMR_median = round(median(PPMR), 3))


# Write output to table
write.csv(Centrality_feeding, "../results/PP_results.csv", row.names = F)
print("Completed!!!")
