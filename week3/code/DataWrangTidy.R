#!usr/bin/env Rscript

##------------------------------------------
## Name: DataWrangTidy.R
## Description: Script illustrating  data wrangling techniques with tidyverse
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------


# Clean enviroment
rm(list = ls())

# Load libraries
suppressMessages(require(tidyverse, quietly = T))


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
print("Data Wrangling with tidyverse...")

# Load the dataset 
MyData <- suppressMessages(read_csv("../data/PoundHillData.csv", show_col_types = FALSE))
MyData <- as.data.frame(MyData)

# Replace species absences with zeros
MyData[is.na(MyData)] <- 0

# header = true because we do have metadata headers
MyMetaData <- read_delim("../data/PoundHillMetaData.csv", delim = ";", show_col_types = FALSE)


# Transpose the data using a rudimentary technique but efficient
MyData <- MyData %>% 
  rownames_to_column() %>%
  pivot_longer(-rowname) %>% 
  pivot_wider(names_from = rowname, values_from = value)


# Removing Variable names and adding to new dataframe
TempData <- as_tibble(MyData[-1,])
colnames(TempData) <- MyData[1,]


# We will use gather() function to transform the data to long format
#ncol(TempData)
TempData <- TempData %>% gather(key = "Species",
                                 value = "Count", 5:45)


MyWrangledData <- TempData %>% 
  mutate(Cultivation = as.factor(Cultivation),
         Block = as.factor(Block),
         Plot = as.factor(Plot),
         Quadrat = as.factor(Quadrat),
         Count = as.integer(Count))

print("Done!!!")