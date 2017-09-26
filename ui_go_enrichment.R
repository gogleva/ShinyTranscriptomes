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
             
             selectInput(inputId = "GOmethod", "Select test for enrichment analysis", 
                         choices = c('fisher', 'kolmogorov-smirnov', 't',
                                     'globaltest', 'sum')),

             selectInput(inputId = "GOtests", "Select algorithm", 
                         choices = c('classic', 'elim', 'weight',
                                     'weight01', 'lea', 'parentchild')),
             

             
             numericInput(inputId = "GOpvalue", "Specify FDR", 0.05)
             ),
             

               mainPanel(
                 downloadButton('GOdownload', 'Download GO annotations'),
                 tabsetPanel(
                     tabPanel("Table", dataTableOutput('GOtable')), 
                     tabPanel("Enrichment results", dataTableOutput('GOresults')),
                     tabPanel("Grouped genes"),
                     tabPanel("Plot1"),
                     tabPanel("Plot2"))
             )))
