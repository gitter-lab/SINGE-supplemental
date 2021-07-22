The files here contain scripts used to run the different methods as part of our experiments.

- `run_SCODE.sh` runs SCODE on the two datasets. This requires the expression data and the pseudotime of each cell in the `expr.txt` and `ptime.txt` file format for each dataset respectively.
- `deployjump3.m` is a MATLAB script which loads the data for each dataset (found in folder `Jump3_data`) and runs Jump3.
- `submit_GLGs.sh` is a shell script which submits multiple jobs to the HTC Condor system with diverse hyperparameter sets generated using the `.txt` files included. This requires downloading of the executable of `SINGE v0.3.0` from  https://github.com/gitter-lab/SINGE.
