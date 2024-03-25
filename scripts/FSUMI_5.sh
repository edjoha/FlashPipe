#! /usr/bin/bash
#Separate internal from UMI Reads

sample_list=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R1/*

for sample in $sample_list
do

name="$(basename -- ${sample:0:${#sample}-14})"
name1="$(basename -- ${sample:0:${#sample}-14}_R1_001)"
name2="$(basename -- ${sample:0:${#sample}-14}_R2_001)"
echo $name
echo $name1
echo $name2

cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R1/$name.UMIinR1.R1.fq | uniq | awk 'NR%4==1{print}' | sed 's/\@//g' | sed 's/_........//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names_new.R1umi.txt
cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R1/$name.UMIinR2.R1.fq | uniq | awk 'NR%4==1{print}' | sed 's/\@//g' | sed 's/_........//g' > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names_new.R2umi.txt
sed -i 's/_........//g' /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1.toFilterOut
sed -i 's/_........//g' /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R2.toFilterOut
cat /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names_new.R1umi.txt /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names_new.R2umi.txt /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1.toFilterOut /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R2.toFilterOut > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.umi.txt

filterbyname.sh in=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R1/R1/$name1.fastq.gz in2=/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_UMI/R2/R2/$name2.fastq.gz out=/data/gpfs-1/users/hedler_m/work/internalReads/R1/$name1.internal.R1.fq out2=/data/gpfs-1/users/hedler_m/work/internalReads/R2/$name2.internal.R2.fq names=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.umi.txt include=f overwrite=t

done

echo "===> Number of Internal Reads after cleanup: $(grep -c \@ /data/gpfs-1/users/hedler_m/work/internalReads/R1/$name1.internal.R1.fq) <==="