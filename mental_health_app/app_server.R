# Server 
library(tidyverse)
library(plotly)

data_one <- read.csv("data/small_MHCLD.csv")
data_two <- read.csv("data/nmhss-puf-2018-csv.csv")  

# Clean Data --------------------------------------------------------------
data_one$GENDER <- data_one$GENDER %>% 
  str_replace_all("1", "Male") %>% 
  str_replace_all("2", "Female") %>% 
  str_replace_all("-9", "Unknown") 

data_one$RACE <- data_one$RACE %>%
  str_replace_all("1", "American Indian/Alaska Native") %>%
  str_replace_all("2", "Asian") %>%
  str_replace_all("3", "Black/African American") %>%
  str_replace_all("4", "Native Hawaiian/Pacific Islander") %>%
  str_replace_all("5", "White") %>%
  str_replace_all("6", "Multiracial/Other")

facility_data <- data_one %>% 
  select(AGE, EDUC, RACE, ETHNIC, GENDER, MH1)


# Set up plots,  graphs, etc.  --------------------------------------------

server <- function(input, output) {



# Conclusion Plot ---------------------------------------------------------

output$bar <- renderPlotly({
  p_data <- facility_data %>%
    filter(GENDER != "Unknown") %>% 
    select(AGE, GENDER, RACE, MH1) %>% 
    group_by(AGE, GENDER, RACE) %>% 
    mutate(MH1 = recode(MH1,
                        "1" = "Trauma-Related Disorders",
                        "2" = "Anxiety Disorders",
                        "3" = "ADD/ADHD",
                        "4" = "Conduct Disorder",
                        "5" = "Delirium/Dementia",
                        "6" = "Bipolar Disorder",
                        "7" = "Depressive Disorders",
                        "8" = "Oppositional Defiant Disorder",
                        "9" = "Pervasive Developmental Disorder",
                        "10" = "Personality Disorders",
                        "11" = "Schizophrenia",
                        "12" = "Substance Abuse", 
                        "13" = "Other")) %>% 
    # n = the numbers of people who have specific mental illnesses
    count(MH1) %>% 
    # prop = the proportion rate of people with specific mental illnesses in 
    # age and race groups 
    mutate(PROP = round((n / sum(n) * 100), digits = 2)) %>% 
    filter(PROP == max(PROP)) %>% 
    arrange()
  
  categories <- cut(p_data$AGE, breaks = c(0, 2, 5, 13, Inf), 
        labels = c("Children", "Youth", "Adult", "Senior")) 
  
  p_data <- data.frame(p_data, categories)
  
  q <- ggplot(p_data, aes(fill = MH1, y = PROP, x = RACE, color = GENDER)) + 
    geom_bar(position="dodge", stat="identity") +
    theme_minimal() + 
    facet_wrap(~categories) + 
    scale_y_continuous(breaks = seq(0, 60, 10)) + 
    scale_fill_viridis(discrete = TRUE) + 
    labs(fill = "Mental Illnesses", 
         color = "", 
         y = "Proporation Rate of People with Specific Mental Illnesses", 
         title = "What age and race groups are most affected by specific mental illness?") +
    theme(axis.title.y = element_blank(), 
          axis.title.x = element_text(size = 10, vjust = 1), 
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) + 
    coord_flip()
  
  ggplotly(q)
  
})  
}
