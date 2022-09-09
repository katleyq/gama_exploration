library(tidyverse)
library(here)
library(janitor)

# load in data
kern <- read_csv(here("data", "usgs_monitoring_allchem_kern.csv")) %>%
  clean_names()
kern$county <- "KERN"

madera <- read_csv(here("data", "usgs_monitoring_madera.csv")) %>%
  clean_names() 
madera$county <- "MADERA"

tulare <- read_csv(here("data", "usgs_monitoring_tulare.csv")) %>%
  clean_names() 
tulare$county <- "TULARE"

# join all data
all_chemicals <- rbind(kern, madera, tulare)

#change data column
all_chemicals$Date <- as.Date(all_chemicals$gm_samp_collection_date, format = "%m/%d/%y")

#filter chemicals of interest
chemicals_interest <- all_chemicals %>%
  select(county, gm_well_category,Date, gm_chemical_name, gm_result, gm_well_id) %>%
  filter(gm_chemical_name == c("Arsenic", "Chromium", "Nitrate+Nitrite")) %>%
  rename(Contaminant = gm_chemical_name)

#visualize
chemicals_interest %>%
  ggplot(aes(x = Date, y = gm_result, color = Contaminant)) +
  geom_point() +
  facet_wrap(vars(chemicals_interest$county)) +
  xlab("Date") +
  ylab("Concentration (Micrograms per Liter)") +
  ggtitle("Concentration of Contaminants of Interest in Kern, Madera, and Tulare County")+
  theme(plot.title = element_text(face="bold", size= 18),
        axis.title.x = element_text(face="bold", size = 15),
        axis.title.y = element_text(face="bold", size = 15))
