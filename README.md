# Flash⚡Pipe
– a Snakemake based analysis pipeline for Flash-Seq data

## Purpose
This pipeline was developed within the scope of a course project in the [Master-BIDS studies programme](https://www.master-bids.hs-mannheim.de). It was designed to preprocess [Flash-Seq Low amplification](https://doi.org/10.1007/978-1-0716-2756-3_5) data, starting with FASTQ files. The resulting gene count files per cell can further be joined to a gene count matrix for downstream analysis. In addition, a [MultiQC](https://multiqc.info) report is generated to visualize mapping quality.


## How to use
1. Clone Repo to local or remote machine.

```$ git clone https://github.com/edjoha/FlashPipe.git```

2. Adjust file names ([samples.tsv](FSLA/config/samples.tsv)), file paths ([config.yaml](FSLA/config/config.yaml), [samples.tsv](FSLA/config/samples.tsv), [cat.smk](FSLA/rules/cat.smk)) and parameter settings in the [config.yaml](FSLA/config/config.yaml) (if needed). Since example data is provided, file paths to sample files can be used without adjustment.
3. Download and generate the GTF file ([see below](https://github.com/edjoha/FlashPipe/tree/main?tab=readme-ov-file#gtf)).
4. [Install Snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) (e.g. in a Conda environment
   ```
   $ conda install -n base -c conda-forge mamba
   $ mamba create -c conda-forge -c bioconda -n snakemake snakemake
   $ mamba activate snakemake
   ```
6. Pipeline can be tested in a dry run by using ` $ snakemake -n -p --use-conda`.
7. For running FlashPipe, use `$ snakemake --use-conda`.

## Example data
### FASTQ.GZ

Example data was generated in the [Single Cell Focus Area](https://www.bihealth.org/en/research/focus-areas/single-cell-technologies), BIH at MDC-BIMSB, Berlin as part of a test experiment. Data from two individual cells, processed under slightly different conditions are provided.

### GTF

The GTF file was generated with [STAR](https://github.com/alexdobin/STAR) --genomeGenerate:
```
FASTA="../GRCh38.primary_assembly.genome.fa"
GTF="../gencode.v43.primary_assembly.basic.annotation.gtf"

STAR --runThreadN 15 --runMode genomeGenerate --genomeDir $OUTPUTDIR --genomeFastaFiles $FASTA --sjdbGTFfile $GTF --sjdbOverhang 79
```

Therefore, the latest release of the FASTA sequence file for the human genome was downloaded on [Gencode (Release 45 (GRCh38.p14)](https://www.gencodegenes.org/human/). Due to the file size limit on Github, **this file cannot be provided** here.

## License

Please find License information [here](https://github.com/edjoha/FlashPipe/blob/main/LICENSE).
