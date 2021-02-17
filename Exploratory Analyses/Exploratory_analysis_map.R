library(tidyverse)
library("dplyr")
library("ggplot2") 
library("maps")
library("mapproj")
# create color scheme
color_scheme <- colors()[c("navy","royalblue4", "steelblue4", "slateblue4", "slateblue1",
                           "mediumpurple", "mediumseagreen", "mediumaquamarine", "turquoise",
                           "paleturquoise2", "palegreen", "darkseagreen1", "powderblue")]

#load data
mental_health_facilities <- read.csv("nmhss-puf-2018-csv.csv")

#load state map data
state_shapes <- map_data("state") %>%
  mutate(name = toupper(region))
abbreviations <- data.frame(name = state.name, abb= state.abb) %>%
  mutate(name = toupper(name))
state_map <- left_join(state_shapes, abbreviations, by = "name") %>%
  mutate(LST = abb)

#filter facility data
facility_data <- select(mental_health_facilities, MHINTAKE, LST, FACILITYTYPE)

#facilities with mental health intake
mh_intake <- facility_data %>%
  filter(MHINTAKE == 1)

#aggregate mh intake
agg_mh_intake <- aggregate(mh_intake['MHINTAKE'], by=mh_intake['LST'], sum)

#join state and mh intake data
state_mh_intake <- left_join(state_map, agg_mh_intake, by = "LST")

#make map
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
  )
#make actual map
mh_intake_map <- ggplot(state_mh_intake) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = MHINTAKE),
    color = "gray", size = 0.3
  ) +
  coord_map() +
  scale_fill_continuous(limits = c(0, max(state_mh_intake$MHINTAKE)), 
                        na.value = "white", low = "slateblue4", high = "turquoise") +
  labs(title = "Number of Mental Health Facilities in Each State, 2018") +
  labs(fill = "Number of Facilities") +
  blank_theme
