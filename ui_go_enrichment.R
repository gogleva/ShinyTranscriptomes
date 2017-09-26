# tabPanel for GO-enrichment button:

tabPanel("GO enrichment",
         sidebarLayout(
             sidebarPanel(
             radioButtons('genes', 'Select gene list',
             c('Example data' = "example_data",
               'Upload data' = "upload_data")),
             
             selectInput("method", "Select method", 
                         choices=c('method1', 'method2', 'method3'))),

             mainPanel(h3(textOutput("Result")))
         ))