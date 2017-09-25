
tabPanel("Input data",
         # Sidebar with a slider input for number of bins
         sidebarLayout(
           sidebarPanel(
             fileInput(
               "expression",
               "Choose CSV file",
               accept = c('text/csv', 'text/comma-separated-values,text/plain', '.csv')
             ),
             tags$hr(),
             checkboxInput('header', 'Header', TRUE),
             radioButtons('sep', 'Separator',
                          c(
                            Comma = ',',
                            Semicolon = ';',
                            Tab = '\t'
                          ))
           ),
           
           # Show a plot of the generated distribution
           mainPanel(dataTableOutput('contents'))
         ))

