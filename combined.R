###random note to test taylor PAT
### combined gama data ###
library(tidyverse)
library(here)
library(janitor)
library(ggplot2)
library(ggmap)
library(RColorBrewer)

# load in data
gama <- read_csv("~/Desktop/data_raw/gama_2022-07-01.csv") %>%
  clean_names()

str(gama)

categories <- unique(gama$gm_well_category)
categories

source <- unique(gama$gm_data_source)
source

gama$Date <- as.Date(gama$gm_samp_collection_date, format = "%m/%d/%y")
gama$year <- format(gama$Date, format = "%Y")
subset_gama <- subset(gama, year >=2010)
subset_gama$year <- as.factor(subset_gama$year)


mean_longitude <- mean(subset_gama$src_longitude)
mean_latitude <- mean(subset_gama$src_latitude)

##set google API key
# note: need to enable static API and google maps API 
source('/keys.R')

gama_map <- get_map(location = c(mean_longitude, mean_latitude), zoom = 9, scale = 2)

gama_map <- ggmap(gama_map, extent="device", legend="none")
            + stat_density2d(data=subset_gama,
                        aes(x=src_longitude, y=src_latitude, fill=..level.., alpha=..level..), geom="polygon")
            + scale_fill_gradientn(colours=rev(brewer.pal(7, "Spectral")))
           + geom_point(data=subset_gama,
                        aes(x=src_longitude, y=src_latitude), fill="red", shape=21, alpha=0.8)
            + guides(scale = "none")
            + ggtitle("GAMA water quality data")
            + facet_wrap(~year)

print(gama_map)

