#! /usr/bin/bash

#FSLA Mapping

# 0. Variables
GENOME="/data/gpfs-1/users/hedler_m/work/STAR_indexed_genome"
#FASTQ="/path/to/sample.R1.fastq.gz"

# 1. Mapping

mkdir /data/gpfs-1/users/hedler_m/scratch/STAR_FSLA
sample_list=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/R1/*.fastq.gz

for sample in $sample_list
do
ID="$(basename -- ${sample:0:${#sample}-16})"
name1="$ID"_R1_001
name2="$ID"_R2_001

echo $ID
echo $name1
echo $name2

STAR --runThreadN 30 --limitBAMsortRAM 20000000000 --genomeLoad LoadAndKeep --genomeDir $GENOME --readFilesIn "/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R1/R1/$name1.fastq.gz" "/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/R2/$name2.fastq.gz" --readFilesCommand zcat --limitSjdbInsertNsj 2000000 --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outSAMtype BAM SortedByCoordinate --outFileNamePrefix /data/gpfs-1/users/hedler_m/scratch/STAR_FSLA/"$ID"_

# 2. SAM to sorted BAM
# -F 260 filters out unmapped and secondary alignments
samtools view -@ 30 -Sb -F 260 /data/gpfs-1/users/hedler_m/scratch/STAR_FSLA/"$ID"_Aligned.sortedByCoord.out.bam > /data/gpfs-1/users/hedler_m/scratch/STAR_FSLA/"$ID"_Aligned.sortedByCoord.filtered.bam
samtools index /data/gpfs-1/users/hedler_m/scratch/STAR_FSLA/"$ID"_Aligned.sortedByCoord.filtered.bam

done