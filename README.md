# Flash⚡Pipe
– a Snakemake based analysis pipeline for Flash-Seq data

## Purpose
This pipeline was developed within the scope of a course project in the [Master-BIDS studies](https://www.master-bids.hs-mannheim.de). It was designed to preprocess [Flash-Seq Low amplification](https://doi.org/10.1007/978-1-0716-2756-3_5) data, starting with FASTQ files. The resulting gene count files per cell can further be joined to a gene count matrix for downstream analysis. In addition, a [MultiQC](https://multiqc.info) report is generated to visualize mapping quality.


## How to use



## Example data
### FASTQ.GZ

Example data was downloaded from SRA archive via

$prefetch SRR18383753 -O fsla
$fasterq-dump --split-3 fsla/SRR18383753 -O fsla/fastq

As this pipeline was developed to use in our standard data preperation routine, the provided data was renamed to our lab internal standard for Flash Seq data and serves just as a publicly available replacement for our unpublished lab internal data. It is only used to demostrate the functionality of the pipeline and not meant to be set in a biological context.

The original SRR accession numbers are provided in the metadata file.

They all belong to PRJNA816486, published online by Hahaut et al. 2022.

### GTF

The GTF file was generated with STAR --genomeGenerate

FASTA="../GRCh38.primary_assembly.genome.fa"
GTF="../gencode.v43.primary_assembly.basic.annotation.gtf"

STAR --runThreadN 15 --runMode genomeGenerate --genomeDir $OUTPUTDIR --genomeFastaFiles $FASTA --sjdbGTFfile $GTF --sjdbOverhang 79

Therefore, the latest release of the FASTA sequence file for the human genome was downloaded on https://www.gencodegenes.org/human/ (Release 45 (GRCh38.p14)). Due to the file size limit on Github, this file cannot be provided here.

## 
