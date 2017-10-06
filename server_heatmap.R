#
# Server code for heatmap panel
#

# This is triggered when the user clicks the draw_heatmap button
observeEvent(input$draw_heatmap, {
  
  # Read the data using the input_reactive function
  expr_data <- input_reactive()
  
  # Transform the data
  expr_data <- transformData(expr_data, 
                             trans_method = input$data_transform,
                             n_top = input$n_top) %>%
    clustData(., dist_method = input$corMethod)
  
  
  # Number of groups for colouring the tree
  # k <- input$tree_k
  
  # Heatmap
  output$heatmap <-  renderPlotly({
      p<- ggplot(expr_data$heatmap_data, 
                 aes(sample, id, fill=value))+
        geom_tile() +
        theme(axis.text.x=element_text(angle=90, hjust=1), 
              #axis.text.y=element_blank(),
              axis.title = element_blank())
      ggplotly(p) %>%
        layout(dragmode="select")
  })
  # Dendrogram
  output$dendrogram <- renderPlotly({
    p2 <- ggplot(expr_data$dendro_data, aes(key=label)) +
      geom_segment(aes(x,y,xend=xend, yend=yend)) +
      geom_text (aes(x=x, y=ylabel-0.1, label=label), hjust=1) +
      geom_point(aes(x=x, y=ylabel-0.6),size=2) +
      coord_flip() +
      ggdendro::theme_dendro()
    ggplotly(p2)%>%
      layout(dragmode="select")
  })
  
  output$heatmap_select <- renderPrint({
    user_selection <- event_data("plotly_selected")
    if (is.null(user_selection)) "Nothing selected" else user_selection
  })
  output$heatmap_click <- renderPlot({
    user_selection <- event_data("plotly_click")
    # if (is.null(user_selection)) "Nothing selected" else user_selection
    
    validate(
      need(!is.null(user_selection), "Please select a branch tip")
    )
    
    
    # filter data for selected genes
    expr_data$heatmap_data %>% 
      filter(id == user_selection$key) %>% 
      ggplot(aes(sample, value)) +
      geom_point(size=2)
    
  })
})

