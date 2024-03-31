TEMPDIR=config["temp"]
rule multiqc:
    input:
      expand("{TEMPDIR}/counts/{sample}_ReadCount.featureCounts.gencode.txt.summary", sample=samples['sampleName'], TEMPDIR=TEMPDIR),
      expand("{TEMPDIR}/tmp/bam/out/{sample}_Log.final.out", sample=samples['sampleName'], TEMPDIR=TEMPDIR)
    output: "qc/multiqc_report.html"
    wrapper:
        "v3.7.0-10-g491d5b6/bio/multiqc"
