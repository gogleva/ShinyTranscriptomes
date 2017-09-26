



observeEvent(input$drawHeatmap,{
  exprData <- inputDataReactive()
  if(!is.null(exprData)){
    exprData <- exprData$data
  }
  
  exprData <- transformData(exprData, transMethod=input$dataTransform)
  print(input$dataTransform)
  exprDen <- clustData(exprData,distMethod=input$corMethod, k=input$treeGroups)
  k=input$treeGroups
  output$heatmap <-  renderPlotly({
      # heatmaply(as.matrix(exprData[,-1]),
                # Rowv = exprDen, 
                # Colv=NA, dendrogram='row', trace = 'none' ,labRow=NA
                # )
    heatmaply(exprData, Colv=FALSE, Rowv= exprDen$den, 
              k_row=k ) %>%
      layout(dragmode="select")
  })
  print("heatmap done")
})


# heatmap.2(as.matrix(BoleanHighNoise[,2:13]), Colv=TRUE, dendrogram='row', Rowv=TRUE, 
#           col= purpleblackyellow,breaks=seq(0,1,length.out=101), trace = 'none' ,
#           labRow=NA, labCol=names(BoleanHighNoise[2,13]), main="Genes Highly Variable",ColSideColors=ColDay,
#           na.rm=F, na.color="black")

# 
# observeEvent(inputDataReactive(),{
#   output$dummyHistogram <-  renderPlot({
#     tmp <- inputDataReactive()
#     if(!is.null(tmp)){
#       tmp <- tmp$data
#       hist(tmp[,2])
#     }
#   })
# })

