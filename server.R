library(shiny); library(pwr); library(dplyr); library(ggplot2)

source("helpers.R")
ns_small <- as.matrix(1:5000)
ns_small <- as.data.frame(ns_small)

shinyServer(function(input, output) {
  
  data_input <- reactive({
      
    alpha <- switch(input$alpha,
                    "Alpha = 0.01" = 0.01, 
                    "Alpha = 0.05" = 0.05, 
                    "Alpha = 0.10" = 0.10)
    
    power_target <- input$power_target
    effect_target <- input$effect_target
  })
  
  output$n_required <- renderUI({  
    
    alpha <- switch(input$alpha,
                    "Alpha = 0.01" = 0.01, 
                    "Alpha = 0.05" = 0.05, 
                    "Alpha = 0.10" = 0.10)
    
    power_target <- input$power_target
    
    effect_target <- input$effect_target
    
    n_required <- as.integer(pwr.2p.test(h = effect_target, sig.level = alpha, power = power_target)$n)
    
    n_string <- paste0("In order to achieve ", power_target*100, "% power with an effect size of ", effect_target, ", you'll need a sample size of at least ", n_required," in each group.")
    
    n_string
  })
  
  output$powerplot <- renderPlot({  
    
    alpha <- switch(input$alpha,
                    "Alpha = 0.01" = 0.01, 
                    "Alpha = 0.05" = 0.05, 
                    "Alpha = 0.10" = 0.10)
    
    power_target <- input$power_target
    effect_target <- input$effect_target
    
    n_required <- pwr.2p.test(h = effect_target, sig.level = alpha, power = power_target)$n
   
    ns_small <- ns_small %>%
      mutate(power = get_power(effect_size = effect_target, sig_level = alpha, sample_size = V1))
    
    ggplot(ns_small, aes(x=V1, y=power)) +
      geom_line() +
      geom_line(aes(y = power_target), linetype = "dotted") +
      geom_line(aes(x = n_required), linetype = "dotted") +
      scale_y_continuous(breaks = seq(0, 1, 0.2)) + 
      labs(x="Sample Size", y="Power", title = "Power Curve") +
      theme_minimal() +
      theme(text = element_text(size = 15))
    
  })
})
