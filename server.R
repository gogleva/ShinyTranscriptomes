#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(gplots)
library(heatmaply)
library(RColorBrewer)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  source("heatmap_functions.R",local=TRUE)
 source("server_input.R",local=TRUE)
 source("server_heatmap.R",local=TRUE)
})
