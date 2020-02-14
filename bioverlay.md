# Response to [biOverlay reviews](https://www.bioverlay.org/post/2019-04-scrnaseq-data-network-inference/)

We thank the biOverlay editor and reviewers for selecting the SINGE [*bioRxiv* preprint](https://doi.org/10.1101/534834) for review and for their helpful feedback.
We sought to address many of these comments while revising our manuscript.
Others we deferred for our future studies of gene regulatory network inference from single-cell RNA-seq.
Note that the software has been renamed from SCINGE to **SINGE** per a reviewer request.

Before responding to the biOverlay reviews, we summarize other notable changes to the manuscript and [SINGE software](https://github.com/gitter-lab/SINGE) since our initial submission that were motivated by journal reviewers and recent related literature:
-	Showed how to use the [dynverse](https://dynverse.org/) framework for benchmarking trajectory inference algorithms so that SINGE users can select the optimal type of pseudotimes for new single-cell RNA-seq datasets
-	Demonstrated SINGE's general applicability with multiple types of pseudotimes by running it with Monocle, Monocle 2, Embeddr, PAGA Tree, and simulated dyngen pseudotimes
- Added evidence that higher quality PAGA Tree pseudotimes lead to higher quality SINGE networks on the same expression data
-	Tested SINGE and other gene regulatory network methods with the [dyngen](https://github.com/dynverse/dyngen) simulator
-	Added GENIE3 to our evaluations to show SINGE’s use of single-cell pseudotimes does improve network inference performance
-	Predicted a gene regulatory network from a Mouse Cell Atlas bone marrow dataset to show SINGE's generality and scalability

In addition, we observed independent groups launching single-cell network inference benchmarking efforts, such as [BEELINE](http://doi.org/10.1038/s41592-019-0690-6) and [SERGIO](https://doi.org/10.1101/716811).
To better support third-party benchmarking and adoption - including making it easier to run SINGE's full ensembling technique - we made extensive updates to the SINGE software.
These improve the scalability, usability, and reliability:
-	[Docker](https://hub.docker.com/r/agitter/singe) support so that MATLAB is not required
-	Modularization of the algorithm so that it can be run on a distributed computing cluster on large datasets
-	Optimizations that make inference up to 10 times faster
- A formal test suite through [Travis CI](https://travis-ci.com/gitter-lab/SINGE) to ensure software correctness and stability
-	Support for restricting the regulators to a predefined list of transcription factors

More details are available at the [SINGE GitHub releases page](https://github.com/gitter-lab/SINGE/releases).
Finally, we added a [supplemental GitHub repository](https://github.com/gitter-lab/SINGE-supplemental) with additional scripts and results to document our analyses.

## Reviewer 1

> This paper reports the development of a new method (SCINGE) to infer gene regulatory networks (GRNs) from single cell gene expression data. The manuscript begins with a thorough but concise summary of the state of the field. In general the methodology was motivated by well-described biological and technical phenomena. The method itself is a combination of kernel-based Granger Causality regression and ensemble aggregation procedure. While most of the components of SCINGE are previously published methods, the proposed combination and application of these methods to GRN inference represents a substantial contribution to the field. The authors compare SCINGE to several other methods using two benchmark data sets in which the true regulatory relationships are at least partially known. Overall, the paper is clear, well written, and technically sound. The results are presented clearly and interpreted appropriately. Many of the questions that arose during my initial reading of this manuscript were subsequently addressed or acknowledged. This is a high-quality manuscript; however, I would suggest addressing the major and minor comments described below.

> Major Comments:

> It appears that the proposed method (and perhaps other methods in the field) assume that cells move independently through a trajectory of states. Specifically, for a given cell at pseudotime t, cells measured at pseudotimes < t are assumed to provide information about the previous levels of gene expression in the given cell. This seems to ignore the potential of cell-cell signaling to affect gene expression. In the case of transcription factors this would necessarily occur indirectly.

The stated assumption is correct and is a potential limitation of SINGE and other related algorithms.
We designed SINGE to use the kernel-based Generalized Lasso Granger (GLG) test in part to address this limitation.
SINGE assumes that the smoothed, averaged expression states of cells measured at pseudotimes < t are predictive of the expression state of a cell a pseudotime t.
Averaging over stochastic expression variation and differences in cell state due to cell-to-cell signaling and other factors is intended to improve our ability to recover meaningful expression dependencies.

We added a reference to and brief discussion of an excellent [review](https://doi.org/10.1016/j.bbagrm.2016.08.007) to raise awareness of these and other biological mechanisms affecting transcription dynamics that SINGE does not model.
In addition, we also refer to the [SCRIBE manuscript](https://doi.org/10.1101/426981), which explores these assumptions in greater detail.

> The performance assessments of SCINGE and the comparisons with other methods are carried out on two experimental data sets in which the “truth” is assumed to be at least partially known. However, as the authors note, in such situations the “truth” is likely incomplete and perhaps even incorrect at times. In addition to evaluating the methods on these data sets, it would be interesting to simulate data for which the truth is actually known.

We added an evaluation using the [dyngen](https://github.com/dynverse/dyngen) simulator.
The dyngen data and results are available in this [supplemental repository](https://github.com/gitter-lab/SINGE-supplemental/tree/master/dyngen).
The dyngen package simulates a gene regulatory network and generates single-cell gene expression data from that network.
We used SINGE and existing methods to predict networks from that simulated data and compared them to the simulated ground truth.

Almost all methods we assessed in this manner have close to random performance on the simulated dyngen network, with Jump3 being the only exception.
After examining the simulated expression data in more detail, we noticed that the expression profiles ([example](https://github.com/gitter-lab/SINGE-supplemental/tree/master/dyngen#expression-trends-of-genes-with-direct-and-indirect-interactions)) of direct target genes and downstream indirect targets were quite similar.
This contributes to SINGE's poor performance.
If we evaluate SINGE against a modified gold standard network that includes direct and indirect transitive relationships, its relative performance improves greatly, surpassing Jump3 and the random baseline.

In practice, this suggests that SINGE may also struggle to distinguish direct from indirect regulatory relationships in real single-cell RNA-seq data.
Therefore, we expanded our discussion of how SINGE could be extended to use prior information about transcription factor binding to prioritize direct interactions.

> The performance assessments were all based on the presence / absence of edges. This is necessitated by the information used as a gold standard for the experimental data. However, I was left wondering whether the estimated model parameters, e.g. the a_{i,j}(l), are meaningful? This is something that would be interesting to explore via simulations in which one could assess the ability to estimate these parameters.

We do not expect that the estimated model parameters are meaningful.
In fact, SINGE's ensembling approach is in part motivated by our distrust of the model parameters from any individual GLG test with a fixed set of hyperparameters.
We rewrote our presentation of the expression data subsampling and modified Borda count ensembling to clarify why we use a rank-based aggregation that does not consider the magnitudes of the model parameters.

> Minor Comments:

> I found the subsampling procedure to be poorly motivated and somewhat difficult to interpret. The authors note some similarity to bagging, but do not provide a reference for the proposed procedure (nor any theoretical justification for its use). I got the (perhaps incorrect) impression that it was being used as a type of sensitivity analysis without being explicitly framed in that way. Some additional clarification on this procedure would be helpful.?

We completely rewrote the sections about expression data subsampling and modified Borda count ensembling.
We contrast the subsampling strategy we implemented in SINGE with another simpler strategy that removes entire cells from the single-cell dataset.
In addition, we place the Borda count aggregation in the context of other alternative approaches for unsupervised model aggregation, stability selection, and false discovery rate estimation in gene regulatory network inference.
We added a reference that includes a [theoretical discussion](https://doi.org/10.1080/10361146.2014.900530) of the Borda count and its modifications in political science, where the scoring rule applied to ranked votes is known to affect the winner of an election.
This weighted rank-based voting is the inspiration for SINGE's ensembling.

The subsampling and aggregation is designed to improve the robustness of the predicted edge ranking.
Like traditional bagging, rerunning GLG tests on different subsamples of the data can help ensure the predicted regulatory interactions are not artifacts of atypical expression states of outlier cells.
Aggregating across different hyperparameter combinations guards against predicted regulatory interactions that are not resilient to minor differences in the regression sparsity or pseudotemporal lags.

The subsampling is not necessarily a sensitivity analysis.
However, we did add new supplemental figures showing the sensitivity of GLG tests for different hyperparameter values.
The test is most sensitive to the value of the regression sparsity hyperparameter lambda.

## Reviewer 2

> This pre-print by Deshpande et. al. provides two main contributions: (1) a method (SCINGE) for reconstructing transcription factor (TF) regulatory networks from single cell RNA-seq, and (2) a good example of how to thoughtfully benchmark a network reconstruction algorithm. The choices and challenges in picking a gold standard and some of the implications of those choices are well described in the manuscript. The authors also evaluate the effects of using pseudotime for network reconstruction. Most of my major points relate to the interpretation of the benchmarking results.

> Major Comments:

> Does granger causality for scrna-seq run into problems if a TF goes from unexpressed before differentiation to (stochastically) expressed after differentiation? These would likely be among the most interesting TFs to study.

Because SINGE uses Generalized Lasso Granger (GLG), it can recognize this type of pattern.
We added supplementary figures where the regulator switches from expressed to unexpressed or from unexpressed to expressed midway through the pseudotemporal process.
GLG is especially valuable in the case of stochastic expression.
The GLG kernel smooths the expression of the regulator over cells that are nearby in pseudotime so that the normalized expression intensity will increase if a regulator switches from unexpressed to stochastically expressed.

> For the retinoic acid-driven differentiation data set, it would be useful to know if the top-performing TFs in the gold standard (Klf4, Tcf3, Sox2, etc.) are more relevant to the phenotype (retinoic acid-driven differentiation) than the bottom ranked TFs. Relatedly, how biologically relevant are the 12 TFs in the gold standard for this phenotype? The authors mention that these TFs come from a database of TFs important for mouse ESC differentiation, but more detail about the TF experiments compiled in ESCAPE would aid interpretation.

This is an excellent suggestion, but we have not yet explored the top and bottom ranked individual transcription factors (TFs) in this manner.

> The cut-off of 1000 TF-gene interactions for inclusion in the TF gold standard inclusion seems quite high. Do the authors mean 1000 binding peaks or 1000 genes with one or more peaks? If it’s the latter, there are plenty of important TFs that would not meet that criterion.

We did use a cutoff of TFs that have 1000 genes with one or more peaks.
The reviewer is correct that there are important TFs that would be excluded by this threshold.
However, we set the higher threshold based on our inspection of individual experiments that have been compiled in the ESCAPE database.
Some of those experiments that included a smaller number of target genes for the TF were not genome-wide in scope.
Therefore, it would have been incorrect to assume that all genes not reported as targets of that TF in the limited-scale experiment were not in fact true targets.
Setting the higher threshold of 1000 TF targets increases our confidence that all genes that are not reported can be treated as negative edges in the gold standard.

> It appears that SCINGE is capable of estimating TF->gene edges between pseudotime points. Why not take advantage of this time-dependent information? Are the estimates unreliable even after the ensembling?

SINGE does take advantage of smoothed expression values that lie in between the observed pseudotimes.
We expanded our Methods section text about the lagged regulator coefficients and added an example of lagged pseudotimes to highlight this.

> It may be that TF gene expression is not very predictive and the variability of TF average precision results reflect this. Are the TFs in the gold standard differentially expressed?

We agree there are many examples showing that TF expression may not be predictive of target gene expression.
We made this limitation more transparent by referencing a [review](https://doi.org/10.1016/j.bbagrm.2016.08.007) of transcription dynamics that discusses epigenomic modifications, TF post-translational modifications, TF localization, transcriptional co-factors, and other factors affecting transcription that are not reflected in TF expression.
We also note that approximating a TF's regulatory activity with its mRNA level is a simplifying assumption.

For the major benchmarking analysis with the retinoic acid-driven differentiation expression data, all regulators are differentially expressed.
We only included the 626 genes that significantly changed in expression along the pseudotime.

> Relatedly, focusing only on genes that are differentially expressed in the retinoic acid-driven differnetiation data might explain the poor performance by SCINGE on the ChIP-seq/ChIP-chip data, since TF binding is no guarantee of change in expression.

We agree that this could be a source of error.
In our Discussion section, we reference our prior work comparing ChIP data and TF loss of function experiments, which studied the low overlap between these two types of data.
Our new analysis of the simulated dyngen gene expression data also suggests that SINGE's search for lagged gene expression dependencies may detect more indirect regulatory relationships than direct TF binding.
SINGE performs poorly at recovering direct regulatory interactions in the dyngen network but is better at detecting direct or indirect interactions.

We proposed that extending SINGE to incorporate epigenomic data as prior information could help improve its performance on the ChIP-based interactions and reference additional methods that integrate single-cell RNA-seq with such priors.
However, even if a GRN method can be improved by integrating additional data types as a prior, there is still a need to discover the best way to uncover dependences from the expression data alone, which is the focus of our study.

> Minor Comments:

> Overall, I thought the methods section was well-written and interpretable. I did have a hard time understanding the rationale and details for writing Eq. (2) in terms of a quasi-time series, $\bf{a{ij}^{‘}(t)}$. The previous paragraph on pg 22 says the GLG test is designed to handle irregular time series, so why is a quasi-time series necessary? Also, what is a quasi-time series? Perhaps a diagram would help in describing the transformation from $\bf{a{ij}(t)}$ to $\bf{a_{ij}^{‘}(t)}$.

We removed the confusing term quasi-time series and revised the explanation of this equation.
We also added examples showing how these lagged coefficients are connected across different pseudotimes.
If we have pseudotimes of 50 and 75, a time lag of 5, and 3 lags, then there will be 3 coefficients for each potential regulator.
The first coefficient would consider the pseudotemporal history at 45 and 70 for the pseudotimes at 50 and 75, respectively.
The next coefficient would consider 40 and 65.
The third would consider 35 and 60.
Multiple copies of the coefficient represent how a regulator's influence is dependent on the degree of the time lag between its expression changes and the target gene's.

> How are the 9 regulators of Pou5f1 determined in Fig 2?

We replaced Figure 2 with a more straightforward example for this gene that makes it more transparent how the regulators were selected.
We select a varying number of regulators by varying lambda, the sparsity hyperparameter in the GLG regression test.
The updated figure also shows the mean squared error on the insample cells that were used to fit the regression coefficients and the outsample cells that were dropped during the subsampling.
These held out outsample cells can be used to assess the fit.
This indicates that the GLG regression does not overfit at the highlighted sparsity levels.

> Page 7: Given that SCINGE is tuned to the Matsumoto et. al. data, how should we interpret the comparisons with other methods?

The mouse embryonic stem cells to primitive endoderm case study should be viewed as a validation or tuning dataset.
We state "We emphasize this particular evaluation is not indicative of which method would perform best on new data because of SINGE's tuning."
We show the performance of SINGE and the other methods for completeness but use the retinoic acid data for our performance assessment of SINGE and the other methods.

> A more detailed explanation of average early precision on page 8 or a reference to the detailed definition in the methods would be helpful.

We added a reference to the Methods section where this metric is defined.
It can be thought of as a summary of the area under the precision-recall curve that only considers the leftmost (early) part of the curve.

> Section 2.5 includes no reference to the related section in the methods (3.2.5-6) and is hard to understand without more detail or reference.

We added a reference to the Methods section that explains the ensembling and modified Borda count.

> Figures 6, 10, and S8 are hard to read given the close grouping of the points. One possible solution would be grouped barplots.

We are still assessing the optimal visualization for these results and will consider grouped barplots.

> Many figures are missing panel labels.

We are still finalizing how the results are organized into multi-panel figures and which results will appear in the supplement.
We will add panel labels for the final version of the manuscript.

> The y-axis labels and spacing for the AUPRC panel in Figure S8 should be the same as the AUPRC panel in Fig 6 to facilitate comparison.

In the updated figures, the average precision figures have a very similar y-axis scale.
However, we still use different scales for the average early precision so that the differences among methods are easier to see.

> Page 20: “Figure S9 shows that the SCINGE and SCODE average rankings of the outgoing interactions from the regulators using the Order Only dataset are more commensurate with their ESCAPE prevalence.”

> This sentence is not clear to me. I’m not sure what “commensurate with their ESCAPE prevalence” means.

This sentence was poorly worded.
We now write "Similarly, the SINGE and
SCODE average rankings of the outgoing interactions from the regulators using the Order Only dataset better match the regulators' prevalence in the ESCAPE database (Figure S9).
Regulators with more interactions in ESCAPE tend to have higher rankings in these predicted GRNs."

> Given the substantial difference in SCINGE’s performance in the ChIP-chip/ChIP-seq vs. loss/gain of function data, it would be interesting to look at a TF where both ChIP-chip/ChIP-seq and loss/gain of function data exist.

This is another excellent suggestion, but we have not yet explored the individual regulators that are in both ChIP and loss or gain of function data.
