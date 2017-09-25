#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$contents <- renderDataTable({
    inFile <- input$expression
    
    if(is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath, header=input$header, sep=input$sep)
    
  }, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))
  
})
