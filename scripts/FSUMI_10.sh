#! /usr/bin/bash

#Count Matrix internal reads

GTF="/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/human_ref/gencode.v43.primary_assembly.basic.annotation.gtf"
mkdir /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSint

sample_list=/data/gpfs-1/users/hedler_m/scratch/STARin/*.sortedByCoord.filtered.bam

for sample in $sample_list
do
ID="$(basename -- ${sample:0:${#sample}-44})"
echo $ID

featureCounts -T 1 -p --countReadPairs -t exon -g gene_name --fracOverlap 0.25 -a "$GTF" -o /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSint/"$ID"_INTERNAL_featureCounts.txt /data/gpfs-1/users/hedler_m/scratch/STARin/"$ID"_INTERNAL_Aligned.sortedByCoord.filtered.bam

done