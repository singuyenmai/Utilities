library(igraph)

V.E.numbers <- function(g){
   
   totalNode <- gorder(g)
   mir <- length(V(g)[Type == 'miRNA'])
   tf <- length(V(g)[Type == 'TF'])
   gene <- length(V(g)[Type == 'gene'])
   
   totalEdge <- gsize(g)
   mir.gene <- length(E(g)[Type == 'miRNA-gene'])
   mir.tf <- length(E(g)[Type == 'miRNA-TF'])
   tf.gene <- length(E(g)[Type == 'TF-gene'])
   tf.mir <- length(E(g)[Type == 'TF-miRNA'])
   
   feaList <- list('miRNAs' = mir, 'TFs' = tf, 'Genes' = gene, 'Total Nodes' = totalNode, 
        'miRNA-gene' = mir.gene, 'miRNA-TF' = mir.tf,
        'TF-gene' = tf.gene, 'TF-miRNA' = tf.mir,
        'Total Edges' = totalEdge)
   
   feaFrame <- as.data.frame(feaList)
   feaFrame
}

degree.bc <- function(g){
   
   outDeg <- degree(g, mode = c("out"))
   inDeg <- degree(g, mode = c("in"))
   Deg <- degree(g, mode = c("all"))
   bc <- betweenness(g, directed = TRUE)
   
   feaList <- list('Out Degree' = outDeg, 'In Degree' = inDeg,
                   'Degree' = Deg, 'Betweenness Centrality' = bc)
   
   feaFrame <- as.data.frame(feaList)
   feaFrame <- feaFrame[order(feaFrame$Betweenness.Centrality, decreasing = TRUE),]
}