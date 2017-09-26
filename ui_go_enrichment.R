# tabPanel for GO-enrichment button:

tabPanel("GO enrichment",
         sidebarLayout(
             sidebarPanel(
             radioButtons('method', 'Select an option',
             c('Example data' = "example_data",
               'Upload data' = "upload_data"))),
             
             mainPanel(h3(textOutput("Result")))
         ))