#Load data from spss
library(haven)
MHCLD_data <- read_sav("MHCLD_PUF_2018.sav")
nrow(MHCLD_data)
ncol(MHCLD_data)
write.csv(MHCLD_data, file = "MHCLD_Data_2018")