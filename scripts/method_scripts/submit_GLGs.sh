#!/bin/bash

numreplicates=$(head -n 1 replicates.txt)
DATE=`date +%m/%d/%Y`
DATEname=`date +%Y%m%d`
echo $DATE
export datafile=$1
echo $datafile 
export family=$2
export prs=$3
export pzr=$4
listname="list$DATEname.txt"
rm $listname
touch listname
echo $numreplicates
ID=0
TargetIncr=100
for replicate in $(seq 1 $numreplicates);
do
	while read lambda; do
		while read dT num_lags; do
			while IFS='' read -r kernel; do
				for firsttarget in $(seq 1 $TargetIncr);
				do
					echo "$datafile lambda $lambda dT $dT num_lags $num_lags kernel_width $kernel ID $ID replicate $replicate family $family date $DATE firsttarget $firsttarget targetincr $TargetIncr $3 $4 $5 $6">>$listname
					ID=$((ID+1))
				done
			done < kernel.txt
		done < time.txt 
	done < lambda.txt 
done
export listname
condor_submit chtc-submit-GLG.sub
