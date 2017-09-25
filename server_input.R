
# expressionData <- reactiveValues()

output$dataUploaded <- reactive({
  return(!is.null(input$expression))
})
outputOptions(output,"dataUploaded",suspendWhenHidden=FALSE)

# observeEvent(input$input_type, {
  if(input$input_type=="example_data"){
    expressionData <- read.csv("data/TPM-light-WT-17c-27c-RNA-seq-average-rep1-rep2_misexpressed.csv")
  } else if(input$input_type=="upload_data"){
    
     if(is.null(input$expression)){
       expressionData <- NULL
     } else{
      expressionData <- read.csv(input$expression$datapath, header=input$header, sep=input$sep)
     }
  }
 
  print(head(expressionData))
  output$contents <- renderDataTable({
    expressionData
  }, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))
  
  
  
  # output$data <- expressionData 
  # print(output$data)
  # output$dummyHistogram <-  renderPlot({
  #   hist(output$data[,1])
  # })
  
# })