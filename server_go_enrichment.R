#server function for GO-enrichment tab

output$GOtable <- renderDataTable({ 
    print(class(input$GOgenes))
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    print(parsed_GOgenes)
    GOterm = (mapIds(org.At.tair.db,
                     keys = parsed_GOgenes,
                     column = "GO",
                     keytype = "TAIR",
                     multiVals = "CharacterList"))
    flatGO <- sapply(GOterm,function(x) paste(unlist(x),collapse="\n"))
    my_table <- data.frame(genes = parsed_GOgenes,
                           GO = flatGO,
                           genename = mapIds(org.At.tair.db,
                                      keys = parsed_GOgenes,
                                      column = "GENENAME",
                                      keytype = "TAIR",
                                      multiVals = "first")
                           )
}, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))