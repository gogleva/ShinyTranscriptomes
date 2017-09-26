#server function for GO-enrichment tab


output$GOtable <- renderDataTable({ 
    print(class(input$GOgenes))
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    print(parsed_GOgenes)
    my_table <- data.frame(genes = parsed_GOgenes,
                           annotation = rep('smth', length(parsed_GOgenes)))
    
    })