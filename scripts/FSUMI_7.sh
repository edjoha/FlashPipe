#! /usr/bin/bash

#UMI mapping

# 0. Variables
GENOME="/data/gpfs-1/users/hedler_m/work/STAR_indexed_genome"
#FASTQ_R1="/data/gpfs-1/users/hedler_m/work/UMIreads/R1/*.umi.R1.fq"
#FASTQ_R2="/data/gpfs-1/users/hedler_m/work/UMIreads/R1/*.umi.R2.fq"

# 1. Mapping

sample_list=/data/gpfs-1/users/hedler_m/work/UMIreads/R1/*

for sample in $sample_list
do
ID="$(basename -- ${sample:0:${#sample}-10})"

echo $ID

STAR --runThreadN 10 --limitBAMsortRAM 20000000000 --genomeLoad LoadAndKeep --genomeDir $GENOME --readFilesIn "/data/gpfs-1/users/hedler_m/work/UMIreads/R1/$ID.umi.R1.fq" "/data/gpfs-1/users/hedler_m/work/UMIreads/R2/$ID.umi.R2.fq" --readFilesCommand cat --limitSjdbInsertNsj 2000000 --seedSearchStartLmax 30 --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outSAMtype BAM SortedByCoordinate --outFileNamePrefix /data/gpfs-1/users/hedler_m/scratch/STAR/"$ID"_UMI_

# 2. SAM to sorted BAM
# -F 260 filters out unmapped and secondary alignments
samtools view -@ 5 -Sb -F 260 /data/gpfs-1/users/hedler_m/scratch/STAR/"$ID"_UMI_Aligned.sortedByCoord.out.bam > /data/gpfs-1/users/hedler_m/scratch/STAR/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam
samtools index /data/gpfs-1/users/hedler_m/scratch/STAR/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam

done
