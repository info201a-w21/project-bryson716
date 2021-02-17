library(tidyverse)
library(stringr)
data <- read.csv("Small_MHCLD.csv")
data <- select(data, ETHNIC, RACE, MH1)

# edit text
data$RACE <- data$RACE %>%
  str_replace_all("1", "American Indian/Alaska Native") %>%
  str_replace_all("2", "Asian") %>%
  str_replace_all("3", "Black/African American") %>%
  str_replace_all("4", "Native Hawaiian/Pacific Islander") %>%
  str_replace_all("5", "White") %>%
  str_replace_all("6", "Multiracial/Other")

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

# calculate proportions
mental_illness <- data %>%
  group_by(RACE, MH1) %>%
  summarise("total_w_illness" = length(RACE))

race_totals <- data %>%
  group_by(RACE) %>%
  summarise("total_race" = length(RACE))

race_illness_prop <- left_join(mental_illness, race_totals, by = "RACE") %>%
  mutate("prop" = total_w_illness/total_race)

# create bar graph
bar_graph <- ggplot(data = race_illness_prop) +
  geom_col(mapping = aes(x = RACE, y = prop, fill = MH1),
           position = "fill") +
  labs(title = "Proportion of Mental Illness Type in Each Race",
       x = "Race",
       y = "Total",
       color = "Mental Illness")
print(bar_graph)

