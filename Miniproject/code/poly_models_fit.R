#!usr/bin/env Rscript

##------------------------------------------
## Name: poly_models_fit.R
## Description: This script run and extract linear models attributes 
##              from polynomial fittings
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: November 2022
##------------------------------------------


# Clean environments
rm(list = ls())
graphics.off()

# Load libraries
require(tidyverse)
require(minpack.lm)

# Loading data and sourcing functions
growth_data <- read.csv("../results/cleaned_data/growth_data.csv")
source("model_fitting_functions.R")

# Initializing data set
poly_models <- data.frame()
poly_models_results <- data.frame()


#-------------------------------------------------------------#
#####               Polynomials Model fitting             #####
#-------------------------------------------------------------#
for (id in unique(growth_data$ID)){
  
  growth_data_ss <- subset(growth_data, growth_data$ID == id)

  # Set time points for model smooth curves
  timelength <- seq(min(growth_data_ss$Time),
                    max(growth_data_ss$Time),
                    len = (length(growth_data_ss$Time)*5))
  
  
  ##############################
  ###     Fitting Models     ###
  ##############################
  
  ### Quadratic ###
  QuaFit <- try(lm(Log_PopBio ~ poly(Time, 2), data = growth_data_ss))
  summary(QuaFit)
  PredictQuaFit <- predict.lm(QuaFit,
                               data.frame(Time = timelength))
  model_fit_qua <- data.frame( id, timelength, PredictQuaFit)
  model_fit_qua$Model <- "Quadratic"
  names(model_fit_qua) <- c( "ID", "Time", "LogPopBio", "Model")
  RSS_quadratic <- sum(residuals(QuaFit)^2)
  AIC_quadratic <- get_AIC(QuaFit)
  AICc_quadratic <- get_AICc(QuaFit)
  BIC_quadratic <- get_BIC(QuaFit)
  
  
  # Getting model parameters
  ID_parameters <- c(unique(growth_data_ss$ID),
                     unique(growth_data_ss$Species),
                     unique(growth_data_ss$Medium),
                     unique(growth_data_ss$Temp),
                     nrow(growth_data_ss),
                     coef(QuaFit)[[1]],
                     coef(QuaFit)[[2]],
                     coef(QuaFit)[[3]],
                     NA,
                     shapiro.test(QuaFit$residuals)[[2]],
                     RSS_quadratic,
                     AIC_quadratic,
                     AICc_quadratic,
                     BIC_quadratic,
                     "Quadratic")
  
  poly_models_results <- rbind(poly_models_results, ID_parameters)
  
  
  ### Cubic ###
  CubFit <- try(lm(Log_PopBio ~ poly(Time, 3), data = growth_data_ss))
  summary(CubFit)
  PredictCubFit <- predict.lm(CubFit,
                              data.frame(Time = timelength))
  model_fit_cub <- data.frame( id, timelength, PredictCubFit)
  model_fit_cub$Model <- "Cubic"
  names(model_fit_cub) <- c( "ID", "Time", "LogPopBio", "Model")
  RSS_cubic <- sum(residuals(CubFit)^2)
  AIC_cubic <- get_AIC(CubFit)
  AICc_cubic <- get_AICc(CubFit)
  BIC_cubic <- get_BIC(CubFit)
  
  
  # Getting model parameters
  ID_parameters <- c(unique(growth_data_ss$ID),
                     unique(growth_data_ss$Species),
                     unique(growth_data_ss$Medium),
                     unique(growth_data_ss$Temp),
                     nrow(growth_data_ss),
                     coef(CubFit)[[1]],
                     coef(CubFit)[[2]],
                     coef(CubFit)[[3]],
                     coef(CubFit)[[4]],
                     shapiro.test(CubFit$residuals)[[2]],
                     RSS_cubic,
                     AIC_cubic,
                     AICc_cubic,
                     BIC_cubic,
                     "Cubic")
  
  
  ### Merging Datasets ###
  poly_models <- rbind(poly_models, model_fit_qua, model_fit_cub)
  poly_models_results <- rbind(poly_models_results, ID_parameters)
  
  
  
  #print(paste("Done for", id))
  
}

# Defining Column names
names(poly_models_results) <- c("ID", "Species", "Medium", "Temperature",
                                "SampleSize", "Intercept", "a", "b", "c", 
                                "Normality", "RSS", "AIC", "AICc", "BIC", "Model")

dir.create("../results/models_fitted_data/", showWarnings = F)
# Write model in csv
write.csv(poly_models, "../results/models_fitted_data/polynomial_estimates.csv", row.names = F)
write.csv(poly_models_results, "../results/models_fitted_data/poly_models_results.csv", row.names = F)

