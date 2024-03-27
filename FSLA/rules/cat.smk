if config["cat"]["enable"]:
  rule cat:
      input:  
          L1R = "/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/test/{run}_FSLA_{cond}_{name}_L001_{read}_001.fastq.gz",
          L2R = "/data/gpfs-1/users/hedler_m/ag_ludwig/work/P3160_20230530/fastqs_core/FS_LA/test/{run}_FSLA_{cond}_{name}_L002_{read}_001.fastq.gz",
      output:
          "{TEMPDIR}/{run}/tmp/combfq/FSLA_{cond}_{name}_{read}_001.comb.fastq.gz"
      shell:
         """cat {input.L1R} {input.L2R} > {output}"""