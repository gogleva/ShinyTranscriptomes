


transformData <- function(x,vars=-1,transMethod){
  rownames(x) <- x[,1]
  x <- x[1:100,]
  if (transMethod=="none") {
    return(x[,vars])
  } else if (transMethod=="log2") {
    x_vars <- log2(x[,vars]+1)
    return(x_vars)
  } else if (transMethod=="zscore") {
    x_vars <- x[,vars]
    x_remain <- x[,-vars]
    x_zscore <- (x_vars-rowMeans(x_vars))/apply(x_vars,1,sd)
    return(x_zscore)
  } else {
    stop("Transformation method not valid")
  }
}



clustData <- function(x,vars=-1,distMethod,k) {
xCor <- cor(t(x[,vars]), method = distMethod)
xCor[is.na(xCor)]<-0
xCorDist<-as.dist((1-xCor))
xCorDist[is.na(xCorDist)]<-0
xCorDistClust <- hclust(xCorDist, method="complete")
xCorDistClustDen <- as.dendrogram(xCorDistClust)
xCorDistClustClusters=brewer.pal(12,'Set3')[cutree(xCorDistClust, k = k)]
return(list(den=xCorDistClustDen, k=xCorDistClustClusters))
}


