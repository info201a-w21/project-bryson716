library(treemap)
library(tidyverse)
library(treemapify)
library(shiny)
library(plotly)

side_treemap <- sidebarPanel(
  selectInput(
    inputId = "sex",
    label = "Select A Sex",
    choices = list(
      "Female" = 2,
      "Male" = 1
    )
  ),
  selectInput(
    inputId = "race",
    label = "Select A Race",
    choices = list(
      "American Indian/Alaskan Native" = 1,
      "Asian" = 2,
      "Black/African American" = 3,
      "Native Hawaiian/Pacific Islander" = 4,
      "White" = 5,
      "Multiracial/Other" = 6
    )
  ),
  selectInput(
    inputId = "ethnicity",
    label = "Select An Ethnicity",
    choices = list(
      "Mexican" = 1,
      "Puerto Rican" = 2,
      "Other Hispanic or Latino Origin" = 3,
      "Not of Hispanic or Latino Origin" = 4
    )
  ),
  selectInput(
    inputId = "age",
    label = "Select An Age Range",
    choices = list(
      "0–11 Years " = 1,
      "12–14 Years" = 2,
      "15–17 Years" = 3,
      "18–20 Years" = 4,
      "21–24 Years" = 5,
      "25–29 Years" = 6,
      "30–34 Years" = 7,
      "35–39 Years" = 8,
      "40–44 Years" = 9,
      "45–49 Years" = 10,
      "50–54 Years" = 11,
      "55–59 Years" = 12,
      "60–64 Years" = 13,
      "65 Years and Older" = 14
    )
  ),
  selectInput(
    inputId = "education",
    label = "Select An Education Level",
    choices = list(
      "Special Education" = 1,
      "Grades 0-8" = 2,
      "Grades 9-11" = 3,
      "Grade 12/GED" = 4,
      "More Than High School Degree/GED" = 5
    )
  )
)

main_treemap <- mainPanel(
  plotOutput("treemap")
)

ui <- fluidPage(
  "mental health",
  side_treemap,
  main_treemap
)







