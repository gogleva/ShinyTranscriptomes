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
                             n_top = input$n_top)
  
  # Cluster the data
  expr_den <- clustData(expr_data,
                        dist_method = input$corMethod)
  
  # Number of groups for colouring the tree
  k <- input$tree_k
  
  # Plot
  output$heatmap <-  renderPlotly({
    heatmaply(expr_data,
              Colv = FALSE,
              Rowv = expr_den,
              k_row = k) %>%
      layout(dragmode = "select")
  })
})
