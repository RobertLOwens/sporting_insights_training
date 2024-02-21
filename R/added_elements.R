# ITEMS TO ADD AS WE TALK

# 1. REACTIVE

mpg_by_wt <- reactive({
  mpg_by_wt <- mtcars %>% 
    group_by(cyl) %>% 
    summarise(mpg = mean(mpg))
}) 

# 2. REACTIVE BASED ON INPUT

mpg_by_wt <- reactive({
  mpg_by_wt <- mtcars %>% 
    group_by(cyl) %>% 
    summarise(mpg = mean(mpg))
}) 