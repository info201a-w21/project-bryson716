#Data cleaning for MHCLD 2018 Data Set
library(tidyverse)

data <- read.csv("data/Small_MHCLD.csv")

data$GENDER <- data$GENDER %>% 
  str_replace_all("1", "Male") %>% 
  str_replace_all("2", "Female") %>% 
  str_replace_all("-9", "Unknown") 

data$RACE <- data$RACE %>%
  str_replace_all("1", "American Indian/Alaska Native") %>%
  str_replace_all("2", "Asian") %>%
  str_replace_all("3", "Black/African American") %>%
  str_replace_all("4", "Native Hawaiian/Pacific Islander") %>%
  str_replace_all("5", "White") %>%
  str_replace_all("6", "Multiracial/Other") %>%
  str_replace_all("-9", "Unknown")

data$MH1 <- data$MH1 %>%
  str_replace_all("10", "Personality Disorders") %>%
  str_replace_all("11", "Schizophrenia") %>%
  str_replace_all("12", "Substance Abuse") %>%
  str_replace_all("13", "Other") %>%
  str_replace_all("1", "Trauma-Related Disorders") %>%
  str_replace_all("2", "Anxiety Disorders") %>%
  str_replace_all("3", "ADD/ADHD") %>%
  str_replace_all("4", "Conduct Disorder") %>%
  str_replace_all("5", "Delirium/Dementia") %>%
  str_replace_all("6", "Bipolar Disorder") %>%
  str_replace_all("7", "Depressive Disorders") %>%
  str_replace_all("8", "Oppositional Defiant Disorder") %>%
  str_replace_all("9", "Pervasive Developmental Disorder")

mhcld <- data %>%
  select(AGE, EDUC, RACE, ETHNIC, GENDER, MH1)


