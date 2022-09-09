library(tidyverse)
library(here)
library(janitor)

#load data into R
arsenic <- read_csv(here("data/CONTRACOSTA_AS.csv")) %>%
            clean_names() 


#look at column types
str(arsenic)

#change gm_samp_collection_date to date instead of character
arsenic$Date <- as.Date(arsenic$gm_samp_collection_date, format = "%m/%d/%y")
arsenic$Month <- format(arsenic$Date, "%m") 
arsenic$Year <- format(arsenic$Date, "%Y") 

str(arsenic)

#rough plot of data
arsenic %>%
  ggplot(aes(x = Date, y = gm_result)) +
  geom_point()



#add details to plot
arsenic %>%
  ggplot(aes(x = Date, y = gm_result)) +
  geom_point() +
  xlab("Date") +
  ylab("Micrograms per Liter") +
  ggtitle("Concentration of As in Contra Costa County")


#separate points by well category
arsenic %>%
  ggplot(aes(x = Date, y = gm_result, color = gm_well_category)) +
  geom_point() +
  xlab("Date") +
  ylab("Micrograms per Liter") +
  ggtitle("Concentration of As in Contra Costa County")



