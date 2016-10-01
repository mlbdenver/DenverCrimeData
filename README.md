### Introduction

This Shiny app and related Slidify presentation are the elements of the Final Project for the Johns Hopkins Data Science Specialization Data Products course. 

### Data Source

The data in this app are sourced from the Denver Open Data Catalog (https://www.denvergov.org/opendata). There are a number of issues with the data that are taken into consideration during the cleaning and preparation of the data for this app.

1. The City of Denver, in 2013, began incorporating crime data using the Uniform Summons & Complaint system (https://www.denvergov.org/content/dam/denvergov/Portals/720/documents/statistics/USC_information.pdf). This data was not previously captured in the crime data. It appears that the data provided by this system was captured in "All other crimes" category. (offense_category_id = all-other-crimes). As this data was not reflected in years prior to 2013, this analysis eliminates that category in all years.
2. As of September 29, 2016, there appeared to be a significant number of missing data observations from the years 2011 and 2012 in the downloaded data set. I alerted the City's data team to the missing data. As this analysis drops all current-year data anyway, this analysis and app uses data downloaded as of March 17, 2016.
3. The R file denverData.R provides code for cleaning and preparing the data set, which is saved as crimeData.Rda. This dataset is used in the Shiny app. 

### Shiny App

The Shiny app can be found [here] (https://mlbdenver.shinyapps.io/denvercrimedata/)

To use the app:

1. Select the neighborhood for which you'd like to see crime data.
2. Either leave "All crimes" selected to see all reportable crimes, or choose "Select Individual Categories" to seee a list of crimes from which to choose. You can select any combination of crime categories.

### Presentation Slides

A short slide deck about the app can be found [here] (http://rpubs.com/mlbdenver/denvercrimedata)