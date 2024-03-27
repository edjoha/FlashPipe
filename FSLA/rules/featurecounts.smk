rule counts:
    input:
        "{TEMPDIR}/{run}/tmp/bam/filtered/FSLA_{cond}_{name}_Aligned.sortedByCoord.filtered.bam"
    output:
        bam="{TEMPDIR}/bam/{run}/{cond}/FSLA_{cond}_{name}__Aligned.sortedByCoord.filtered.bam",
        counts="{TEMPDIR}/count/{run}/{cond}/FSLA_{cond}_{name}__ReadCount.featureCounts.gencode.txt"
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