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
        theme_bw() +
        theme(axis.text.x=element_text(angle=90, hjust=1), 
              #axis.text.y=element_blank(),
              axis.title = element_blank()) +
        scale_fill_gradient2(low = "#67a9cf", mid = "#f7f7f7", high = "#ef8a62")
      ggplotly(p) %>%
        layout(dragmode="select")
  })
  
  # Dendrogram
  print(expr_data$dendro_data)
  output$dendrogram <- renderPlotly({
    p2 <- ggplot(expr_data$dendro_data, aes(key=label)) +
      geom_segment(aes(x,y,xend=xend, yend=yend)) +
      geom_text (aes(x=x, y=ylabel-0.6, label=label), hjust=1) +
      geom_point(aes(x=x, y=ylabel-1.3),size=2) +
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

    validate(
      need(!is.null(user_selection), "Please select a branch tip")
    )
    
    # Filter data based on user selection
    selected_data <- expr_data$heatmap_data %>% 
      filter(id == user_selection$key)
    
    # Check that there's data
    validate(
      need(nrow(selected_data) > 0, "Please select a branch tip")
    )
    
    # Plot expression
    selected_data %>% 
      ggplot(aes(sample, value)) +
      geom_point(size=3) +
      theme_classic()
    
  })
})

