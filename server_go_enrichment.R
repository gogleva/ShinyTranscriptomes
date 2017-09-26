#server function for GO-enrichment tab

output$GOtable <- renderDataTable({ 
 #   print(input$subOntology)
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    GOterm = (mapIds(org.At.tair.db,
                     keys = parsed_GOgenes,
                     column = "GO",
                     keytype = "TAIR",
                     multiVals = "CharacterList"))
    
    flatGO <- sapply(GOterm,function(x) paste(unlist(x),collapse="\n"))
    list2 <- sapply(flatGO, strsplit, '\n')
    
    # show GO terms based on the selected subontology:

    if (input$subOntology == 'biological process') {
        filtered_terms <- sapply(list2, filterOntology, 'BP')
    } else if ((input$subOntology == 'molecular function')) {
        filtered_terms <- sapply(list2, filterOntology, 'MF')
    } else if ((input$subOntology == 'cellular localisation')) {
        filtered_terms <- sapply(list2, filterOntology, 'CC')
    }
    
    # format list for final display
    flatGO <- sapply(filtered_terms,function(x) paste(unlist(x),collapse="\n"))
    
    # dataframe to be displayed in the main panel
    my_table <- data.frame(gene_ID = parsed_GOgenes,
                           GO_term = flatGO,
                           description = mapIds(org.At.tair.db,
                                      keys = parsed_GOgenes,
                                      column = "GENENAME",
                                      keytype = "TAIR",
                                      multiVals = "first"),
                           symbol = mapIds(org.At.tair.db,
                                           keys = parsed_GOgenes,
                                           column = "SYMBOL",
                                           keytype = "TAIR",
                                           multiVals = "first")
                           )
}, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))

output$GOdownload <- downloadHandler(
    filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
    },

    content = function(con) {
        write.csv(unlist(strsplit(input$GOgenes, '\n')), con)
    }
)





