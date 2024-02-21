################################################################################
#
# DATE: 1/30
# AUTHOR: ROB OWENS
# PURPOSE: LESSONS ON DATA VIZ AND PREP
#
################################################################################


# HELPFUL RESOURCES ------------------------------------------------------------ 

# 1. STYLE GUIDE
# http://adv-r.had.co.nz/Style.html

# 2. REACTIVES VS OBSERVERS
# https://shiny.posit.co/r/getstarted/build-an-app/reactivity-essentials/reactives-observers.html

library(shiny)
library(shinyjs)
library(ggplot2)
library(tidyverse)
library(highcharter)

# UI MAIN PAGE -----------------------------------------------------------------
ui <- fluidPage(
  
  useShinyjs(),
  
  titlePanel("Sporting Insights Training"),
  h2("Session 2"),
  
  selectInput("brands", "Brands", multiple = TRUE, choices = NULL),
  selectInput("category", "Category", choices = c("Followers" = "followers", "Likes" = "likes")),
  actionButton("apply", "Apply Filter Changes"),
  fluidRow(
    column(1),
    column(8,
           plotOutput("followers", height = "1200px"),
           plotOutput("followers2", height = "1000px")
           ),
    column(1)
    )
  )
