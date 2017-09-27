#
# This is the server logic  of the SLCU shiny transcriptomes APP
#

# Load necessary libraries
library(shiny)
library(gplots)
library(heatmaply)
library(RColorBrewer)

# Define server logic
# each tab's server code is sourced from the respective file
shinyServer(function(input, output) {
  # Source all helper functions
  list.files("functions/", full.names = TRUE) %>%
    lapply(source)
  
  source("server_input.R", local = TRUE)
  source("server_heatmap.R", local = TRUE)
 source("server_go_enrichment.R", local = TRUE)    
})
