# Load the packages 
library(tidyverse)
library(ggplot2)
library(dplyr)
library(colorspace)
library(colorblindr)

# Load the Unemployment and Mental Illness Survey data into a variable  
df <- read.csv("unemploymentdata.csv", stringsAsFactors = FALSE)

# Rename specific column names ("I.am.currently.employed.at.least.part.time"
# and ("I.identify.as.having.a.mental.illness") to Employed and Have_MentalIllness
colnames(df)[1] <- "Curr_Employed" 
colnames(df)[2] <- "Have_MentalIllness"

# How many people are employed? 
employment <- df %>% 
  summarize(
    employed = sum(Curr_Employed == 1), 
    unemployed = sum(Curr_Employed == 0), 
  )
employment

# How many people identify as having a mental illness? 
mentalillness <- df %>% 
  summarize(
    yes = sum(Have_MentalIllness == 1), 
    no = sum(Have_MentalIllness == 0), 
  )
mentalillness

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

stacked_barchart <- ggplot(df, aes(fill = Education, y = Have_MentalIllness, x = Curr_Employed)) + 
  geom_bar(position = "stack", stat="identity") +
  scale_fill_OkabeIto()  +
  theme(axis.text.x = element_text(hjust = 1)) + 
  scale_x_continuous(breaks = seq(0, 1.0, by=1), 
                     labels = c("Unemployed", "Employed")) +
  blank_theme + 
  labs(x = "Employment", 
       y = "Identify as Having a Mental Illness", 
       title = "The Interesections of Unemployment, Education, and Mental Health") +
  theme(plot.title = element_text(hjust = 0.5))  

print(stacked_barchart)

