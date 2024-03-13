#! /usr/bin/bash

#cat the reads of lane 1+2
#very first step for FS when more than one lane was used for sequencing

sample_list=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/*L001_R1_001.fastq.gz

for sample in $sample_list
do
L1R1="$(basename -- ${sample:0:${#sample}-21}_L001_R1_001)"
L2R1="$(basename -- ${sample:0:${#sample}-21}_L002_R1_001)"
L1R2="$(basename -- ${sample:0:${#sample}-21}_L001_R2_001)"
L2R2="$(basename -- ${sample:0:${#sample}-21}_L002_R2_001)"
name1="$(basename -- ${sample:0:${#sample}-21}_R1_001)"
name2="$(basename -- ${sample:0:${#sample}-21}_R2_001)"
echo $L1R1
echo $L2R1
echo $L1R2
echo $L2R2
echo $name1
echo $name2

cat /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/$L1R1.fastq.gz /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/$L2R1.fastq.gz > /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/R1/$name1.fastq.gz
cat /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/$L1R2.fastq.gz /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/$L2R2.fastq.gz > /data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R2/$name2.fastq.gz

done