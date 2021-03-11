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
  output$treemap <- renderPlotly({
    
    filtered <- clean_data %>%
      filter(if(input$sex == "all"){
        GENDER %in% c(1, 2, -9)} else {
          GENDER == input$sex}) %>%
      filter(if(input$age == "all"){
        AGE %in% c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, -9)} else {
          AGE == input$age}) %>%
      filter(if(input$education == "all"){
        EDUC %in% c(1, 2, 3, 4, 5, -9)} else {
          EDUC == input$education}) %>%
      filter(if(input$race == "all"){
        RACE %in% c(1, 2, 3, 4, 5, 6, -9)} else {
          RACE == input$race}) %>%
      filter(if(input$ethnicity == "all"){
        ETHNIC %in% c(1, 2, 3, 4, -9)} else {
         ETHNIC == input$ethnicity}) %>%
      group_by(MH1) %>%
      tally()
    
    palette_OkabeIto_black <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")
    
    treemap <- plot_ly(
      filtered,
      labels = ~ MH1,
      parents = NA,
      values = ~ n,
      type = 'treemap',
      hovertemplate = "Mental Illness: %{label}<br>Count: %{value}<extra></extra>",
      marker=list(colors = palette_OkabeIto_black)
    )
    
    treemap <- treemap %>% 
      layout(title = "Visualizing Mental Illness for Different Demographics")
    
    treemap
  })
}






