#! /usr/bin/bash

#Count Matrix UMI

GTF="/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/human_ref/gencode.v43.primary_assembly.basic.annotation.gtf"
mkdir /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi
 
# 1. Assign UMI reads to features

sample_list=/data/gpfs-1/users/hedler_m/scratch/STAR/*.sortedByCoord.filtered.bam

for sample in $sample_list
do
ID="$(basename -- ${sample:0:${#sample}-39})"
echo $ID

featureCounts -T 1 -p --countReadPairs -t exon -g gene_name -s 1 --fracOverlap 0.25 -a "$GTF" -R BAM -o /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID"_Aligned.txt /data/gpfs-1/users/hedler_m/scratch/STAR/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam
	
# 2. Sort and Index Reads
samtools sort  -@ 10 /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam.featureCounts.bam -o /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam.featureCounts.sorted.bam
samtools index /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam.featureCounts.sorted.bam

# 3. Deduplicate and Count UMI Reads
umi_tools count --per-gene --paired --gene-tag=XT --chimeric-pairs=discard --unpaired-reads=discard --assigned-status-tag=XS -I /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID"_UMI_Aligned.sortedByCoord.filtered.bam.featureCounts.sorted.bam -S /data/gpfs-1/users/hedler_m/work/FEATURECOUNTSumi/"$ID".umi.counts.tsv.gz

done