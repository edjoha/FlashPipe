#from pathlib import Path
import pandas as pd

##### load config and sample sheets #####

config: "config/config.yaml"

samples = pd.read_csv(config["samples"], sep="\t").set_index("sample", drop=False)