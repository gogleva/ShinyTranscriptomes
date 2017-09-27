#
# This is the user-interface definition of the SLCU shiny transcriptomes APP
#

# Load necessary libraries
library(shiny)
library(gplots)
library(heatmaply)
library(RColorBrewer)

# Define main UI, which contains several tabs (navbarPage)
## each tab's definition is sourced from separate files
shinyUI(tagList(
  navbarPage(title = "SLCU heatmap",
             source("ui_home.R", local = TRUE)$value,
             source("ui_input.R", local = TRUE)$value,
             source("ui_heatmap.R", local = TRUE)$value)
))
