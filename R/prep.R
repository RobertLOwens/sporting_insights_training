################################################################################
#
# DATE: 1/30
# AUTHOR: ROB OWENS
# PURPOSE: PREP DATA BEFORE GOING INTO THE APPLICATION
#
################################################################################
library(dplyr)
library(stringr)
library(tidyr)

options(scipen = 9999)

brands <- read.csv("data/brands.csv")

social_names <- c("wikipedia", "twitter", "facebook", "instagram", "youtube",
                  "tiktok", "snapchat", "pinterest", "linkedin", "indeed")

brand_info <- brands %>% 
  select(name, site, wikipedia, twitter, facebook, instagram, youtube, 
         youtube_verified, tiktok, snapchat, pinterest, linkedin)
  
brands_data <- brands %>% 
  select(name,
         starts_with(social_names),
         -social_names, 
         -site,
         -ends_with("verified")
         ) %>% 
  mutate_if(is.numeric, as.character) %>% 
  pivot_longer(cols = 2:25, names_to = "data") %>% 
  mutate(social = str_extract(data, paste(social_names, collapse = "|")),
         category = str_remove(data, paste(social_names, collapse = "|")),
         category = str_remove(category, "_"),
         category = str_remove(category, "\\."),
         value_clean = ifelse(endsWith(value, "M"), 
                              as.numeric(str_remove(value, "M")) * 1E6, 
                              value), 
         value_clean = ifelse(endsWith(value_clean, "k"), 
                              as.numeric(str_remove(value_clean, "k")) * 1E3,
                              value_clean),
         value_clean = ifelse(endsWith(value_clean, "K"), 
                              as.numeric(str_remove(value_clean, "K")) * 1E3,
                              value_clean)
         ) %>% 
  filter(category == "followers" | category == "likes") %>% 
  mutate(value_clean = as.numeric(value_clean))

write.csv(brands_data, "data/brands_social_followers.csv")
  
