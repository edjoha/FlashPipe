#! /usr/bin/bash
#INT mapping

# 0. Variables
GENOME="/data/gpfs-1/users/hedler_m/work/STAR_indexed_genome"
#FASTQ_R1="/data/gpfs-1/users/hedler_m/work/internalReads/R1/*.umi.R1.fq"
#FASTQ_R2="/data/gpfs-1/users/hedler_m/work/internalReads/R1/*.umi.R2.fq"d

# 1. Mapping

mkdir /data/gpfs-1/users/hedler_m/scratch/STARin
sample_list=/data/gpfs-1/users/hedler_m/work/internalReads/R1/*

for sample in $sample_list
do
ID="$(basename -- ${sample:0:${#sample}-22})"
name1="$ID"_R1_001
name2="$ID"_R2_001
echo $ID
echo $name1
echo $name2

STAR --runThreadN 10 --limitBAMsortRAM 20000000000 --genomeLoad LoadAndKeep --genomeDir $GENOME --readFilesIn "/data/gpfs-1/users/hedler_m/work/internalReads/R1/$name1.internal.R1.fq" "/data/gpfs-1/users/hedler_m/work/internalReads/R2/$name2.internal.R2.fq" --readFilesCommand cat --limitSjdbInsertNsj 2000000 --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outSAMtype BAM SortedByCoordinate --outFileNamePrefix /data/gpfs-1/users/hedler_m/scratch/STARin/"$ID"_INTERNAL_

# 2. SAM to sorted BAM
# -F 260 filters out unmapped and secondary alignments
samtools view -@ 5 -Sb -F 260 /data/gpfs-1/users/hedler_m/scratch/STARin/"$ID"_INTERNAL_Aligned.sortedByCoord.out.bam > /data/gpfs-1/users/hedler_m/scratch/STARin/"$ID"_INTERNAL_Aligned.sortedByCoord.filtered.bam
samtools index /data/gpfs-1/users/hedler_m/scratch/STARin/"$ID"_INTERNAL_Aligned.sortedByCoord.filtered.bam

done