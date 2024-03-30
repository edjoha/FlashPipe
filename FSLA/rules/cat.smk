if config["cat"]["enable"]:
  rule cat:
      input:  
          L1R = "/data/gpfs-1/users/hedler_m/work/repos/FlashPipe/FSLA/data/{sample}_L001_{read}_001.fastq.gz",
          L2R = "/data/gpfs-1/users/hedler_m/work/repos/FlashPipe/FSLA/data/{sample}_L002_{read}_001.fastq.gz",
      output:
          "{TEMPDIR}/tmp/combfq/{sample}_{read}_001.comb.fastq.gz"
      shell:
         """cat {input.L1R} {input.L2R} > {output}"""
