#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$output_text <- renderText(paste("Grafico de ",input$y, " ~ ", input$x))   # input$x es la selección que se hizo en la UI
  output$output_plot <- renderPlot(plot(as.formula(paste(input$y, "~", input$x)), 
                                        data = mtcars))
  
  #imprimiendo el summary       <----------                                  
  output$summary <- renderPrint({
    summary(mtcars %>% select(input$x, input$y))
  })
  
  # Agregando el dataframe       <----------
  output$table <- renderTable({ 
    data.frame(mtcars %>% select(input$x, input$y))
  })
  
  #Agregando el data table       <----------
  output$data_table <- renderDataTable({mtcars %>% select(input$x, input$y)}, 
                                       options = list(aLengthMenu = c(5,25,50),
                                                      iDisplayLength = 5))
  
})
