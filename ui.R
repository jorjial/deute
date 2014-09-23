library(shiny)

deute <- readRDS("data/deute.rds")
sortedCAs = sort(unique(deute$data$comunidad))

shinyUI(fluidPage(
  
  titlePanel("Evolución de la deuda por comunidades autónomas"),
  
  sidebarLayout(
    sidebarPanel(

    h4("Selecciona el año a visualizar en el mapa"),  
    
    br(),
    
    sliderInput("year", label = "", min = 1995, max = 2014, value = 2008),
    
    hr(),
    br(),
    br(),
    
    h5("También puedes comparar la deuda de diferentes CCAA"),
    
    selectInput("ca1", 
                label = "",
                choices = sortedCAs,
                selected = "Comunidad Valenciana"),
    
    selectInput("ca2", 
                label = "",
                choices = sortedCAs,
                selected = "Cataluña"),
    
    selectInput("ca3", 
                label = "",
                choices = sortedCAs,
                selected = "Comunidad de Madrid"),
    
    selectInput("ca4", 
                label = "",
                choices = sortedCAs,
                selected = "Andalucía"),
    
    selectInput("ca5", 
                label = "",
                choices = sortedCAs,
                selected = "Extremadura"),
    
    br(),

    h6("Deuda según el Protocolo de Déficit Excesivo por Comunidades Autónomas. 
       Porcentajes del PIB pm. Los datos de 2014 corresponden al primer semestre."),
    
    hr(),
    br(),
    
    h6("Autor: ", a("@jorjial", href="https://www.twitter.com/jorjial")),
    
    h6("Codi font: ", a("deute", href="https://github.com/jorjial/deute"))
    
    ),
    
    mainPanel(
      h4("Porcentajes de deuda por comunidad autónoma"),

      plotOutput("mapDeute"),
      
      h4("Comparación de la evolución de la deuda"),
      
      plotOutput("plotCAs")
      
      )
  )
  
))