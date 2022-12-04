#!usr/bin/env Rscript

##------------------------------------------
## Name: logistic_models_fit.R
## Description: This script run and extract logistic regression attributes 
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

# Data set to store logistic growth parameters
logistic_model_points <- data.frame()
logistic_models_results <- data.frame()


# Model Fitting
fitting_model <- "Logistic"


###########################################
###     Defining initial parameters     ###
###########################################

# Number of iterations and sampling size
sampling <- 30


#-------------------------------------------------------------#
#####               Logistic Model Fitting                #####
#-------------------------------------------------------------#


for (id in unique(growth_data$ID)){
  
  # Data frame to store estimates
  temp_logistic_model_points <- data.frame()
  
  # Getting the data subset according to id number
  growth_data_ss <- subset(growth_data, growth_data$ID == id)
  
  ##### Using OLS to extract initial estimate of the r_max #####
  linear_fit <- lm(Log_PopBio ~ Time, data = growth_data_ss)
  summary(linear_fit)
  
  # Defining initial parameters:
  initial_values <- get_initial_values_logistic(N_0 = min(growth_data_ss$PopBio),
                     K = max(growth_data_ss$PopBio), 
                     r_max = coefficients(linear_fit)[[2]],
                     mean_pop = mean(growth_data_ss$PopBio),
                     sampling_size = sampling)
  
  # Set time points for model smooth curves
  timelength <- seq(min(growth_data_ss$Time),
                    max(growth_data_ss$Time),
                    len = (length(growth_data_ss$Time)*5))
  
  # Empty data frame to store the model parameters
  logistic_models_parameters <- data.frame()
  
  ##############################
  ###     Fitting Models     ###
  ##############################
  
  
  for (i in 1:sampling){
    
    ### Logistic Regression ###
    fit_logistic <- try(nlsLM(Log_PopBio ~ logistic_model(t = Time, r_max, K, N_0),
                              growth_data_ss,
                              list(N_0 = initial_values[i, 1],
                                   K = initial_values[i, 2],
                                   r_max = initial_values[i, 3]),
                              lower = c(0, 0, 0),
                              upper = c(initial_values[i, 1] + abs((2*initial_values[i, 1])),
                                        initial_values[i, 2] + abs((2*initial_values[i, 2])),
                                        initial_values[i, 3] + abs((2*initial_values[i, 3]))),
                              control = nls.lm.control(maxiter = 200)),  # nprint = 1 to inspect iterations
                        silent = T)
    
                
              if (class(fit_logistic) == "try-error"){
                # If none of the values above fit the model I create a vector 
                # with the parameters that failed and NAs
                
                logistic_parameters <- c(i,
                                         id,
                                         unique(growth_data_ss$Species),
                                         unique(growth_data_ss$Medium),
                                         unique(growth_data_ss$Temp),
                                         nrow(growth_data_ss),
                                         initial_values[i, 1], initial_values[i, 2], 
                                         initial_values[i, 3], NA, NA, NA, NA, NA, fitting_model)
                logistic_models_parameters <- rbind(logistic_models_parameters, logistic_parameters)
                
                
              } else {
                # If the model fits at first with initial values do the fit
                RSS_logistic <- sum(residuals(fit_logistic)^2)
                AIC_logistic <- get_AIC(fit_logistic)
                AICc_logistic <- get_AICc(fit_logistic)
                BIC_logistic <- get_BIC(fit_logistic)
                
                
                logistic_parameters <- c(i, 
                                         id,
                                         unique(growth_data_ss$Species),
                                         unique(growth_data_ss$Medium),
                                         unique(growth_data_ss$Temp),
                                         nrow(growth_data_ss),
                                         coef(fit_logistic)[[1]],  # N_0
                                         coef(fit_logistic)[[2]],  # K
                                         coef(fit_logistic)[[3]],  # r_max
                                         shapiro.test(residuals(fit_logistic))[[2]],
                                         RSS_logistic,
                                         AIC_logistic,
                                         AICc_logistic,
                                         BIC_logistic,
                                         fitting_model)
                logistic_models_parameters <- rbind(logistic_models_parameters, logistic_parameters)
                
                names(logistic_models_parameters) <- c("Iteration", "ID", "Species", "Medium", "Temperature",
                                                       "SampleSize","N_0", "K", "r_max", "Normality",
                                                       "RSS", "AIC", "AICc", "BIC", "Model")
                # Modelling the fit
                logistic_points <- logistic_model(t = timelength,
                                                  N_0 = coef(fit_logistic)[[1]],    # N_0
                                                  K = coef(fit_logistic)[[2]],      # K
                                                  r_max = coef(fit_logistic)[[3]])  # r_max
                model_fit_logistic <- data.frame(i, id, timelength, logistic_points, fitting_model)
                names(model_fit_logistic) <- c("Iteration", "ID", "Time", "LogPopBio", "Model")
                temp_logistic_model_points <- rbind(temp_logistic_model_points, model_fit_logistic)
                names(temp_logistic_model_points) <- c("Iteration", "ID", "Time", "LogPopBio", "Model")
              }
  }
  
  # Remove Models that have failed
  logistic_models_parameters <- logistic_models_parameters[!is.na(logistic_models_parameters$RSS),]
  # Look for the best model with AIC values
  logistic_models_parameters$AIC <- as.numeric(logistic_models_parameters$AIC)
  logistic_models_parameters <- logistic_models_parameters[which.min(logistic_models_parameters$AIC),]
  # # Look for the lowest RSS values
  # logistic_models_parameters$RSS <- as.numeric(logistic_models_parameters$RSS)
  # logistic_models_parameters <- logistic_models_parameters[which.min(logistic_models_parameters$RSS),]
  # Extract estimates from best model
  temp_logistic_model_points <- temp_logistic_model_points[temp_logistic_model_points$Iteration == logistic_models_parameters$Iteration,]
  logistic_model_points <- rbind(logistic_model_points, temp_logistic_model_points)
  # Populate table with best model results
  logistic_models_results <- rbind(logistic_models_results, logistic_models_parameters)
  names(logistic_models_results) <- c("Iteration", "ID", "Species", "Medium",
                                      "Temperature", "SampleSize", "N_0", "K",
                                      "r_max", "Normality", "RSS", "AIC", "AICc", "BIC", "Model")
}

# Create directory
dir.create("../results/models_fitted_data/", showWarnings = F)

# Write model in csv
write.csv(logistic_model_points, "../results/models_fitted_data/logistic_model_estimates.csv", row.names = F)
write.csv(logistic_models_results, "../results/models_fitted_data/logistic_model_results.csv", row.names = F)




