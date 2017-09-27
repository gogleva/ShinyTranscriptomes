#
# Server code for input panel
#

# First create a reactive function that changes over time 
# (depending on user input)
input_reactive <- reactive({
  
  # Check if example is selected, or if not then ask to upload a file.
  validate(
    need(input$input_source == "example_data" | !is.null(input$upload_file),
         message = "Please select a file")
    )
  
  # input$upload_file will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns.
  in_file <- input$upload_file
  
  # Read data
  if(input$input_source == "example_data"){
    
    # upload example data
    expr_data <- read.csv("data/TPM-17c-27c-average_misexpressed.csv")
    
    return(expr_data)
    
  } else if(input$input_source == "upload_data"){
    # if uploading data
    if (!is.null(in_file)) {
      expr_data <- read.table(in_file$datapath,
                              header = input$header,
                              sep = input$sep)
      
      validate(
        need(ncol(expr_data) > 1,
             message = "File appears to be one column. Check that you chose the right separator.")
      )
      
      return(expr_data)
    } else{
      return(NULL)
    }
  }
})

# This is triggered whenever the input_reactive object changes
observeEvent(input_reactive(), {
  output$countdataDT <- renderDataTable({
    tmp <- input_reactive()
    if (!is.null(tmp)) tmp
  })
})




