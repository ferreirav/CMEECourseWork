#!usr/bin/env Rscript

##------------------------------------------
## Name: gompertz_models_fit.R
## Description: This script run and extract gompertz regression attributes 
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

# Data set to store gompertz growth parameters
gompertz_model_points <- data.frame()
gompertz_models_results <- data.frame()


# Model Fitting
fitting_model <- "Gompertz"


###########################################
###     Defining initial parameters     ###
###########################################

# Number of iterations and sampling size
sampling <- 25


#-------------------------------------------------------------#
#####               Gompertz Model Fitting                #####
#-------------------------------------------------------------#


for (id in unique(growth_data$ID)){
  
  # Data frame to store estimates
  temp_gompertz_model_points <- data.frame()
  
  # Getting the data subset according to id number
  growth_data_ss <- subset(growth_data, growth_data$ID == id)
  
  # Some datasets are not ordered so I order the data according to time
  # to be able to extract an estimate for time lag
  growth_data_ss <- growth_data_ss[with(growth_data_ss, order(Time)),]
  
  ##### Using OLS to extract initial estimate of the r_max #####
  linear_fit <- lm(Log_PopBio ~ Time, data = growth_data_ss)
  summary(linear_fit)
  
  # Defining initial parameters:
  initial_values <- get_initial_values_gompertz(N_0 = min(growth_data_ss$Log_PopBio),
                     K = max(growth_data_ss$Log_PopBio), 
                     r_max = coefficients(linear_fit)[[2]],
                     mean_pop = mean(growth_data_ss$Log_PopBio),
                     t_lag = growth_data_ss$Time[which.max(diff(diff(growth_data_ss$Log_PopBio)))],
                     sampling_size = sampling)
  
  # Set time points for model smooth curves
  timelength <- seq(min(growth_data_ss$Time),
                    max(growth_data_ss$Time),
                    len = (length(growth_data_ss$Time)*5))
  
  # Empty data frame to store the model parameters
  gompertz_models_parameters <- data.frame()
  
  
  ##############################
  ###     Fitting Models     ###
  ##############################
  
  
  for (i in 1:sampling){
    
    ### Gompertz Regression ###
    fit_gompertz <- try(nlsLM(Log_PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag),
                              growth_data_ss,
                              list(N_0 = initial_values[i, 1],
                                   K = initial_values[i, 2],
                                   r_max = initial_values[i, 3],
                                   t_lag = initial_values[i, 4]),
                              lower = c(initial_values[i, 1] - abs((2*initial_values[i, 1])),
                                        initial_values[i, 2] - abs((2*initial_values[i, 2])),
                                        initial_values[i, 3] - abs((2*initial_values[i, 3])),
                                        0),
                              upper = c(initial_values[i, 1] + abs((2*initial_values[i, 1])),
                                        initial_values[i, 2] + abs((2*initial_values[i, 2])),
                                        initial_values[i, 3] + abs((2*initial_values[i, 3])),
                                        initial_values[i, 4] + abs((2*initial_values[i, 4]))),
                              control = nls.lm.control(maxiter = 400)),  # nprint = 1 to inspect permutations
                        silent = F)
    
                
              if (class(fit_gompertz) == "try-error"){
                # If none of the values above fit the model I create a vector 
                # with the parameters that failed and NAs
                
                gompertz_parameters <- c(i,
                                         id,
                                         unique(growth_data_ss$Species),
                                         unique(growth_data_ss$Medium),
                                         unique(growth_data_ss$Temp),
                                         nrow(growth_data_ss),
                                         initial_values[i, 1], initial_values[i, 2], 
                                         initial_values[i, 3], initial_values[i, 4],
                                         NA, NA, NA, NA, NA, fitting_model)
                gompertz_models_parameters <- rbind(gompertz_models_parameters, gompertz_parameters)
                
                
              } else {
                # If the model fits at first with initial values do the fit
                RSS_gompertz <- sum(residuals(fit_gompertz)^2)
                AIC_gompertz <- get_AIC(fit_gompertz)
                AICc_gompertz <- get_AICc(fit_gompertz)
                BIC_gompertz <- get_BIC(fit_gompertz)
                
                
                gompertz_parameters <- c(i,
                                         id,
                                         unique(growth_data_ss$Species),
                                         unique(growth_data_ss$Medium),
                                         unique(growth_data_ss$Temp),
                                         nrow(growth_data_ss),
                                         coef(fit_gompertz)[[1]],  # N_0
                                         coef(fit_gompertz)[[2]],  # K
                                         coef(fit_gompertz)[[3]],  # r_max
                                         coef(fit_gompertz)[[4]],  # t_lag
                                         shapiro.test(residuals(fit_gompertz))[[2]],
                                         RSS_gompertz,
                                         AIC_gompertz,
                                         AICc_gompertz,
                                         BIC_gompertz,
                                         fitting_model)
                gompertz_models_parameters <- rbind(gompertz_models_parameters, gompertz_parameters)
                
                names(gompertz_models_parameters) <- c("Iteration", "ID", "Species", "Medium", "Temperature",
                                                       "SampleSize","N_0", "K", "r_max", "t_lag",  "Normality",
                                                       "RSS", "AIC", "AICc", "BIC", "Model")
                
                
                # Modelling the fit
                gompertz_points <- gompertz_model(t = timelength,
                                                  N_0 = coef(fit_gompertz)[[1]],    # N_0
                                                  K = coef(fit_gompertz)[[2]],      # K
                                                  r_max = coef(fit_gompertz)[[3]],  # r_max
                                                  t_lag = coef(fit_gompertz)[[4]])  # t_lag
                model_fit_gompertz <- data.frame(i, id, timelength, gompertz_points, fitting_model)
                names(model_fit_gompertz) <- c("Iteration", "ID", "Time", "LogPopBio", "Model")
                temp_gompertz_model_points <- rbind(temp_gompertz_model_points, model_fit_gompertz)
                names(temp_gompertz_model_points) <- c("Iteration", "ID", "Time", "LogPopBio", "Model")
                
              }
  }
  
  
  # Remove Models that have failed
  gompertz_models_parameters <- gompertz_models_parameters[!is.na(gompertz_models_parameters$RSS),]
  # Look for the best model with AIC values
  gompertz_models_parameters$AIC <- as.numeric(gompertz_models_parameters$AIC)
  gompertz_models_parameters <- gompertz_models_parameters[which.min(gompertz_models_parameters$AIC),]
  # # Look for the lowest RSS  values
  # gompertz_models_parameters$RSS <- as.numeric(gompertz_models_parameters$RSS)
  # gompertz_models_parameters <- gompertz_models_parameters[which.min(gompertz_models_parameters$RSS),]
  # Extract estimates from best model
  temp_gompertz_model_points <- temp_gompertz_model_points[temp_gompertz_model_points$Iteration == gompertz_models_parameters$Iteration,]
  gompertz_model_points <- rbind(gompertz_model_points, temp_gompertz_model_points)
  # Populate table with best model results
  gompertz_models_results <- rbind(gompertz_models_results, gompertz_models_parameters)
  names(gompertz_models_results) <- c("Iteration", "ID", "Species", "Medium",
                                         "Temperature", "SampleSize", "N_0", "K",
                                         "r_max", "t_lag", "Normality", "RSS", "AIC",  "AICc", "BIC", "Model")
  }


# Create directory
dir.create("../results/models_fitted_data/", showWarnings = F)

# Write model in csv
write.csv(gompertz_model_points, "../results/models_fitted_data/gompertz_model_estimates.csv", row.names = F)
write.csv(gompertz_models_results, "../results/models_fitted_data/gompertz_model_results.csv", row.names = F)


