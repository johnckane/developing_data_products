library(shiny)

shinyUI(fluidPage(
  titlePanel("Probability of Winning a Fantasy Football Game"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "points_slider",
                label = "Points Scored",
                min = 28,
                max = 182,
                value = 28,
                step = 0.1,
                round = FALSE,
                ticks = TRUE)
  ),
  mainPanel(
    plotOutput("plot")
  )
)
)
)
