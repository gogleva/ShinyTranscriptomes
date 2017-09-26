#server function for GO-enrichment tab

output$GOtable <- renderText({ input$GOgenes })