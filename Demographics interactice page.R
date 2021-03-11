library(treemap)
library(tidyverse)
library(treemapify)
library(plotly)

# Read in data
all_data <- read.csv("data/small_MHCLD.csv")

# Color-blind friendly scale
palette_OkabeIto_black <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")


# Getting the columns I need
clean <- all_data %>% 
  select(AGE, EDUC, RACE, GENDER, MH1)

# Testing on age variable
clean_age <- clean %>% 
  select(AGE, MH1) %>% 
  summarise(
    "0-11 years old" = sum(AGE == 1),
    "12-14 years old" = sum (AGE == 2),
    "15-17 years old" = sum (AGE == 3),
    "18-20 years old" = sum (AGE == 4),
    "21-24 years old" = sum (AGE == 5),
    "25-29 years old" = sum (AGE == 6),
    "30-34 years old" = sum (AGE == 7),
    "35-39 years old" = sum (AGE == 8),
    "40-44 years old" = sum (AGE == 9),
    "45-49 years old" = sum (AGE == 10),
    "50-54 years old" = sum (AGE == 11),
    "55-59 years old" = sum (AGE == 12),
    "60-64 years old" = sum (AGE == 13),
    "65+ years old" = sum (AGE == 14),
  )

# Flipping dataset for treemap
m1 <- t(clean_age)
clean_age_for_treemap <- data.frame(age = row.names(m1),
                                    m1, row.names=NULL)  %>% 
                        rename("value" = "m1")


treemap( clean_age_for_treemap,
  index = "age",
  vSize = "value",
  type = "index"
)
###########Color Palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
####

# Tree Map Data for 2 variables
target <- c("AGE", "GENDER", "MH1")

var <- clean %>% 
  select(AGE, GENDER, MH1) %>% 
  filter(GENDER > 0) %>% 
  filter(AGE == 6) %>% 
  filter(GENDER == 1) %>% 
  group_by(MH1) %>%
  tally()

ggplot(var, aes(area = n, fill = MH1, label = MH1)) +
  geom_treemap()+
  geom_treemap_text(fontface = "italic", colour = "White", 
                    place = "topleft", reflow = T,
                    padding.x = unit(1, "mm"),
                    padding.y = unit(2, "mm")
                    ) +
  labs(title = "Number of people with a certain mental illness"
       )

# How to incorporate Plotly below (Var is my dataframe name and the rest should be easy to figure out!)
  plot_ly(
  var,
  labels = ~ MH1,
  parents = NA,
  values = ~ n,
  type = 'treemap',
  hovertemplate = "Mental Illness: %{label}<br>Count: %{value}<extra></extra>",
  marker=list(colors = palette_OkabeIto_black)
)
