


observeEvent(inputDataReactive(),{
  output$dummyHistogram <-  renderPlot({
    tmp <- inputDataReactive()
    if(!is.null(tmp)){
      tmp <- tmp$data
      heatmap.2(as.matrix(tmp[,-1]))
      }
  })
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

