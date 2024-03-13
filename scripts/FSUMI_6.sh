#! /usr/bin/bash
#reconcile UMI reads with reference

# 1. Combine

sample_list=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R1/*

for sample in $sample_list
do

name="$(basename -- ${sample:0:${#sample}-14})"

echo $name

cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R1/$name.UMIinR1.R1.fq /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R2/$name.UMIinR2.R2.fq > /data/gpfs-1/users/hedler_m/work/UMIreads/R1/$name.umi.R1.fq
cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R2/$name.UMIinR1.R2.fq /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R1/$name.UMIinR2.R1.fq > /data/gpfs-1/users/hedler_m/work/UMIreads/R2/$name.umi.R2.fq

done

# 2. Final Clean-up
#rm R1.toFilterOut R2.toFilterOut toFilterOut.txt
#rm names.* umi.UMIinR*.R*.fq

#final clean-up not done yet to have the chance of repeating sth 