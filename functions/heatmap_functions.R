# Function to choose rows with most variable data (per row)
chooseTop <- function(x, n_top){
  
  # Take rows with the highest variance
  if(n_top < nrow(x)){
    # Order by decreasing order of variance
    i_top <- order(apply(x, 1, var), decreasing = TRUE)
    x <- x[i_top[1:n_top], ]
  }
  
  return(x)
}


# Function to transform and tidy the user data
transformData <- function(x, vars = -1, trans_method, n_top = 100){
  
  # Check that the first column is not selected for analysis
  if(1 %in% vars) stop("The first column cannot be used for analysis. It should contain gene IDs")
  
  # Define rownames from the first column (gene IDs)
  rownames(x) <- x[, 1]
  
  # Keep only the expression columns chosen by the user (all by default)
  x <- x[, vars]
  
  # Transform the data as requested
  if (trans_method == "none") {
    x <- x
    
  } else if (trans_method == "log2") {
    x <- log2(x + 1)
    
  } else if (trans_method == "zscore") {
    x <- (x - rowMeans(x)) / apply(x, 1, sd)
    
  } else {
    stop("Transformation method not valid")
    
  }
  
  # Choose the rows based on variance
  x <- chooseTop(x, n_top)
  
  return(x)
}


# Function to cluster data
clustData <- function(x, 
                      dist_method = c("pearson", "spearman", "kendall")){
  
  # Ensure dist_method is valid
  if(!(dist_method[1] %in% c("pearson", "spearman", "kendall")))
    stop("Distance metric is not valid")
  
  # Calculate correlation
  x_cor <- cor(t(x), method = dist_method)
  
  # Convert to dist object and subtract 1 (anti-correlation)
  x_dist <- as.dist((1 - x_cor))
  
  # NA values are replaced with 0
  x_dist[is.na(x_dist)] <- 0
  
  # Cluster data using hclust with default options
  # and convert to dendrogram
  x_clust <- hclust(x_dist, method = "complete") 
  
  # Dendrogram data
  x_dend <- dendro_data(x_clust, type="rectangle")
  
  x_dend <- x_dend$labels %>%
    rename(ylabel = y) %>%
    full_join(x_dend$segments, by="x")
  
  # Heatmap data
  x_heatmap <- x %>%
    mutate(id=row.names(.)) %>%
    gather("sample","value",-id)
  
  # # Cut the tree into defined number of groups
  # x_cut <- cutree(x_clust, k)
  # k_colour = brewer.pal(12, 'Set3')[x_cut]
  # 

  return(list(dendro_data=x_dend, heatmap_data=x_heatmap))
}
