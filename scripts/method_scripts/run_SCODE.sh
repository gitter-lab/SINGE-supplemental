#!/bin/sh
# Script for executing SCODE
# for data1
ruby run_R.rb data/data1_SCODE_expr.txt data/data1_SCODE_ptime.txt out1 100 4 356 100 1000

# for data2
ruby run_R.rb data/data2_SCODE_expr.txt data/data2_SCODE_ptime.txt out2 626 20 1886 100 1000
