
tabPanel("Input data",
         # Sidebar with a slider input for number of bins
         sidebarLayout(sidebarPanel(
           radioButtons('input_type','Select an option',
                        c('Example data'="example_data",
                          'Upload data'="upload_data")),
           conditionalPanel(condition="input.input_type=='upload_data'",
                            fileInput(
                              "expression",
                              "Choose CSV file",
                              accept = c('text/csv', 
                                         'text/comma-separated-values,text/plain',
                                         '.csv')
                            ),
                            tags$hr(),
                            checkboxInput('header', 'Header', TRUE),
                            radioButtons('sep', 'Separator',
                                         c(
                                           Comma = ',',
                                           Semicolon = ';',
                                           Tab = '\t'
                                         )))
           ),
           
           # Show a plot of the generated distribution
         mainPanel(dataTableOutput('contents')),
         position="left",fluid=FALSE
         ))
