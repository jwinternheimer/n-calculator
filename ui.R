library(shinythemes)

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  headerPanel("Sample Size Calculator for 2-Sample Proportion Test"),
  fluidRow(
    column(12,
           wellPanel(
             h4(htmlOutput("n_required"))
           )),
    
    column(4,
           wellPanel(
               selectInput("alpha", "Significance Level",c("Alpha = 0.01", "Alpha = 0.05", "Alpha = 0.10"),selected="Alpha = 0.05"),
               sliderInput("power_target", "Power Target", value = .8, min = 0, max = 1),
               sliderInput("effect_target", "Effect Size Target", value = .2, min = 0, max = 1)
           )),
    column(8,
           wellPanel(
             plotOutput("powerplot")
           )
    ),
    column(12,
           wellPanel(
             p("Power analysis is an important part of experimental design. 
               It lets us determine the sample size required to detect an effect of a given size with a certain degree of confidence.
               This is important, because it is easy to fall into a trap of saying that an effect would be significant if the sample size was only bigger.
               It is useful to stop experiments at the point when a significant effect should have been detected."),
             p(strong("The following four quantities have an intimate relationship:")),
             tags$ul(
               tags$li("Sample size"),
               tags$li("Effect size"),
               tags$li("Significance  level = P(Type I error) = probability of finding an effect that is not there"),
               tags$li("Power = 1 - P(Type II error) = probability of finding an effect that is there.")
             ),
             p("Given any 3 of these, we can determine the fourth."),
             p(strong("Effect Size"), br("Specifying an effect size is tricky business and can depend on the type of test you're running.",
                                         "ES formulas and Cohen's suggestions (based on social science research) are provided below.")),
             p("For tests of proportions, Cohen suggests that h values of 0.2, 0.5, and 0.8 represent small, medium, and large effect sizes respectively.")
             
             ))
    )
)
)

