Scripts used to run the different methods as part of our experiments.

- `run_SCODE.sh` runs SCODE on the two datasets. This requires the expression data and the pseudotime of each cell in the `expr.txt` and `ptime.txt` file format for each dataset respectively.
- `deployjump3.m` is a MATLAB script that loads the data for each dataset (found in [`data`](data/)) and runs Jump3.
- `submit_GLGs.sh` is a shell script that submits multiple jobs to the HTCondor system with diverse hyperparameter sets generated using the `.txt` files included. This requires downloading of the executable of [SINGE v0.3.0](https://github.com/gitter-lab/SINGE/releases/tag/v0.3.0). It documents how SINGE was run but was designed to run at [CHTC](http://chtc.cs.wisc.edu/).
