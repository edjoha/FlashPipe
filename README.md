# Flash⚡Pipe
– a snakemake based analysis pipeline for FlashSeq data

## Purpose



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

The GTF file is provided to facilitate pipeline setup. It was generated with STAR --genomeGenerate

FASTA="../GRCh38.primary_assembly.genome.fa"
GTF="../gencode.v43.primary_assembly.basic.annotation.gtf"

STAR --runThreadN 15 --runMode genomeGenerate --genomeDir $OUTPUTDIR --genomeFastaFiles $FASTA --sjdbGTFfile $GTF --sjdbOverhang 79


