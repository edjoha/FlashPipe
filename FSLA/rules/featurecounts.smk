rule counts:
    input: "{TEMPDIR}/bam/filtered/{run}_FSLA_{cond}_{sample}_Aligned.sortedByCoord.filtered.bam"
    output: bam="{OUTDIR}/{run}/bam/{cond}_{sample}_Aligned.sortedByCoord.filtered.bam",
            count="{OUTDIR}/{run}/count/{cond}_{sample}_ReadCount.featureCounts.gencode.txt"
    conda: "../envs/subread.yaml"
    params: gtf=congig['GTF'],
            overlap=config['featurecounts']['overlap'],
            dtype=config['featurecounts']['datatype'],
            nthreads=config['featurecounts']['nthreads'],
            geneid=config['featurecounts']['geneidentifier']
    shell: featureCounts -T {params.nthreads} -p --countReadPairs -t {params.dtype} -g {params.geneid} --fracOverlap {params.overlap} -a {params.gtf} -o {output.bam} {output.count}