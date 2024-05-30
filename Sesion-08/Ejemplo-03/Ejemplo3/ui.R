# Generación de un dashboard de tipo de selección dinámica

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Elecciones dinámicas de Data Frames"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Selección del dataset", 
                  c("mtcars", "rock", "iris")), 
      uiOutput("var"),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("plot")
    )
  )
))