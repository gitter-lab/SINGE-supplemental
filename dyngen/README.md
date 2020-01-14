We generated a simulated dataset using dyngen, with the help of the script generate_dataset.R. This was modified from one provided by [@rcannood](https://github.com/rcannood). The datset includes 25 TFs, 15 housekeeping genes and 100 target genes, with 164 total number of edges.
The figures below show the precision-recall performance of inferred networks from SINGE, SCODE, Jump3, SINCERITIES, and GENIE3 with respect to the truth provided by the dyngen model. These figures show that the performance of SINGE improves when evaluating with respect to a gold standard representing both direct and indirect interactions between genes. The final figure shows the expression trends of an "indirect" edge, and how based on expression data alone, the network inference task is difficult on the dyngen dataset. 

## Precision-Recall performance with Direct Gene Interactions
Here, the truth corresponds to only the direct regulatory interactions between genes. No indirect interactions are considered.
![](figures/Dyngen_PR_DirectEdges_Only.png)<!-- -->
## Precision-Recall performance with Direct and Level 1 Indirect Gene Interactions
Here, the truth includes the direct regulatory interactions as well as Level 1 (cascaded interactions caused from direct interactions) indirect interactions between genes. 
![](figures/Dyngen_PR_with_Level1_InDirectEdges.png)<!-- -->
## Precision-Recall performance with Direct and Level 2 Indirect Gene Interactions
The truth now includes the direct regulatory interactions as well as Level 1 and Level 2 indirect interactions between genes. 
![](figures/Dyngen_PR_with_Level1_Level2_InDirectEdges.png)<!-- -->
## Precision-Recall performance with all Direct and Indirect Gene Interactions
The truth here includes the direct regulatory interactions as well as all indirect interactions between genes caused through the direct interactions. 
![](figures/Dyngen_PR_with_All_InDirectEdges.png)<!-- -->
## Expression trends of genes with direct and indirect interactions
The figure shows the expression trends of three genes, and illustrates how the expression trend alone seems insufficient to distinguish between direct and indirect edges on the dyngen dataset.
![](figures/Dyngen_Gene_Expression.png)<!-- -->
