#! /usr/bin/bash

#extract UMI in R1

sample_list=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R1/R1/P3160_FSUMI*.fastq.gz

for sample in $sample_list
do
R1="$(basename -- ${sample:0:${#sample}-16}_R1_001)"
R2="$(basename -- ${sample:0:${#sample}-16}_R2_001)"
name="$(basename -- ${sample:0:${#sample}-16})"

echo $name
echo $R1
echo $R2

umi_tools extract --bc-pattern="^(?P<discard_1>AAGCAGTGGTATCAACGCAGAGT|AGCAGTGGTATCAACGCAGAGT|GCAGTGGTATCAACGCAGAGT|CAGTGGTATCAACGCAGAGT|AGTGGTATCAACGCAGAGT|GTGGTATCAACGCAGAGT|TGGTATCAACGCAGAGT|GGTATCAACGCAGAGT|GTATCAACGCAGAGT|ATCAACGCAGAGT|CAACGCAGAGT|AACGCAGAGT|ACGCAGAGT|GCAGAGT|CAGAGT|AGAGT|GAGT|AGT|GT)(?P<umi_1>.{8})(?P<discard_2>CTAACGG)(?P<discard_3>G{0,4})" --stdin=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R1/R1/$R1.fastq.gz --stdout=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R1/$name.UMIinR1.R1.fq --read2-in=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R2/R2/$R2.fastq.gz --read2-out=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R2/$name.UMIinR1.R2.fq --extract-method=regex
done
