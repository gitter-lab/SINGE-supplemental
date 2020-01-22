# SINGE supplemental information
This repository contains supplemental scripts and analyses for the SINGE manuscript:

Atul Deshpande, Li-Fang Chu, Ron Stewart, Anthony Gitter.
[Network inference with Granger causality ensembles on single-cell transcriptomic data](https://doi.org/10.1101/534834).
*bioRxiv* 2019. doi:10.1101/534834

See the main [SINGE repository](https://github.com/gitter-lab/SINGE) for the software.

For network inference from the different methods, we use the following commands:

## SINGE
For all datasets in the paper, we first run all GLG tests for each target using 
```
bash SINGE.sh PATH_TO_RUNTIME GLG DATA_FILE GENELIST_FILE OUTPUT_FOLDER default_hyperparameters.txt HYPENUM
```

### Inputs 
- `DATA_FILE` is a version -v7.3 mat-file containing an expression matrix `X` of dimensions `GxC`, where `G` is the number of genes and `C` is the number of cells, and the vector `ptime` of dimensions `1xC`, containing the pseudotimes assigned to each cell. 

- `GENELIST_FILE` contains a cell-array containing the names of the `G` genes corresponding to the entries in `X`. 

- `default_hyperparameters.txt` is available in the SINGE repository https://github.com/gitter-lab/SINGE.

- `HYPENUM` is the hyperparameter number, ranging from 1 to 200 in this case.

### Outputs
Each GLG Test gives an output adjacency matrix `A(HYPENUM)` representing a partially inferred network saved in the `OUTPUT_FOLDER`.

This is followed by an aggregation of all GLG Test results using 
```
bash SINGE.sh PATH_TO_RUNTIME Aggregate DATA_FILE GENELIST_FILE OUTPUT_FOLDER
```
### Inputs
- `OUTPUT_FOLDER` and its contents.

### Outputs (saved in the `OUTPUT_FOLDER`)
- `SINGE_Ranked_Edge_List.txt` : File with list of ranked edges according to their SINGE scores.
- `SINGE_Gene_Influence.txt` : File with list of genes ranked according to their SINGE influence.


## SINCERITIES
The SINCERITIES MATLAB package is available at http://www.cabsel.ethz.ch/tools/sincerities.html, and we use its graphical user interface (MAIN.m) with default settings for each dataset.

## SCODE
We downloaded SCODE from the GitHub repository https://github.com/hmatsu1226/SCODE (git commit 28acad67893c0fba7eeee670c339809d45ae6377) and used the command and settings listed below

```
ruby run_R.rb <Input_file1> <Input_file2> <Output_dir> <G> <D> <C> <I> <R>
```
### Inputs
- Input_file1 : G x C matrix of expression data
- Input_file2 : Time point data (e.g. pseudo-time data)
- `Output_dir` : Folder to store temporary output files
- `G` : number of genes (obtain from dataset)
- `D` : dimensionality of vector `z` (D=4 for ESC to Endoderm Differentiation dataset, D=20 for Retinoic Acid-driven Differentiation dataset) 
- `C` : number of cells in the dataset (obtain from dataset)
- `I` : number of iterations (I=100)
- `R` : number of trials over which SCODE output is averaged (R=1000).
### Output
- `meanA.txt' : Represents the adjacency matrix obtained from the average output of `R` SCODE trials


## Jump3
We parallelize the Jump3 implementation to speed up the processing time using high-throught computing. An equivalent version of the Jump3 code we used can be obtained from \url{https://github.com/vahuynh/Jump3} (git commit 03a7e86d82f2383c56fd11c658dfce574fbf1a1a).
Because Jump3 did not terminate in a reasonable amount of time on the full Retinoic Acid-driven Differentiation dataset, we reduced the dataset by arbitrarily dropping cells with probability 0.5.
We use only the ordering information in Jump3 with the assigned obsTimes increasing from 0 to `C-1` from the earliest cell to the latest cell, where `C` is the number of cells in the dataset. 
```
w = jump3(data,obsTimes,noiseVar,tfidx,K,ntrees)
```
We used `noiseVar.obsnoise=0.1`, `K = 100`, `ntrees = 100`, and replicate the default values from Jump3's example in their github repository for the other variables.

## GENIE3
We installed GENIE3 version 1.6.0 from the BioConductor page \url{https://bioconductor.org/packages/release/bioc/html/GENIE3.html} and used its default operating mode without any modifications.
