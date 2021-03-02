#Load data from csv and make smaller
library(dplyr)
mhcld_data <- read.csv("MHCLD_PUF_2018.csv")
mhcld_data <- mhcld_data[!duplicated(mhcld_data$CASEID), ]
smaller <- mhcld_data %>% 
  filter(AGE != -9, EDUC != -9, ETHNIC != -9, RACE != -9, MH1 != -9) %>%
  select(AGE:GENDER, MH1, NUMMHS:ODDFLG, SCHIZOFLG, ALCSUBFLG, STATEFIP:REGION) %>%
  write.csv(file = "~/Desktop/Small_MHCLD.csv", row.names = F)