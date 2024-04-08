rule counts:
    input:
        "{TEMPDIR}/tmp/bam/filtered/{sample}_Aligned.sortedByCoord.filtered.bam"
    output:
        out="{TEMPDIR}/counts/{sample}_ReadCount.featureCounts.gencode.txt"
        qc="{TEMPDIR}/counts/{sample}_ReadCount.featureCounts.gencode.txt.summary"
    conda:
        "../envs/subread.yaml"
    params:
        gtf=config['featurecounts']['GTF'],
        overlap=config['featurecounts']['overlap'],
        dtype=config['featurecounts']['datatype'],
        nthreads=config['featurecounts']['nthreads'],
        geneid=config['featurecounts']['geneidentifier']
    shell:
        """
        featureCounts -T {params.nthreads} -p --countReadPairs -t {params.dtype} -g {params.geneid} --fracOverlap {params.overlap} -a {params.gtf} -o {output.out} {input}
        """
