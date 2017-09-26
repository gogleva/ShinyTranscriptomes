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
             
             selectInput(inputId = "GOterm",
                         "Select GOterm",
                         choices = c('biological process',
                                     'molecular function',
                                     'cellular localisation')),
             
             selectInput(inputId = "GOmethod", "Select method", 
                         choices = c('method1', 'method2', 'method3'))),

               mainPanel(
                 tabsetPanel(
                     tabPanel("Table"), 
                     tabPanel("Plot1"), 
                     tabPanel("Plot2"))
             )))