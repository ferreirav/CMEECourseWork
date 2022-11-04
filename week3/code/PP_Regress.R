#!usr/bin/env Rscript

##------------------------------------------
## Name: PP_Regress.R
## Description: This script tries to replicate the plotting suggested from 
##              Samraat Pawar at the TheMulQuaBio repo 
##              (https://mhasoba.github.io/TheMulQuaBio/notebooks/08-Data_R.html#id3)
##              and additionally produces its Linear Models results into a CSv 
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: EcolArchives-E089-51-D1.csv
## Outputs: PP_Regress_figure.pdf, PP_Regress_Results.csv
##------------------------------------------

# Clean enviroment
rm(list = ls())

# Clear graphics
graphics.off()

# Load libraries
suppressMessages(require(tidyverse, quietly = T))

# Load data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Factoring variables
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
MyDF$Predator.lifestage <- as.factor(MyDF$Predator.lifestage)
MyDF$Predator.taxon <- as.factor(MyDF$Predator.taxon)
#glimpse(MyDF)  # Inspecting data structure

# Adjusting measures of weight and units
MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] <-  MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] / 1000
MyDF[MyDF == "mg"] = "g"



##----------------------------------#
#           Plotting                #
##----------------------------------#

figure <- ggplot(MyDF, aes(x = log10(Prey.mass), y = log10(Predator.mass), color = Predator.lifestage)) + 
  geom_point(aes(shape = I(3))) +
  geom_smooth(method = "lm", fullrange = T) +
  facet_grid(Type.of.feeding.interaction~.) +
  xlab("Prey Mass in grams") +
  ylab("Predator mass in grams") +
  scale_x_continuous(breaks = c(-7, -3, 1), labels = c("1e-07", "1e-03", "1e+01")) +
  scale_y_continuous(breaks = c(-6, -2, +2, +6), labels = c("1e-06", "1e-02", "1e+02", "1e+06")) +
  theme_bw() +
  guides(color = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom")


pdf("../results/PP_Regress_figure.pdf", width = 7.6, height = 10)
print(figure)
dev.off()


##----------------------------------#
#     Performing Linear Models      #
##----------------------------------#

# Setting te column names
lm_parameter_names <- c("Consumer Type", "Life stage", "Intercept", "Regression Slope",
                        "R_Squared", "F-Statistics", "Pvalue")

# Creating empty matrix to store parameters
PP_df <- as.data.frame(matrix(NA, nrow = 0, ncol = 7))

for (guild in unique(MyDF$Type.of.feeding.interaction)){
  guild_par <- subset(MyDF, MyDF$Type.of.feeding.interaction == guild)
  
  for (stage in unique(guild_par$Predator.lifestage)){
    lifestage_par <- subset(guild_par, guild_par$Predator.lifestage == stage)
    
    if (nrow(lifestage_par) > 2){  # If the data has more then 2 observations
      linear_mod <- summary(lm(log10(lifestage_par$Predator.mass)~log10(lifestage_par$Prey.mass)))
      
      model_results <- c(guild,
                            stage,
                            round(linear_mod$coefficients[[1]], 5),  # Intercept
                            round(linear_mod$coefficients[[2]], 5),  # Slope
                            round(linear_mod$r.squared, 5),          # R Squared
                            round(linear_mod$fstatistic[[1]], 5),    # F Statistics
                            linear_mod$coefficients[[2,4]]           # P Value
                            )
      
      PP_df <- rbind(PP_df, model_results)  # Attach to data frame
    }
  }
}

colnames(PP_df) <- lm_parameter_names
PP_df[, c(3:7)] <- sapply(PP_df[, c(3:7)], as.numeric)  # defining numeric cells

# Saving file to csv
write.csv(PP_df, "../results/PP_Regress_Results.csv", row.names = F)

