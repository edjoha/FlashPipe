#! /usr/bin/bash

#extract Umi in R2

sample_list=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R2/R2/P3160_FSUMI*.fastq.gz

for sample in $sample_list
do
R1="$(basename -- ${sample:0:${#sample}-16}_R1_001)"
R2="$(basename -- ${sample:0:${#sample}-16}_R2_001)"
name="$(basename -- ${sample:0:${#sample}-16})"

echo $name
echo $R1
echo $R2

umi_tools extract --bc-pattern="^(?P<discard_1>GAGT|AGT|GT)(?P<umi_1>.{8})(?P<discard_2>CTAACGG)(?P<discard_3>G{0,4})" --stdin=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R2/R2/$R2.fastq.gz --stdout=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR2_R2/$name.UMIinR2.R2.fq  --read2-in=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R1/R1/$R1.fastq.gz --read2-out=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR2_R1/$name.UMIinR2.R1.fq --extract-method=regex

done