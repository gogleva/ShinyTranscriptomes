#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library("AnnotationDbi")
library("org.At.tair.db")

# Define UI for application that draws a histogram
shinyUI(tagList(
  navbarPage(
    title="SLCU heatmap",
   source("ui_home.R",local = TRUE)$value,
   source("ui_input.R",local = TRUE)$value,
   source("ui_heatmap.R",local = TRUE)$value,
   source("ui_go_enrichment.R", local = TRUE)$value
  )
))
