

tabPanel("heatmap",
         sidebarLayout(sidebarPanel(
           actionButton("drawHeatmap", "Draw heatmap"),
           tags$hr(),
           radioButtons('dataTransform','Data transformation type',
                        c('None'='none',
                          'Log2(X+1)'='log2',
                          'Z-score: (X-mean)/SD'='zscore')),
           tags$hr(),
           radioButtons('corMethod','Correlation based distance type',
                        c('Pearson'='pearson',
                          'Spearman'='spearman',
                          'Kendall'='kendall')),
           tags$hr(),
           numericInput('treeGroups','Select number of clusters',
                        1, min=1, max=12)),
           mainPanel(plotlyOutput("heatmap")))
         )

