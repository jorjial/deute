library("sp")

deute <- readRDS("data/deute.rds")
source("helpers.R")

shinyServer(function(input, output) {
  
  output$plotCAs <- renderPlot({plotCA(deute, input$ca1,
                                       input$ca2, input$ca3,
                                       input$ca4, input$ca5,
                                       input$siTotal)})
  
  output$mapDeute <- renderPlot({plotMapa(input$year, deute)})
  
  output$mapDeute <- renderPlot({plotMapa(input$year, deute)})
    
})