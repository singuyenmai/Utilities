library(igraph)
library(tools)
library(threejs)

plot_reg_network <- function(g, stage = ''){
   
   # Check if input 'stage' has given with the right name/syntax
   stages <- c('acute', 'subacute', 'chronic')
   if (!(stage %in% stages)) message('Wrong name/syntax of MI stage')
   
   name <- paste('miRNA-TF co-regulatiory network of', stage, 'MI stage')
   name <- toTitleCase(name)
   
   #V(g)$color <- ifelse(
   #  V(g)$Type == 'miRNA', 'cornflowerblue', 
   #     ifelse(V(g)$Type == 'TF', 'tomato', 'gold')
   #)
   i <- as.numeric(factor(V(g)$Type))
   g <- set_vertex_attr(g, 'color', value = c('tomato', 'cornflowerblue', 'gold')[i])
   
   j <- as.numeric(factor(E(g)$Type))
   g <- set_edge_attr(g, 'color', value = c('gray80', 'blue', 'red', 'green')[j])

   graphjs(g,
        #vertex.label.cex = 4,
        #vertex.label.color = "black",
        vertex.size = 1,
        #edge.arrow.size = 0.5,
        #layout = layout_nicely,
        main = name)
}