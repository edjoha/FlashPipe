#! /usr/bin/bash
#filter out double UMI reads from UMI reads

grep -f /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1R2.toFilterOut /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R1umi.txt > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1.toFilterOut
grep -f /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1R2.toFilterOut /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/names.R2umi.txt > /data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R2.toFilterOut

sample_list=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R1/*

for sample in $sample_list
do

name="$(basename -- ${sample:0:${#sample}-14})"

echo $name

filterbyname.sh in=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R1/$name.UMIinR1.R1.fq in2=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR1_R2/$name.UMIinR1.R2.fq out=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR1.R1.tmp out2=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR1.R2.tmp names=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R1.toFilterOut include=f overwrite=t
filterbyname.sh in=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR2_R1/$name.UMIinR2.R1.fq in2=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/UMIinR2_R2/$name.UMIinR2.R2.fq out=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR2.R1.tmp out2=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR2.R2.tmp names=/data/gpfs-1/users/hedler_m/scratch/fastqOUT/txt/R2.toFilterOut include=f overwrite=t

mv /data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR1.R1.tmp /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R1/$name.UMIinR1.R1.fq
mv /data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR2.R1.tmp /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R1/$name.UMIinR2.R1.fq
mv /data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR1.R2.tmp /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R2/$name.UMIinR1.R2.fq
mv /data/gpfs-1/users/hedler_m/scratch/fastqOUT/$name.UMIinR2.R2.tmp /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R2/$name.UMIinR2.R2.fq

done

echo "===> Number of R1 UMI after cleanup: $(grep -c \@ /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR1_R1/$name.UMIinR1.R1.fq) <==="
echo "===> Number of R2 UMI after cleanup: $(grep -c \@ /data/gpfs-1/users/hedler_m/scratch/fastqOUT/new/UMIinR2_R1/$name.UMIinR2.R1.fq) <==="
