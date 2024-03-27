rule counts:
    input:
        "{TEMPDIR}/{run}/tmp/bam/filtered/{name}_Aligned.sortedByCoord.filtered.bam"
    output:
        bam="{TEMPDIR}/bam/{run}/{cond}/{name}_Aligned.sortedByCoord.filtered.bam",
        counts="{TEMPDIR}/count/{run}/{cond}/{name}_ReadCount.featureCounts.gencode.txt"
    conda:
        "../envs/subread.yaml"
    params:
        gtf=config['featurecounts']['GTF'],
        overlap=config['featurecounts']['overlap'],
        dtype=config['featurecounts']['datatype'],
        nthreads=config['featurecounts']['nthreads'],
        geneid=config['featurecounts']['geneidentifier']
    shell:
        """featureCounts -T {params.nthreads} -p --countReadPairs -t {params.dtype} -g {params.geneid} --fracOverlap {params.overlap} -a {params.gtf} -o {output.bam} {output.counts}
        rm -rf -R {TEMPDIR}"""