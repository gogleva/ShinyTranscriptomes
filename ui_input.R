#
# user-interface for the Input tabPanel
#
tabPanel(
  "Input data",
  
  # Sidebar with options on the side and preview of data on the main panel
  sidebarLayout(
    
    sidebarPanel(
      
      # Buttons to select data source
      radioButtons(
        "input_source",
        "Select an option",
        c("Example data" = "example_data",
          "Upload data" = "upload_data")
      ),
      
      conditionalPanel(
        condition = "input.input_source=='upload_data'",
        fileInput(
          "upload_file",
          "Choose CSV file",
          accept = c("text/csv",
                     "text/comma-separated-values,text/plain",
                     ".csv")
        ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE),
        radioButtons("sep", "Separator",
                     c(
                       Comma = ",",
                       Semicolon = ";",
                       Tab = "\t"
                     ))
      ),
      conditionalPanel("output.dataUploaded", actionButton("submitData", "Submit"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(dataTableOutput("countdataDT")),
    position = "left",
    fluid = FALSE
  )
)
