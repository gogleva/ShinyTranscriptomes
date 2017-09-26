#server function for GO-enrichment tab

# helper function to filter GO terms based on ontology:

function(GO_list, sub){
    all_ont <- lapply(GO_list, Ontology)
    show_terms <- names(unlist(all_ont[which(all_ont == sub)]))
    return(show_terms)
}

# observer for the input field and submit button

observeEvent(input$GOsubmitButton, {

output$GOtable <- renderDataTable({ 
    parsed_GOgenes <- unlist(strsplit(input$GOgenes, '\n'))
    GOterm = (mapIds(org.At.tair.db,
                     keys = parsed_GOgenes,
                     column = "GO",
                     keytype = "TAIR",
                     multiVals = "CharacterList"))
    
    flatGO <- sapply(GOterm,function(x) paste(unlist(x),collapse="\n"))
    list2 <- sapply(flatGO, strsplit, '\n')
    
    # # helper function to filter GO terms based on ontology:
    # 
    # function(GO_list, sub){
    #     all_ont <- lapply(GO_list, Ontology)
    #     show_terms <- names(unlist(all_ont[which(all_ont == sub)]))
    #     return(show_terms)
    # }
    
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


output$GOresults <- renderDataTable({ 
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
    flatGO <- sapply(filtered_terms,function(x) paste(unlist(x),collapse=", "))
    
    # dataframe to be displayed in the main panel
    my_table <- data.frame(gene_ID = parsed_GOgenes,
                           GO_term = flatGO)
  
}, options=list(aLengthMenu=c(10,30,50),iDisplayLength=10, scrollX=TRUE))

output$GOgrouped <- renderDataTable({
    pass
})


output$GOgrouped <- renderDataTable({
    pass
})

output$GOdownload <- downloadHandler(
    filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
        write.csv(unlist(strsplit(input$GOgenes, '\n')), con)
    }
)

})



