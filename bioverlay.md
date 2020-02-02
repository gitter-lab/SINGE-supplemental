# Response to biOverlay reviews

## Reviewer 1

> This paper reports the development of a new method (SCINGE) to infer gene regulatory networks (GRNs) from single cell gene expression data. The manuscript begins with a thorough but concise summary of the state of the field. In general the methodology was motivated by well-described biological and technical phenomena. The method itself is a combination of kernel-based Granger Causality regression and ensemble aggregation procedure. While most of the components of SCINGE are previously published methods, the proposed combination and application of these methods to GRN inference represents a substantial contribution to the field. The authors compare SCINGE to several other methods using two benchmark data sets in which the true regulatory relationships are at least partially known. Overall, the paper is clear, well written, and technically sound. The results are presented clearly and interpreted appropriately. Many of the questions that arose during my initial reading of this manuscript were subsequently addressed or acknowledged. This is a high-quality manuscript; however, I would suggest addressing the major and minor comments described below.

> Major Comments:

> It appears that the proposed method (and perhaps other methods in the field) assume that cells move independently through a trajectory of states. Specifically, for a given cell at pseudotime t, cells measured at pseudotimes < t are assumed to provide information about the previous levels of gene expression in the given cell. This seems to ignore the potential of cell-cell signaling to affect gene expression. In the case of transcription factors this would necessarily occur indirectly.

> The performance assessments of SCINGE and the comparisons with other methods are carried out on two experimental data sets in which the “truth” is assumed to be at least partially known. However, as the authors note, in such situations the “truth” is likely incomplete and perhaps even incorrect at times. In addition to evaluating the methods on these data sets, it would be interesting to simulate data for which the truth is actually known.

> The performance assessments were all based on the presence / absence of edges. This is necessitated by the information used as a gold standard for the experimental data. However, I was left wondering whether the estimated model parameters, e.g. the a_{i,j}(l), are meaningful? This is something that would be interesting to explore via simulations in which one could assess the ability to estimate these parameters.

> Minor Comments:

> I found the subsampling procedure to be poorly motivated and somewhat difficult to interpret. The authors note some similarity to bagging, but do not provide a reference for the proposed procedure (nor any theoretical justification for its use). I got the (perhaps incorrect) impression that it was being used as a type of sensitivity analysis without being explicitly framed in that way. Some additional clarification on this procedure would be helpful.?

## Reviewer 2

> This pre-print by Deshpande et. al. provides two main contributions: (1) a method (SCINGE) for reconstructing transcription factor (TF) regulatory networks from single cell RNA-seq, and (2) a good example of how to thoughtfully benchmark a network reconstruction algorithm. The choices and challenges in picking a gold standard and some of the implications of those choices are well described in the manuscript. The authors also evaluate the effects of using pseudotime for network reconstruction. Most of my major points relate to the interpretation of the benchmarking results.

> Major Comments:

> Does granger causality for scrna-seq run into problems if a TF goes from unexpressed before differentiation to (stochastically) expressed after differentiation? These would likely be among the most interesting TFs to study.

> For the retinoic acid-driven differentiation data set, it would be useful to know if the top-performing TFs in the gold standard (Klf4, Tcf3, Sox2, etc.) are more relevant to the phenotype (retinoic acid-driven differentiation) than the bottom ranked TFs. Relatedly, how biologically relevant are the 12 TFs in the gold standard for this phenotype? The authors mention that these TFs come from a database of TFs important for mouse ESC differentiation, but more detail about the TF experiments compiled in ESCAPE would aid interpretation.

> The cut-off of 1000 TF-gene interactions for inclusion in the TF gold standard inclusion seems quite high. Do the authors mean 1000 binding peaks or 1000 genes with one or more peaks? If it’s the latter, there are plenty of important TFs that would not meet that criterion.

> It appears that SCINGE is capable of estimating TF->gene edges between pseudotime points. Why not take advantage of this time-dependent information? Are the estimates unreliable even after the ensembling?

> It may be that TF gene expression is not very predictive and the variability of TF average precision results reflect this. Are the TFs in the gold standard differentially expressed?

> Relatedly, focusing only on genes that are differentially expressed in the retinoic acid-driven differnetiation data might explain the poor performance by SCINGE on the ChIP-seq/ChIP-chip data, since TF binding is no guarantee of change in expression.

> Minor Comments:

> Overall, I thought the methods section was well-written and interpretable. I did have a hard time understanding the rationale and details for writing Eq. (2) in terms of a quasi-time series, $\bf{a{ij}^{‘}(t)}$. The previous paragraph on pg 22 says the GLG test is designed to handle irregular time series, so why is a quasi-time series necessary? Also, what is a quasi-time series? Perhaps a diagram would help in describing the transformation from $\bf{a{ij}(t)}$ to $\bf{a_{ij}^{‘}(t)}$.

> How are the 9 regulators of Pou5f1 determined in Fig 2?

> Page 7: Given that SCINGE is tuned to the Matsumoto et. al. data, how should we interpret the comparisons with other methods?

> A more detailed explanation of average early precision on page 8 or a reference to the detailed definition in the methods would be helpful.

> Section 2.5 includes no reference to the related section in the methods (3.2.5-6) and is hard to understand without more detail or reference.

> Figures 6, 10, and S8 are hard to read given the close grouping of the points. One possible solution would be grouped barplots.

> Many figures are missing panel labels.

> The y-axis labels and spacing for the AUPRC panel in Figure S8 should be the same as the AUPRC panel in Fig 6 to facilitate comparison.

> Page 20: “Figure S9 shows that the SCINGE and SCODE average rankings of the outgoing interactions from the regulators using the Order Only dataset are more commensurate with their ESCAPE prevalence.”

> This sentence is not clear to me. I’m not sure what “commensurate with their ESCAPE prevalence” means.
Given the substantial difference in SCINGE’s performance in the ChIP-chip/ChIP-seq vs. loss/gain of function data, it would be interesting to look at a TF where both ChIP-chip/ChIP-seq and loss/gain of function data exist.
