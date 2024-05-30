#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(class)
library(dplyr)
library(stringr)

#install.packages("shinydashboard")
library(shinydashboard)

shinyUI(
  pageWithSidebar(
    headerPanel("Aplicacion básica con Shiny"),
    sidebarPanel(
      p("Crear plots con el DF 'auto'"), 
      selectInput("x", "Seleccione el valor de X",
                  choices = names(mtcars)),
      selectInput("y", "Selecciona el eje de las Y",
                  choices = colnames(mtcars))
    ),
    mainPanel(
      
      
      #Agregando pestañ±as
      tabsetPanel(
        tabPanel("Plots",                   #Pestaña de Plots <---------
                 h3(textOutput("output_text")), 
                 plotOutput("output_plot"), 
        ),
        
        tabPanel("imágenes",                #Pestaña de imágenes  <---------
                 img( src = "1.2.png", 
                      height = 450, width = 450)
        ), 
        
        tabPanel("Summary", verbatimTextOutput("summary")),     # <--------- Summary
        tabPanel("Table", tableOutput("table")),                # <--------- Table
        tabPanel("Data Table", dataTableOutput("data_table"))   # <--------- Data table
      )
    )
  )
  
)


