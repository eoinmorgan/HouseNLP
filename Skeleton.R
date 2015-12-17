# directory creation
dir.create("./rawdata")
dir.create("./data")
# copy pre-calculated frequency data
file.copy("./noun_counts.csv", "./data/noun_counts.csv")