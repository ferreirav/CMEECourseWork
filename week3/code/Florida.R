#!usr/bin/env Rscript

##------------------------------------------
## Name: Florida.R
## Description: Analysis script on the practical "Is Florida getting warmer?"
#               from TheMulQuaBio repo
#               https://mhasoba.github.io/TheMulQuaBio/notebooks/07-R.html#id2
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
## Inputs: KeyWestAnnualMeanTemperature.RData
## Outputs: Florida_Temperatures.pdf, Florida_Corr_Histogram.pdf
##------------------------------------------

# Clear environmnet
rm(list = ls())

# Clear graphics
graphics.off()

print("Initialising analysis on Florida Practical...")

# Loading data
load("../data/KeyWestAnnualMeanTemperature.RData")

# Correlations between Years and Temperature
long_term_cor <- round(cor(ats$Year, ats$Temp), 2)

print("*** Plotting and saving scatterplot in results! ***")

# Initial plotting
png("../results/Florida_Temperatures.png")
plot(ats$Year, ats$Temp,
     main = "Annual Temperatures from Key West in Florida",
     xlab = "Year",
     ylab = "Temperature (\u00b0C)")
text(x = 1980, y = 24.5, paste( "r = ", long_term_cor), col = "red")
abline(lm(ats$Temp ~ ats$Year), col = "red", lty = 3, lwd = 2)
graphics.off()



print("*** Sampling data and calculating correlation coefiicients...***")
# Randomly generating samples
sample_cor <- vector( , 1000)
for (i in 1:1000){
  Temp <- sample(ats$Temp)
  sample_data <- data.frame(ats$Year, Temp)
  
  sample_cor[i] <- cor(ats$Year, sample_data$Temp)
  sample_cor <- as.numeric(sample_cor)
}

print("*** Plotting and saving coefficent histogram in results! ***")
# Plotting Histogram
png("../results/Florida_Corr_Histogram.png")
hist(sample_cor, breaks = 50, 
     main = "Histogram of Sampled Correlations",
     xlab = "Correlations Coefficients",
     xlim = c(-0.5, 0.5))
# abline(v = long_term_cor, lty = 3, lwd= 3, col = "red")
graphics.off()

print("Done!!!")
# Calculating P-value
# permutations > r / # total permutations
(sum((sample_cor > long_term_cor))) / 10000
