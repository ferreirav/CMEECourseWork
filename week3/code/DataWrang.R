#!usr/bin/env Rscript

##------------------------------------------
## Name: DataWrang.R
## Description: Script illustrating the data wrangling techniques
## Author: Vitor Ferreira, f.ferreira22@imperial.ac.uk
## Date: October 2022
##------------------------------------------


# Clean enviroment
rm(list = ls())

# Load libraries
suppressMessages(require(reshape2, quietly = T))
suppressMessages(require(tidyverse, quietly = T))

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################


#Load the dataset 
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

# Inspect the dataset
head(MyData)
dim(MyData)
str(MyData)
# fix(MyData) #you can also do this
# fix(MyMetaData)

# Transpose
# To get those species into columns and treatments into rows 
MyData <- t(MyData)

head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
# Using melt() function from reshape2 package
MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

head(MyWrangledData)

unique(MyWrangledData$Species)
unique(MyWrangledData$Quadrat) 

hist(MyWrangledData$Count)


#### Messing with tidyverse ###

tidyverse_conflicts()
tidyverse_packages()
tidyverse_update()

filter(MyWrangledData, Count>100)

slice(MyWrangledData, 10:15)



#Tidyverse approach
MyWrangledData %>% 
  group_by(Species) %>% 
  summarise(avg = mean(Count))

# R Base approach
aggregate(MyWrangledData$Count, by = list(MyWrangledData$Species), FUN = mean)

# Rscript produces unwanted file, which is removed below
invisible(file.exists("Rplots.pdf"))
invisible(file.remove("Rplots.pdf"))
