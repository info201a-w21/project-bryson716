#Loading packages in
library(dplyr)
library(tidyverse)

data <- read.csv("data/small_MHCLD.csv")

#Proportion of ages in MHCLD dataset
Ages <- data %>% 
  group_by(AGE) %>%
  summarise_all(sum) 


Ages <- subset(Ages, select = -c(EDUC:MH1 , STATEFIP:REGION))

# Renaming rows


Ages$AGE[Ages$AGE  == "1"]  <- "0-11 years old"
Ages$AGE[Ages$AGE  == "2"]  <- "12-14 years old"
Ages$AGE[Ages$AGE  == "3"]  <- "15-17 years old"
Ages$AGE[Ages$AGE  == "4"]  <- "18-20 years old"
Ages$AGE[Ages$AGE  == "5"]  <- "21-24 years old"
Ages$AGE[Ages$AGE  == "6"]  <- "25-29 years old"
Ages$AGE[Ages$AGE  == "7"]  <- "30-34 years old"
Ages$AGE[Ages$AGE  == "8"]  <- "35-39 years old"
Ages$AGE[Ages$AGE  == "9"]  <- "40-44 years old"
Ages$AGE[Ages$AGE  == "10"]  <- "45-49 years old"
Ages$AGE[Ages$AGE  == "11"]  <- "50-54 years old"
Ages$AGE[Ages$AGE  == "12"]  <- "55-59 years old"
Ages$AGE[Ages$AGE  == "13"]  <- "60-64 years old"
Ages$AGE[Ages$AGE  == "14"]  <- "65 years and older"

#Renaming columns

Ages <- Ages %>% 
  rename(
    Number_of_Mental_Health_Diagnoses_Reported = NUMMHS,
    Trauma_or_stressor_related_disorder_reported = TRAUSTREFLG,
    Anxiety_disorder_reported = ANXIETYFLG,
    ADHD_reported = ADHDFLG,
    Counduct_disorder = CONDUCTFLG,
    Delirium_Dementia_disorder = DELIRDEMFLG,
    Bipolar_disorder = BIPOLARFLG,
    Depressive_disorder = DEPRESSFLG,
    Oppositional_Defiant_disorder = ODDFLG,
    Schizophrenia_disorder = SCHIZOFLG,
    Alcohol_or_substance_related_disorder = ALCSUBFLG
  )

##Proportion of races/ethnicities in MHCLD dataset

Races <- data %>% 
  group_by(RACE) %>%
  summarise_all(sum) 

Races <- subset(Races, select = -c(AGE:ETHNIC, GENDER:MH1, STATEFIP:REGION))

# Renaming rows


Races$RACE[Races$RACE  == "1"]  <- "American Indian/Alaska Native"
Races$RACE[Races$RACE  == "2"]  <- "Asian"
Races$RACE[Races$RACE  == "3"]  <- "Black or African American"
Races$RACE[Races$RACE  == "4"]  <- "Native Hawaiian or Other Pacific Islander"
Races$RACE[Races$RACE  == "5"]  <- "White"
Races$RACE[Races$RACE  == "6"]  <- "Another race alone or two or more races"

#Renaming columns
Races <- Races %>% 
  rename(
    Number_of_Mental_Health_Diagnoses_Reported = NUMMHS,
    Trauma_or_stressor_related_disorder_reported = TRAUSTREFLG,
    Anxiety_disorder_reported = ANXIETYFLG,
    ADHD_reported = ADHDFLG,
    Counduct_disorder = CONDUCTFLG,
    Delirium_Dementia_disorder = DELIRDEMFLG,
    Bipolar_disorder = BIPOLARFLG,
    Depressive_disorder = DEPRESSFLG,
    Oppositional_Defiant_disorder = ODDFLG,
    Schizophrenia_disorder = SCHIZOFLG,
    Alcohol_or_substance_related_disorder = ALCSUBFLG
  )
###Proportion of sex in MHCLD dataset

Genders_sex <- data %>% 
  group_by(GENDER) %>%
  summarise_all(sum) %>% 
  slice(2:3)

Genders_sex <- subset(Genders_sex, select = -c(AGE:RACE,MH1, STATEFIP:REGION))

# Renaming rows

Genders_sex$GENDER[Genders_sex$GENDER  == "1"]  <- "Male"
Genders_sex$GENDER[Genders_sex$GENDER  == "2"]  <- "Female"

#Renaming columns
Genders_sex <- Genders_sex %>% 
  rename(
    Number_of_Mental_Health_Diagnoses_Reported = NUMMHS,
    Trauma_or_stressor_related_disorder_reported = TRAUSTREFLG,
    Anxiety_disorder_reported = ANXIETYFLG,
    ADHD_reported = ADHDFLG,
    Counduct_disorder = CONDUCTFLG,
    Delirium_Dementia_disorder = DELIRDEMFLG,
    Bipolar_disorder = BIPOLARFLG,
    Depressive_disorder = DEPRESSFLG,
    Oppositional_Defiant_disorder = ODDFLG,
    Schizophrenia_disorder = SCHIZOFLG,
    Alcohol_or_substance_related_disorder = ALCSUBFLG
  )

# Rename values in MH1 Column
data$MH1 <- data$MH1 %>%
  str_replace_all("10", "Personality Disorder") %>%
  str_replace_all("11", "Schizophrenia") %>%
  str_replace_all("12", "Substance Abuse") %>%
  str_replace_all("13", "Other") %>%
  str_replace_all("1", "Trauma") %>%
  str_replace_all("2", "Anxiety Disorder") %>%
  str_replace_all("3", "ADD/ADHD") %>%
  str_replace_all("4", "Conduct Disorder") %>%
  str_replace_all("5", "Delirium/Dementia") %>%
  str_replace_all("6", "Bipolar") %>%
  str_replace_all("7", "Depression") %>%
  str_replace_all("8", "ODD") %>%
  str_replace_all("9", "PDD")

# Most common Mental illness
most_common <- data %>%
  select(MH1) %>%
  filter(MH1 != "NA") %>%
  group_by(MH1) %>%
  summarise("freq" = length(MH1)) %>%
  filter(freq == max(freq)) %>%
  pull(MH1)

# Least common mental illness

least_common <- data %>%
  select(MH1) %>%
  filter(MH1 != "NA") %>%
  group_by(MH1) %>%
  summarise("freq" = length(MH1)) %>%
  filter(freq == min(freq)) %>%
  pull(MH1)

least_common <- "Delirium, Dementia"

# More males or females?
males_or_females <- data %>%
  select(GENDER) %>%
  filter(GENDER != "NA") %>%
  group_by(GENDER) %>%
  summarise("freq" = length(GENDER)) %>%
  filter(freq == max(freq)) %>%
  pull(GENDER)

more_males_females <- "Females"

# Most common age range?
most_common_age <- data %>%
  select(AGE) %>%
  filter(AGE != "NA") %>%
  group_by(AGE) %>%
  summarise("freq" = length(AGE)) %>%
  filter(freq == max(freq)) %>%
  pull(AGE)

most_popular_age_range <- "0-11 years old"

# Most prevalent mental illness among minority groups

Only_minorites <- data %>% 
  
