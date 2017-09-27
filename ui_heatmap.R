#
# user-interface for the heatmap tabPanel
#
tabPanel(
  "heatmap",
  
  # Sidebar with options on the side and preview of data on the main panel
  sidebarLayout(
    
    sidebarPanel(
      # Action button to draw heatmap
      actionButton("draw_heatmap", "Draw heatmap"),
      tags$hr(),
      
      # Options for data transformation
      radioButtons("data_transform", "Data transformation",
                   c("None"="none",
                     "Log2(X+1)"="log2",
                     "Z-score: (X-mean)/SD"="zscore")),
      tags$hr(),
      
      # Options for distance matrix
      radioButtons("corMethod","Distance metric",
                   c("1 - Pearson's correlation"="pearson",
                     "1 - Spearman's correlation"="spearman",
                     "1 - Kendall's correlation"="kendall")),
      tags$hr(),
      
      # Option for number of clusters to cut the tree by
      numericInput("tree_k","Number of groups to cut the tree",
                   value = 1, min=1, max=12),
      tags$hr(),
      
      # Option for number of genes to plot
      numericInput("n_top", "Number of top variable genes to cluster",
                   value = 100, min = 10, max = Inf)),
    
    # Plot the heatmap in the main panel
    mainPanel(fluidPage(
      fixedRow(plotlyOutput("heatmap", height="500px")),
      fixedRow(verbatimTextOutput("heatmap_select"))
              ))
))

