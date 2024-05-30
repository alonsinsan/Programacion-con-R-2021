library(shiny)


shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    if (input$plot_type == "histogram") {
      hist(mtcars[,input$x_hist], xlab =input$x_hist, main = paste("Histograma de ",input$x_hist) )
      
    }  else  {
      plot(mtcars[,input$x], mtcars$hp, xlab = input$x, ylab = "hp")
    }      
    
  })
  
})