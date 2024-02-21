################################################################################
#
# DATE: 1/30
# AUTHOR: ROB OWENS
# PURPOSE: LESSONS ON DATA VIZ AND PREP
#
################################################################################

server <- function(input, output, session) {
  
  # LOAD DATA ------------------------------------------------------------------
  shoe_followers_social <- read.csv("data/brands_social_followers.csv")
  
  observe({
    
    print("Local Change")
    mtcars <- mtcars %>% 
      filter(cyl == 2)
    
    updateSelectInput(session, "brands", 
                      choices = unique(shoe_followers_social$name),
                      selected = unique(shoe_followers_social$name))
  })
  
  shoe_followers_social_r <- reactive({
    
    req(input$brands, input$category)
    
    shoe_followers_social <- shoe_followers_social %>% 
      filter(name %in% input$brands) %>% 
      filter(category == input$category)
    
  })
  
  output$followers <- renderPlot({
    
    ggplot(shoe_followers_social_r(),
           aes(x = value_clean, y = fct_reorder(social, value_clean, .na_rm = T))) + 
      geom_segment(aes(xend = 0, yend = social)) +
      geom_point(size = 4, color="orange") +
      facet_wrap(~name, scales = "free", ncol = 2) + 
      labs(x = "Followers", y = "Social", title = "Followers by Social Media") + 
      theme_bw() + 
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.text = element_text(size = 12),
        strip.text = element_text(size = 12)
      )
    
  })
  
  output$followers2 <- renderPlot({
    
    ggplot(shoe_followers_social_r(), aes(value_clean, fct_reorder(name, value_clean, .na_rm = T))) + 
      geom_segment(aes(xend = 0, yend = name)) +
      geom_point(size = 4, color="orange") +
      facet_wrap(~social, scales = "free_x", ncol = 2) +
      labs(x = "Followers",  y = "Brand Name", title = "Followers by Brand") + 
      theme_bw() + 
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.text = element_text(size = 12),
        strip.text = element_text(size = 12)
      )
    
  })

}