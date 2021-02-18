# Load the packages 
library(tidyverse)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(treemapify)

# create color scheme
color_scheme <- c( "slateblue1", "paleturquoise2", "darkseagreen1", "palegreen", 
                   "turquoise", "mediumaquamarine", "mediumseagreen", "mediumpurple")
#                   "slateblue1", "slateblue4", "steelblue4", "royalblue4", "navy")

# Load the Unemployment and Mental Illness Survey data into a variable  
df <- read.csv("data/unemploymentdata.csv", stringsAsFactors = FALSE)

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

# Stacked bar chart
stacked_barchart <- ggplot(df, aes(fill = Gender, y = Have_MentalIllness, x = Curr_Employed)) + 
  geom_bar(position = "stack", stat="identity") +
  scale_fill_manual(values = c("mediumpurple", "turquoise"))  +
  scale_x_continuous(breaks = seq(0, 1.0, by=1), 
                     labels = c("Unemployed", "Employed")) +
  blank_theme + 
  labs(x = "Employment", 
       y = "Identify as Having a Mental Illness", 
       title = "The Interesections of Unemployment, Gender, and Mental Health") +
  theme(plot.title = element_text(hjust = 0.5))  

print(stacked_barchart)

# Treemap
tree_data <- df %>%
  select(Curr_Employed, Have_MentalIllness, Gender) %>%
  mutate(Curr_Employed = recode(Curr_Employed,
                                `0`="Unemployed",
                                `1`="Currently Employed")) %>%
  mutate(Have_MentalIllness = recode(Have_MentalIllness,
                                     `0`="Does not have mental illness",
                                     `1`="Have mental illness")) %>%
  group_by(Curr_Employed, Gender, Have_MentalIllness) %>%
  tally()

treemap_chart <- ggplot(tree_data, aes(area = n, subgroup = Curr_Employed,
                      subgroup2 = Gender, subgroup3 = Have_MentalIllness)) +
  geom_treemap(layout = "srow", fill = color_scheme) +
  geom_treemap_subgroup3_border(layout = "srow", color = "white", size = 1) +
  geom_treemap_subgroup2_border(layout = "srow", color = "white", size = 7) +
  geom_treemap_subgroup_border(layout = "srow", color = "black", size = 7) +
  geom_treemap_subgroup_text(layout = "srow", place = "center", grow = FALSE,
                             size = 26) +
  geom_treemap_subgroup2_text(layout = "srow", place = "topleft", grow = FALSE,
                              padding.x = grid::unit(6, "points"),
                              padding.y = grid::unit(10, "points"), size = 16) +
  geom_treemap_subgroup3_text(layout = "srow", place = "bottom", grow = FALSE,
                              padding.y = grid::unit(6, "points"), size = 12,
                              reflow = TRUE) +
  theme(legend.position = "none") +
  ggtitle("The Interesections of Unemployment, \nGender, and Mental Health") +
  theme(plot.title = element_text(hjust = 0.5, size = 26))

print(treemap_chart)

