#!usr/bin/env Rscript

##------------------------------------------
## Name: model_analysis.R
## Description: This script extends the analysis of model fitting
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: December 2022
##------------------------------------------


# Clean environments
rm(list = ls())
graphics.off()


# Load packages
require(tidyverse)

# Load results from model fitting
logistic_models <- read_csv("../results/models_fitted_data/logistic_model_results.csv", col_names = T)
poly_models <- read_csv("../results/models_fitted_data/poly_models_results.csv", col_names = T)
gompertz_models <- read_csv("../results/models_fitted_data/gompertz_model_results.csv", col_names = T)


# Cleaning data and agthering just relevant variables
logistic_models <- logistic_models[,-1]
gompertz_models <- gompertz_models[,-1]
cols_toKeep <- c("ID", "Species", "Medium", "Temperature", "SampleSize", 
                 "Normality", "RSS", "AIC", "AICc", "BIC", "Model")

logistic_models <- logistic_models[,cols_toKeep]
poly_models <- poly_models[,cols_toKeep]
gompertz_models <- gompertz_models[,cols_toKeep]


full_models <- rbind(poly_models, logistic_models, gompertz_models)
full_models <- as.data.frame(full_models)
full_models$ID <- as.factor(full_models$ID)
full_models$Medium<- as.factor(full_models$Medium)
full_models$Model <- as.factor(full_models$Model)
str(full_models)


###################################
#### Summary of model fitting #####
###################################


# Total Fits per model
total_models <- 267
Quadratic <- nrow(poly_models[poly_models$Model == "Quadratic",]) / total_models
Cubic <- nrow(poly_models[poly_models$Model == "Cubic",]) / total_models
logistic <- nrow(logistic_models[logistic_models$Model == "Logistic",]) / total_models
gompertz <- nrow(gompertz_models[gompertz_models$Model == "Gompertz",]) / total_models

# Best model fit
# For AIC
extracting_best_models <- full_models %>% group_by(ID) %>% slice(which.min(AIC))
AIC_best_models <- extracting_best_models %>% group_by(Model) %>% 
  summarise(AIC = n())

extracting_best_models <- full_models %>% group_by(ID) %>% slice(which.min(AICc))
AICc_best_models <- extracting_best_models %>% group_by(Model) %>% 
  summarise(AICc = n())

extracting_best_models <- full_models %>% group_by(ID) %>% slice(which.min(BIC))
BIC_best_models <- extracting_best_models %>% group_by(Model) %>% 
  summarise(BIC = n())


best_models <- left_join(AIC_best_models, AICc_best_models, by = "Model") %>% 
  left_join(., BIC_best_models, by = "Model")

best_models_proportions <- data.frame("Model" = best_models$Model,
                                      "AIC_prop_fits" = round((best_models$AIC/sum(best_models$AIC)*100), 0),
                                      "AICc_prop_fits" = round((best_models$AICc/sum(best_models$AICc)*100), 0),
                                      "BIC_prop_fits" = round((best_models$BIC/sum(best_models$BIC)*100), 0))



best_models_proportions <- as.data.frame(t(best_models_proportions))
best_models_proportions <- transform(best_models_proportions, Cubic = as.numeric(Cubic))

str(best_models_proportions)
ggplot(full_models, aes(Model, AIC)) +
  geom_boxplot(aes(color = Model))


png("../results/model_fit_AICc.png")
barplot(best_models_proportions$AICc_prop_fits,
        names.arg = best_models_proportions$Model,
        xlab = "Model",
        ylab = "Proportion (%)",
        main = "Model selection using AICc",
        ylim = c(0, 60))
graphics.off()

png("../results/model_fit_BIC.png")
barplot(best_models_proportions$BIC_prop_fits,
        names.arg = best_models_proportions$Model,
        xlab = "Model",
        ylab = "Proportion (%)",
        main = "Model selection using BIC",
        ylim = c(0, 70))
graphics.off()


