#server function for GO-enrichment tab


output$GOtable <- renderDataTable({ 
    print(class(input$GOgenes))
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    print(parsed_GOgenes)
    my_table <- data.frame(genes = parsed_GOgenes,
                           GOterm = mapIds(org.At.tair.db,
                                           keys = parsed_GOgenes,
                                           column = "GO",
                                           keytype = "TAIR",
                                           multiVals = "first"),
                           genename = mapIds(org.At.tair.db,
                                             keys = parsed_GOgenes,
                                             column = "GENENAME",
                                             keytype = "TAIR",
                                             multiVals = "first")
                           )
})