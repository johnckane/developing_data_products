library(shiny)
library(ggplot2)

prob <- function(x){
  return(exp(x)/(1 + exp(x)))
}

all_games <- function(x){
  return(prob(-6.54740493 + 0.06392334*x))
}

shinyServer(
  function(input, output) {  
    
  
    .e <- environment()
    
    df = data.frame(x1=seq(28,182,by=0.1),y1=all_games(seq(28,182,by=0.1)))
    
    p <- ggplot(data = df,
                aes(x=x1,y=y1), 
                environment = .e) + 
      scale_x_continuous("Points Scored",c(28,182),
                         breaks = c( 40,60,80,100,120,140,160,180)) + 
      scale_y_continuous("Probability of Winning",c(0,1),
                         breaks = c(0.0,0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,1.0)) +
      geom_line(color="Blue") 
    
    output$plot <- renderPlot({ 
      
         
     p +
       geom_line(aes(x=seq(28,182,by=0.1), 
                     y=all_games(seq(28,182,by=0.1))), color="Blue") +
       geom_text(aes(x=60, y=0.90,
                     label = paste("Probability of Winning = ",
                                   round(all_games(input$points_slider),2))),
                 color = "Black") +
       geom_segment(aes(x = 28, 
                        y = all_games(input$points_slider), 
                        xend = input$points_slider, 
                        yend = all_games(input$points_slider)),
                    color = "Black", alpha=0.50) +
       geom_segment(aes(x = input$points_slider, 
                        y = 0, 
                        xend = input$points_slider, 
                        yend = all_games(input$points_slider)),
                    color = "Black", alpha = 0.50) +
       theme_bw()
      
    })
  }
)
