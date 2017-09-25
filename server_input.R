

  
  output$contents <- renderDataTable({
    if(input$input_type=="example_data"){
      expressionData <- read.csv("data/TPM-light-WT-17c-27c-RNA-seq-average-rep1-rep2_misexpressed.csv")
    } else if(input$input_type=="upload_data"){
      
      if(is.null(input$expression)){
        expressionData <- NULL
      } else{
        expressionData <- read.csv(input$expression$datapath, header=input$header, sep=input$sep)
      }
    } 
    return(expressionData)
  }, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))
  
