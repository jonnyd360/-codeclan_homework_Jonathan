library(tidyverse)
library(janitor)
library(assertr)

meteorite <- read_csv("data/meteorite_landings.csv")

meteorite %>% 
  verify (names(meteorite) == c("id", "name", "mass (g)", "fall", "year", "GeoLocation"))

meteorite_clean <- clean_names(meteorite) %>% 
  separate(geo_location, into = c("latitude", "longitude"), (sep = ",")) %>% 
  mutate(latitude = str_remove(latitude, pattern = "\\("),
         longitude = str_remove(longitude, pattern = "\\)"),
         latitude = replace_na(latitude, "0"),
         longitude = replace_na(longitude, "0"),
         latitude = as.numeric(latitude),
         longitude = as.numeric(longitude)) %>% 
  filter(mass_g > 1000) %>% 
  arrange(year)

meteorite_clean

meteorite_clean %>% 
  verify (latitude >= -90 | latitude  <= 90) %>% 
  verify (longitude >= -180 | longitude <= 180)

write.csv(meteorite_clean) 
