rule samtools:
    input:
        "{TEMPDIR}/{run}/tmp/bam/out/FSLA_{cond}_{name}_Aligned.sortedByCoord.out.bam"   
    output:
        "{TEMPDIR}/{run}/tmp/bam/filtered/FSLA_{cond}_{name}_Aligned.sortedByCoord.filtered.bam"
    conda:
        "../envs/alignment.yaml"
    params:
        nthreads=config['samtools']['threads'],
        flag=config['samtools']['flag'],
    shell:
        """samtools view -@ {params.nthreads} -Sb -F {params.flag} {input} > {output}
        samtools index {output}"""

rule star:
    input:
        R1= "{TEMPDIR}/{run}/tmp/combfq/FSLA_{cond}_{name}_R1_001.comb.fastq.gz",
        R2= "{TEMPDIR}/{run}/tmp/combfq/FSLA_{cond}_{name}_R2_001.comb.fastq.gz",
    output:
        "{TEMPDIR}/{run}/tmp/bam/out/FSLA_{cond}_{name}_Aligned.sortedByCoord.out.bam"
    conda:
        "../envs/alignment.yaml"
    params:
        nthreads=config['star']['threads'],
        limit=config['star']['RAMlimit'],
        genomeLoad=config['star']['genomeLoad'],
        genomeDir=config['star']['genomeDir'],
        readfiles=config['star']['readfiles'],
        insertlimit=config['star']['insertlimit'],
        filterIn=config['star']['filter'],
        outdtype=config['star']['outdtype'],
        prefix=config['star']['prefix'],
    shell:
        """STAR --runThreadN {params.nthreads} --limitBAMsortRAM {params.limit} --genomeLoad {params.genomeLoad} --genomeDir {params.genomeDir} --readFilesIn {input.R1} {input.R2} --readFilesCommand {params.readfiles} --limitSjdbInsertNsj {params.insertlimit} --outFilterIntronMotifs {params.filterIn} --outSAMtype {params.outdtype} --outFileNamePrefix {params.prefix}"""
