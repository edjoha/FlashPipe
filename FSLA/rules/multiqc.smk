rule multiqc:
    input:
        "{TEMPDIR}/counts/"
    output:
        "{TEMPDIR}/multiqc/multiqc_report.html"
    params:
      extra="--verbose",
    wrapper:
        "v3.7.0-10-g491d5b6/bio/multiqc"
