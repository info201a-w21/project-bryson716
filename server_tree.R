library(treemap)
library(tidyverse)
library(treemapify)
library(shiny)
library(plotly)

data <- read.csv("data/small_MHCLD.csv")

#Clean data
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

clean_data <- data %>% 
  select(AGE, EDUC, RACE, ETHNIC, GENDER, MH1)

#Server

server <- function(input, output){
  output$treemap <- renderPlot({
    
    filtered <- clean_data %>%
      filter(GENDER == input$sex) %>%
      filter(AGE == input$age) %>%
      filter(EDUC == input$education) %>%
      filter(RACE == input$race) %>%
      filter(ETHNIC == input$ethnicity) %>%
      group_by(MH1) %>%
      tally()
    
    treemap <- ggplot(filtered, aes(area = n, fill = MH1)) +
      geom_treemap()
    
    treemap
  })
}







