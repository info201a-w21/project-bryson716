# INFO 201 Final Project
# Team Members: Morgan, Caroline, Nina, and Adrian 

# Load library packages 
library(shiny)
library(shinythemes)
library(tidyverse)
library(plotly)
library(colorspace)
library(colorblindr)

# Source the app_server and app_ui 
source("app_server.R")
source("app_ui.R")

# Use ShinyApp() to display our project on Shiny 
shinyApp(ui = ui, server = server)