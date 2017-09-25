

tabPanel("heatmap",
         sidebarLayout(sidebarPanel(
           radioButtons('methods','Select an option',
                        c('method1'='method1',
                          'method2'='method2'))),
           mainPanel(plotOutput("dummyHistogram")))
         )

