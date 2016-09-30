library(shiny)
library(ggplot2)
library(dplyr)
library(ggthemes)

# Read data into data frame
crimeData <- readRDS(file="data/crimeData.Rda")

# Create input choice list
crime.hoods <<- sort(unique(crimeData$neighborhood))
crime.types <<- sort(unique(crimeData$offense))
