#!usr/bin/env Rscript

##------------------------------------------
## Name: model_fitting_functions.R
## Description: This script contains the functions for model fitting
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: November 2022
##------------------------------------------



#############################################################
###                       FUNCTIONS                       ###
#############################################################


### Models for implementation ####
# Logistic Model
logistic_model <- function(t, r_max, K, N_0){
  return(log(N_0) + log(K) + r_max * t - log(K + N_0 * (exp(r_max * t) - 1)))
}
# Gompertz Model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}


### AIC ###
get_AIC <- function(fitted_model){
  if (class(fitted_model) == "nls"){
    n <- nrow(eval(fitted_model$data))} 
  
  else if(class(fitted_model) == "lm"){
    n <- nrow(eval(fitted_model$model))}
  
    RSS <- sum(residuals(fitted_model)^2)
    model_parameters <- length(coef(fitted_model))
    AIC_implemented <- n + 2 + n *log(( 2 * pi ) / n) + n * log(RSS) + 2 * model_parameters
    return(AIC_implemented)
}


### AICc ###
get_AICc <- function(fitted_model){
  if (class(fitted_model) == "nls"){
    n <- nrow(eval(fitted_model$data))} 
  
  else if(class(fitted_model) == "lm"){
    n <- nrow(eval(fitted_model$model))}
  
  RSS <- sum(residuals(fitted_model)^2)
  model_parameters <- length(coef(fitted_model))
  AICc_implemented <- n + 2 + n *log(( 2 * pi ) / n) + n * log(RSS) + (((2*model_parameters) * (model_parameters + 1)) / (n - model_parameters - 1))
  return(AICc_implemented)
}


### BIC ###
get_BIC <- function(fitted_model){
  if (class(fitted_model) == "nls"){
    n <- nrow(eval(fitted_model$data))} 
  
  else if(class(fitted_model) == "lm"){
    n <- nrow(eval(fitted_model$model))}
  
  RSS <- sum(residuals(fitted_model)^2)
  model_parameters <- length(coef(fitted_model))
  BIC_implemented <- n + 2 + n *log(( 2 * pi ) / n) + n * log(RSS) + (log(n) * (model_parameters + 1))
  return(BIC_implemented)
}



### Get Initial Values - Logistic ###
get_initial_values_logistic <- function(N_0, K, r_max, t_lag = 1, mean_pop, sampling_size){
  N_0_start <- runif(sampling_size, min = N_0, max = (N_0+mean_pop))
  K_start <- runif(sampling_size, min = (K-mean_pop), K)
  r_max_start <- runif(sampling_size, r_max, (2*r_max))
  t_lag_start <- runif(sampling_size, min = 0, max = (2*t_lag))
  starting_values <- data.frame(N_0_start, K_start, r_max_start, t_lag_start)
  return(starting_values)
}


### Get Initial Values - Gompertz ###
get_initial_values_gompertz <- function(N_0, K, r_max, t_lag = 1, mean_pop, sampling_size){
  N_0_start <- rnorm(sampling_size, N_0, 1)
  K_start <- rnorm(sampling_size, K, 1)
  r_max_start <- rnorm(sampling_size, r_max, 1)
  t_lag_start <- rnorm(sampling_size, t_lag, 1)
  starting_values <- data.frame(N_0_start, K_start, r_max_start, t_lag_start)
  return(starting_values)
}

