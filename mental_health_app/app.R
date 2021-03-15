# INFO 201 Final Project
# Team Members: Morgan, Caroline, Nina, and Adrian 

# Load library packages 
library(shiny)
library(shinythemes)
library(tidyverse)
library(plotly)
library(colorspace)
library(colorblindr)
library(countrycode)
library(rsconnect)
library(maps)
library(mapproj)
# Source the app_ui and app_server 
source("app_ui.R")
source("app_server.R")

# Use ShinyApp() to display our project on Shiny 
shinyApp(ui = ui, server = server)