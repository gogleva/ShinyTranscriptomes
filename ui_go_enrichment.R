# tabPanel for GO-enrichment button:

tabPanel("GO enrichment",
         sidebarLayout(
             sidebarPanel(
             textAreaInput(inputId = "GOgenes",
                       label = "Input gene list",
                       placeholder = 'Paste list of gene ids',
                       height = '200px'),
             
             actionButton(inputId = "GOsubmitButton",
                          "Submit", icon = icon("flash"), 
                          width = NULL,
                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
             hr(),
             
             selectInput(inputId = "subOntology",
                         "Select subontology",
                         choices = c('biological process',
                                     'molecular function',
                                     'cellular localisation')),
             
             selectInput(inputId = "GOmethod", "Select method for enrichment analysis", 
                         choices = c('method1', 'method2', 'method3'))),

               mainPanel(
                 downloadButton('GOdownload', 'Download GO annotations'),
                 tabsetPanel(
                     tabPanel("Table", dataTableOutput('GOtable')), 
                     tabPanel("Plot1"), 
                     tabPanel("Plot2"))
             )))