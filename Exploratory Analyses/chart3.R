library(tidyverse)
library(stringr)
data <- read.csv("small_MHCLD.csv")
data <- select(data, ETHNIC, RACE, TRAUSTREFLG, ANXIETYFLG, CONDUCTFLG,
               DEPRESSFLG, ALCSUBFLG)
data$TRAUSTREFLG <- str_replace_all(data$TRAUSTREFLG, "1", "trauma")
data$ANXIETYFLG <- str_replace_all(data$ANXIETYFLG, "1", "anxiety")
data$CONDUCTFLG <- str_replace_all(data$CONDUCTFLG, "1", "conduct")
data$DEPRESSFLG <- str_replace_all(data$DEPRESSFLG, "1", "depression")
data$ALCSUBFLG <- str_replace_all(data$ALCSUBFLG, "1", "alcohol/substance")
data <- data %>%
  mutate("mental_illness" = paste(data$TRAUSTREFLG, data$ANXIETYFLG, data$CONDUCTFLG,
                                        data$DEPRESSFLG, data$ALCSUBFLG))
data$mental_illness <- data$mental_illness %>%
  str_remove_all(" 0") %>%
  str_remove_all("0 ") %>%
  str_remove_all("0")
data <- filter(data, data$mental_illness != "")
data <- data %>% 
  mutate(mental_illness = strsplit(mental_illness, " ")) %>% 
  unnest(mental_illness)
data$RACE <- data$RACE %>%
  str_replace_all("1", "american indian") %>%
  str_replace_all("2", "asian") %>%
  str_replace_all("3", "african american") %>%
  str_replace_all("4", "pacific islander") %>%
  str_replace_all("5", "white") %>%
  str_replace_all("6", "other/multiracial")
data$ETHNIC <- data$ETHNIC %>%
  str_replace_all("1", "mexican") %>%
  str_replace_all("2", "puerto rican") %>%
  str_replace_all("3", "hispanic/latino") %>%
  str_replace_all("4", "not hispanic/latino")

value <- abs(rnorm(2060466))
bar_graph <- ggplot(data = data) +
  geom_col(mapping = aes(x = RACE, y = value, fill = mental_illness), position = "fill")
print(bar_graph)

?midwest
View(midwest)
