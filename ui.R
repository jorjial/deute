library(shiny)

deute <- readRDS("data/deute.rds")
sortedCAs = c("Seleccionar", sort(unique(deute$data$comunidad)))

shinyUI(fluidPage(
  
  titlePanel("Evolución de la deuda por comunidades autónomas"),
  
  sidebarLayout(
    sidebarPanel(

    h4("Selecciona el año a visualizar en el mapa"),  
    
    br(),
    
    sliderInput("year", label = "", width = "80%",
                min = 1995, max = 2014, value = 2008),
    
    hr(),
    br(),
    br(),
    
    h5("También puedes comparar la deuda de hasta cinco CCAA"),
    
    selectInput("ca1", 
                label = "",
                choices = sortedCAs,
                selected = "Comunidad Valenciana"),
    
    selectInput("ca2", 
                label = "",
                choices = sortedCAs,
                selected = "Seleccionar"),
    
    selectInput("ca3", 
                label = "",
                choices = sortedCAs,
                selected = "Seleccionar"),
    
    selectInput("ca4", 
                label = "",
                choices = sortedCAs,
                selected = "Seleccionar"),
    
    selectInput("ca5", 
                label = "",
                choices = sortedCAs,
                selected = "Seleccionar"),
    
    checkboxInput("siTotal",
                  label = "Comparar con el total",
                  value = TRUE),
    
    br(),

    h6("Deuda según el Protocolo de Déficit Excesivo por Comunidades Autónomas. 
       Porcentajes del PIB pm. Los datos de 2014 corresponden al primer semestre."),
    
    hr(),
    
    h6("Fuente: ", a("Banco de España", href="http://www.bde.es/webbde/es/estadis/infoest/htmls/cdp.html")),
    
    h6("Autor: ", a("@jorjial", href="https://www.twitter.com/jorjial")),
    
    h6("Codi font: ", a("deute", href="https://github.com/jorjial/deute"))
    
    ),
    
    mainPanel(
      h4("Deuda en porcentajes del PIB por comunidad autónoma"),

      plotOutput("mapDeute"),
      
      h4("Comparación de la evolución de la deuda"),
      
      plotOutput("plotCAs")
      
      )
  )
  
))