#server function for GO-enrichment tab

output$GOtable <- renderDataTable({ 
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    GOterm = (mapIds(org.At.tair.db,
                     keys = parsed_GOgenes,
                     column = "GO",
                     keytype = "TAIR",
                     multiVals = "CharacterList"))
    
    
    flatGO <- sapply(GOterm,function(x) paste(unlist(x),collapse="\n"))
    
    my_table <- data.frame(gene_ID = parsed_GOgenes,
                           GO_term = flatGO,
                           description = mapIds(org.At.tair.db,
                                      keys = parsed_GOgenes,
                                      column = "GENENAME",
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

