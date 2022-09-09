library(tidyverse)
library(here)
library(janitor)

### kern, tulare, and madera counties.

#load data into R
all_chemicals <- read_csv(here("~/Desktop/Lucero/usgs_monitoring_allchem_kern.csv")) %>%
  clean_names() 

all_chemicals$Date <- as.Date(all_chemicals$gm_samp_collection_date, format = "%m/%d/%y")

str(all_chemicals)

#subset chemicals of interest
chemicals_interest <- all_chemicals %>%
                      select(gm_well_category,Date, gm_chemical_name, gm_result, gm_well_id) %>%
                      separate(col= gm_well_id, into = c("well", "well_id"), sep = "-") %>% 
                      filter(gm_chemical_name == c("Arsenic", "Chromium", "Nitrate+Nitrite"))
       

#facet_wrap
chemicals_interest %>%
  ggplot(aes(x = Date, y = gm_result, color = gm_chemical_name)) +
  geom_point() +
  facet_wrap(vars(chemicals_interest$well)) +
  xlab("Date") +
  ylab("Micrograms per Liter") +
  ggtitle("Concentration of Chemicals in Kern County")               

#chem by color
chemicals_interest %>%
  ggplot(aes(x = Date, y = gm_result, color = gm_chemical_name)) +
  geom_point() +
  xlab("Date") +
  ylab("Micrograms per Liter") +
  ggtitle("Concentration of Chemicals in Kern County")    

#final?
all_chemicals %>%
  ggplot(aes(x = Date, y = gm_result, color = gm_chemical_name)) +
  geom_point() +
  xlab("Date") +
  ylab("Micrograms per Liter") +
  ggtitle("Concentration of Chemicals in Kern County")
