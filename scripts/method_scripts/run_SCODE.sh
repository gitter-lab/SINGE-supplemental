#!/bin/sh
# Script for executing SCODE
# for data1
ruby run_R.rb data1/expr.txt data2/ptime.txt out1 100 4 356 100 1000

# for data2
ruby run_R.rb data2/expr.txt data2/ptime.txt out2 626 20 1886 100 1000
