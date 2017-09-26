# tabPanel for GO-enrichment button:

tabPanel("GO enrichment",
         sidebarLayout(
             sidebarPanel(
             radioButtons('genes', 'Select gene list',
             c('Example data' = "example_data",
               'Upload data' = "upload_data")),
             
             textAreaInput(inputId = "genes",
                       label = "Input gene list",
                       placeholder = 'Paste list of gene ids',
                       height = '200px'),
             
             selectInput("GOterm", "Select GOterm",
                         choices = c('biological process',
                                     'molecular function',
                                     'cellular localisation')),
             
             selectInput("method", "Select method", 
                         choices = c('method1', 'method2', 'method3'))),

             mainPanel(h3(textOutput("Result")))
         ))