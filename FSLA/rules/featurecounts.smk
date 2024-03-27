rule counts:
    input:
        "{TEMPDIR}/{run}/tmp/bam/filtered/FSLA_{cond}_{name}_Aligned.sortedByCoord.filtered.bam"
    output:
        "{TEMPDIR}/counts/{run}/{cond}/FSLA_{cond}_{name}_ReadCount.featureCounts.gencode.txt"
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
        featureCounts -T {params.nthreads} -p --countReadPairs -t {params.dtype} -g {params.geneid} --fracOverlap {params.overlap} -a {params.gtf} -o {output} {input}
        """
