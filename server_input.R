

inputDataReactive <- reactive({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  print("inputting data")
  # Check if example selected, or if not then ask to upload a file.
  validate(
    need((input$input_type=="example_data")|(!is.null(input$expression)),
         message = "Please select a file")
  )
  inFile <- input$expression
  # browser()
  if(input$input_type=="example_data") {
    # upload example data
    expressionData <- read.csv("data/TPM-light-WT-17c-27c-RNA-seq-average-rep1-rep2_misexpressed.csv")
    print("uploaded example data")
    return(list('data'=expressionData))
  }else { # if uploading data
    if (!is.null(inFile)) {
      expressionData <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
      print('uploaded expressionData')
      validate(need(ncol(expressionData)>1,
                    message="File appears to be one column. Check that it is a comma-separated (.csv) file."))
      return(list('data'=expressionData))}else{return(NULL)}
  }
})

observeEvent(inputDataReactive(),{
  output$countdataDT <- renderDataTable({
    tmp <- inputDataReactive()
    if(!is.null(tmp)) tmp$data
  })
})





# 
# observeEvent(inputDataReactive(),{
#   output$dummyHistogram <-  renderPlot({
#     tmp <- inputDataReactive()
#     if (!is.null(tmp)) {
#       tmp <- tmp$data
#   hist(tmp[,2])}
#   })
# })




# 
# expressionData <- reactiveValues()
# 
# output$dataUploaded <- reactive({
#   return(!is.null(input$expression))
# })
# outputOptions(output,"dataUploaded",suspendWhenHidden=FALSE)
# 
# observeEvent(input$input_type, {
#   if(input$input_type=="example_data"){
#     expressionData <- read.csv("data/TPM-light-WT-17c-27c-RNA-seq-average-rep1-rep2_misexpressed.csv")
#   } else if(input$input_type=="upload_data"){
#     
#      if(is.null(input$expression)){
#        expressionData <- NULL
#      } else{
#       expressionData <- read.csv(input$expression$datapath, header=input$header, sep=input$sep)
#      }
#   }
#   
#   
#     output$contents <- renderDataTable({
#       expressionData
#     }, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))
#   
#   
#   # output$data <- expressionData
#   # print(output$data)
#   output$dummyHistogram <-  renderPlot({
#     hist(expressionData[,2])
#   })
# 
# })