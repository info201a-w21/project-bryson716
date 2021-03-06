library(shiny)
library(tidyverse)

facility_data <- read.csv("data/nmhss-puf-2018-csv.csv")
illness_data <- read.csv("data/Small_MHCLD.csv")
illness_data$MH1 <- illness_data$MH1 %>%
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

intro <- tabPanel(
  "Introduction",
  titlePanel("The National Impact of Mental Illness"),
  p("Mental illnesses are extremely prevalent in America, impacting about 20% of the general population", a("(NIMH, 2021).", href = "https://www.nimh.nih.gov/health/statistics/mental-illness.shtml"),
    "Because of inequities in the nation, whether that be due to race, gender, or class, mental illnesses are more pervasive
    among certain groups of people. In this website, we sought to investigate how mental illness is distributed across America,
    as well as what treatment access looked like. Our key questions for this project were:",
    HTML("<ol><li>What is access to mental illness treatment like in America?</li>
    <li>How prevalent are different mental illnesses depending on an individual's identity?</li>")),
  p("Using interactive data visualizations, users are able to view where different types of treatment are available on a
    national level. They can also examine different patterns within specific identities for the prevalence of 
    13 mental illnesses. We tried to promote accessibility of information throughout our project so more people would be able
    to interact with our work. By doing so, we hope to increase the visibility of mental health issues in America."),
  img("", alt = "Three signs on a fence that say 'Don't give up,' 'You are not alone,' and 'You matter.'",
      src = "https://images.unsplash.com/photo-1564121211835-e88c852648ab?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
  p(em("Picture taken by Dan Meyers in Salem, Oregon, United States")),
  h3("Background Information"),
  p("As of 2018, there are approximately", textOutput("facility_num", inline = T), "mental health facilities in America. The services at these facilities
    can include mental health referrals, substance abuse treatment, inpatient or residential treatment, partial hospitalization, different forms of therapy, and medication perscriptions.
    The most common mental illness treated at a state-run mental health facility was", textOutput("common_illness", inline = T),
    ", making up", textOutput("common_percent", inline = T), "of the sample. Other mental illnesses that were focused on included anxiety disorders, trauma-related disorders,
    schizophrenia, personality disorders, oppositional deviant disorder, conduct disorder, substance abuse disorders, ADD/ADHD, bipolar disorder, delirium, and
    pervasive developmental disorder."),
  h3("Recognition of Data Sets"),
  p("For this project, we utilized two 2018 data sets from the", a("Substance Abuse and Mental Health Data Archive.", href = "https://www.datafiles.samhsa.gov/"),
    "The first was the", a("Mental Health Client-Level Data Set,", href = "https://www.datafiles.samhsa.gov/study/mental-health-client-level-data-2018-mh-cld-2018-nid19097"),
    "a collection of all clients who received state-run mental health services. It contains information on individuals' mental illness diagnoses and demographics. The data
    was collected independently by each state. The second data set used was from the", a("National Mental Health Services Survey.", href = "https://www.datafiles.samhsa.gov/study/national-mental-health-services-survey-2018-n-mhss-2018-nid18766"),
    "It contains all known information about mental health treatment facilities in America. This was an optional survey, so data
    there is potentially missing data from some facilities.")
)

treatment <- tabPanel(
  "Treatment",
  titlePanel("Mental Health Facilities in America")
)

illness <- tabPanel(
  "Mental Illnesses",
  titlePanel("Something great")
)

conclusion <- tabPanel(
  "Conclusion",
  titlePanel("Project Takeaways")
)

ui <- navbarPage(
  title = "Mental Illness in America",
  intro,
  treatment,
  illness,
  conclusion
)

server <- function(input, output){
  
    output$facility_num <- renderText({
      facility_data %>%
        distinct() %>%
        nrow()
    })
    
    output$common_illness <- renderText({
      illness_data %>%
        filter(MH1 != "NA") %>%
        group_by(MH1) %>%
        summarise("freq" = length(MH1)) %>%
        filter(freq == max(freq)) %>%
        pull(MH1)
    })
    
    output$common_percent <- renderText({
      illness_data %>%
        filter(MH1 != "NA") %>%
        group_by(MH1) %>%
        summarise("percent" = (length(MH1)/nrow(illness_data))*100) %>%
        filter(percent == max(percent)) %>%
        pull(percent) %>%
        round(digits = 2) %>%
        paste0("%")
    })

}

shinyApp(ui = ui, server = server)




