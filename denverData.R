  require(lubridate)
  require(dplyr)
  require(magrittr)
  require(ggplot2)
  require(tidyr)
  
  ## Download fresh data file from Data Repository
  #if (!file.exists("data")) {
  #  dir.create("data")
    #}
    
  #fileURL <- "http://data.denvergov.org/download/gis/crime/csv/crime.csv"
  #download.file(fileURL, destfile = "./data/denvercrime.csv")
  #list.files("./data")
  #dateDownloaded <- now()
  
  ## Create data frame of raw data from new data repository (original data set corrupted as of September 17, 2016)
  # rawData <- read.csv("./data/denvercrime.csv")
  
  ## Create data frame from data downlaaded in March 2016 (uncorrupted)
  rawData <- read.csv("./data/20160317crime.csv")
  # crimeData <- tbl_df(crimeData)
  
  names(rawData) %<>% tolower 
  
  ## Remove all records where IS_CRIME = 0,  FIRST_OCCURRENCE_DATE plus unnecessary columns (also removed "all other crimes due to incongruity of data")
  rd1 <- rawData %>% filter(is_crime== 1,
                            offense_category_id != "all-other-crimes", 
                            !is.na(reported_date),
                            neighborhood_id!="") %>% #drop data without neighborhood
                  select(-(is_crime:is_traffic)) %>% 
                  select(-(first_occurrence_date:last_occurrence_date)) %>%
                  select(-(incident_id:offense_type_id)) %>%
                  select(-(incident_address:precinct_id))  ## removes location details
  
  ## Rename columns, clean data, create factors, date formats
  rd2 <- rd1 %>% rename(date = reported_date) %>% rename(neighborhood = neighborhood_id) %>% rename(offense = offense_category_id) %>% arrange(date)
  
  rd2$date <- ymd_hms(as.character(rd2$date))  
  rd2$offense <- as.factor(gsub("-", " ", rd2$offense))
  rd2$neighborhood <- gsub("-", " ", rd2$neighborhood)
  rd2$neighborhood <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", rd2$neighborhood, perl=TRUE) # Gives neighborhoods title case
  rd2$neighborhood <- as.factor(rd2$neighborhood)
  
  ## Add Columns for Incident Day of the Week, Month, and hour of day
  rd3 <- rd2 %>% mutate(weekday = wday(date, label=TRUE)) %>% 
                  mutate(month = month(date, label=TRUE)) %>% 
                  mutate(dayofmonth = mday(date)) %>%  
                  mutate(hour = hour(date)) %>% 
                  mutate(year = year(date))
  
  ## Remove current year data 
  currYear <- format(Sys.Date(), "%Y")
  rd4 <- rd3 %>% filter(year<currYear)
  
  ## Spread and group data for plotting
  rd5 <- rd4 %>% group_by(neighborhood, year, offense) %>% tally(.)
  
  ## Save to R data file
  saveRDS(rd5, file="data/crimeData.Rda")
 

