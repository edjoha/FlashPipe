#! /usr/bin/bash

#extract UMI in both

sample_list1=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R1/*.UMIinR1.R1.fq
sample_list2=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR2_R1/*.UMIinR2.R1.fq

for R1 in $sample_list1
do
echo $R1
cat $R1 | uniq | awk 'NR%4==1{print}' | sed 's/\@//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.txt
done

for R2 in $sample_list2
do
echo $R2
cat $R2 | uniq | awk 'NR%4==1{print}' | sed 's/\@//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.txt
done

cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.txt | sed 's/_........ .*$//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.cleaned
cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.txt | sed 's/_........ .*$//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.cleaned
comm -12 <(sort /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.cleaned) <(sort /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.cleaned) > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1R2.toFilterOut

echo "===> Number of R1-R2 with both a UMI: $(wc -l /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1R2.toFilterOut) <==="
echo "===> Number of R1 UMI before cleanup: $(wc -l /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.txt) <==="
echo "===> Number of R2 UMI before cleanup: $(wc -l /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.txt) <==="