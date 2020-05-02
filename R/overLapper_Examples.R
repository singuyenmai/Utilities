## overLapper examples
source('./overLapper.R')

a <- c(1:10)
b <- c(5:15,21)
c <- c(8:20,4)

# To work with the overLapper function, 
# the sample sets (here three) need to be stored in a list object 
# where the different compontents are named by unique identifiers, here 'A to C'. 
# These names are used as sample labels in all subsequent data sets and plots.
setList <- list('A'=a, 'B'=b, 'C'=c)

OLlist_1 <- overLapper(setlist=setlist, sep="_", type="vennsets")
names(OLlist_1) 
# With the setting type="vennsets", the overLapper function computes all Venn Intersects for the 3 test samples in 
# setlist and stores the results in the Venn_List component of the returned OLlist object. By default, duplicates are 
# removed from the test sets. The setting keepdups=TRUE will retain duplicates by appending a counter to each entry. When 
# assigning the value "intersects" to the type argument then the function will compute Regular 
# Intersects instead of Venn Intersects. The Regular Intersect approach (not compatible with Venn diagrams!) is described 
# in the next section. Both analyses return a present-absent matrix in the Intersect_Matrix component of OLlist. Each overlap 
# set in the Venn_List data set is labeled according to the sample names provided in setlist. For instance, the composite 
# name 'ABC' indicates that the entries are restricted to A, B and C. The seperator used for naming the intersect samples 
# can be specified under the sep argument. By adding the argument cleanup=TRUE, one can minimize formatting issues in the 
# sample sets. This setting will convert all characters in the sample sets to upper case and remove leading/trailing spaces.
OLlist_1$Venn_List

OLlist <- overLapper(setlist=setList, sep="_", type="intersects")
OLlist$Intersect_List
# Computes all possible intersects for the samples stored in 'setlist'. The results are returned as a list where each 
# overlap component is labeled by the corresponding sample names. For instance, the name 'A-B-C' indicates that the 
# entries are common in samples A, B and C. The seperator used for naming the intersect samples can be specified under 
# the 'sep' argument. The complexity level range to consider can be controlled with the 'complexity' argument, which 
# can have values from 2 to the total number of samples.
