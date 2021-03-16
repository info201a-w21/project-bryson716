# User Interface

# Introduction Page -------------------------------------------------------

intro <- tabPanel(
  "Introduction",
  titlePanel("The National Impact of Mental Illness"),
  p(
    "Mental illnesses are extremely prevalent in America, impacting about 20% 
    of the general population", a("(NIMH, 2021).",
      href = "https://www.nimh.nih.gov/health/statistics/mental-illness.shtml"
    ),
    "Because of inequities in the nation, whether that be due to race, gender, 
    or class, mental illnesses are more pervasive among certain groups of 
    people. In this website, we sought to investigate how mental illness is 
    distributed across America, as well as what treatment access looked like. 
    Our key questions for this project were:",
    HTML("<ol><li>What is access to mental illness treatment like in America?</li>
         <li>How prevalent are different mental illnesses depending on 
         an individual's identity?</li>")
  ),
  p("Using interactive data visualizations, users are able to view where 
  different types of treatment are available on a national level. They can 
  also examine different patterns within specific identities for the prevalence 
  of 13 mental illnesses. We tried to promote accessibility of information 
  throughout our project so more people would be able to interact with our 
  work. By doing so, we hope to increase the visibility of mental health 
  issues in America."), img("",
    alt = "Three signs on a fence that say 'Don't give up,' 
    'You are not alone,' and 'You matter.'",
    src = "https://images.unsplash.com/photo-1564121211835-e88c852648ab?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
  ),
  p(em("Picture taken by Dan Meyers in Salem, Oregon, United States")),
  h3("Background Information"),
  p(
    "As of 2018, there are approximately", textOutput("facility_num", inline = T),
    "mental health facilities in America. The services at these facilities
    can include mental health referrals, substance abuse treatment, inpatient 
    or residential treatment, partial hospitalization, different forms of 
    therapy, and medication perscriptions.The most common mental illness 
    treated at a state-run mental health facility was",
    textOutput("common_illness", inline = T), ", making up",
    textOutput("common_percent", inline = T), "of the sample. Other mental 
    illnesses that were focused on included anxiety disorders, trauma-related 
    disorders,schizophrenia, personality disorders, oppositional deviant 
    disorder, conduct disorder, substance abuse disorders, ADD/ADHD, bipolar 
    disorder, delirium, and pervasive developmental disorder."
  ),
  h3("Recognition of Data Sets"),
  p(
    "For this project, we utilized two 2018 data sets from the",
    a("Substance Abuse and Mental Health Data Archive.",
      href = "https://www.datafiles.samhsa.gov/"
    ),
    "The first was the", a("Mental Health Client-Level Data Set,",
      href = "https://www.datafiles.samhsa.gov/study/mental-health-client-level-data-2018-mh-cld-2018-nid19097"
    ),
    "a collection of all clients who received state-run mental health services. 
    It contains information on individuals' mental illness diagnoses 
    and demographics. The data was collected independently by each state. 
    The second data set used was from the",
    a("National Mental Health Services Survey.",
      href = "https://www.datafiles.samhsa.gov/study/national-mental-health-services-survey-2018-n-mhss-2018-nid18766"
    ),
    "It contains all known information about mental health treatment 
    facilities in America. This was an optional survey, so data
    there is potentially missing data from some facilities."
  )
)


# Interactive Page 1 ------------------------------------------------------

side_map <- sidebarPanel(
  selectInput("facilities",
    label = h3("Type of Facility"),
    c(
      "Total" = "Total Mental Health Facilities",
      "Psychiatric Hospitals",
      "Residential Treatment Centers for Children",
      "Residential Treatment Centers for Adults",
      "Other Type of Residential Treatment Facility" =
        "Other Types of Residential Facilities",
      "Veterans Administration Medical Center (VAMC)" =
        "Veterans Administration Medical Centers",
      "Community Mental Health Center (CMHC)" =
        "Community Mental Health Centers",
      "Outpatient Mental Health Facilities",
      "Multi-setting Mental Health Facilities",
      "Other"
    )
  ),

  selectInput(
    inputId = "state",
    label = h3("Select a State"),
    c(
      "Alabama (AL)" = "AL", "Alaska (AK)" = "AK",
      "Arizona (AZ)" = "AZ", "Arkansas (AR)" = "AR",
      "California (CA)" = "CA", "Colorado (CO)" = "CO",
      "Connecticut (CT)" = "CT", "Delaware (DE)" = "DE",
      "Florida (FL)" = "FL", "Georgia (GA)" = "GA",
      "Hawaii (HI)" = "HI", "Idaho (ID)" = "ID",
      "Illinois (IL)" = "IL", "Indiana (IN)" = "IN",
      "Iowa (IA)" = "IA", "Kansas (KS)" = "KS",
      "Kentucky (KY)" = "KY", "Louisiana (LA)" = "LA",
      "Maine (ME)" = "ME", "Maryland (MD)" = "MD",
      "Massachusetts (MA)" = "MA", "Michigan (MI)" = "MI",
      "Minnesota (MN)" = "MN", "Mississippi (MS)" = "MS",
      "Missouri (MO)" = "MO", "Montana (MT)" = "MT",
      "Nebraska (NE)" = "NE", "Nevada (NV)" = "NV",
      "New Hampshire (NH)" = "NH", "New Jersey (NJ)" = "NJ",
      "New Mexico (NM)" = "NM", "New York (NY)" = "NY",
      "North Carolina (NC)" = "NC",
      "North Dakota (ND)" = "ND",
      "Ohio (OH)" = "OH", "Oklahoma (OK)" = "OK",
      "Oregon (OR)" = "OR", "Pennsylvania (PA)" = "PA",
      "Rhode Island (RI)" = "RI",
      "South Carolina (SC)" = "SC",
      "South Dakota (SD)" = "SD", "Tennessee (TN)" = "TN",
      "Texas (TX)" = "TX", "Utah (UT)" = "UT",
      "Vermont (VT)" = "VT", "Virginia (VA)" = "VA",
      "Washington (WA)" = "WA", "West Virginia (WV)" = "WV",
      "Wisconsin (WI)" = "WI", "Wyoming (WY)" = "WY"
    )
  )
)

main_map <- mainPanel(
  label = h3("Type of Facility"),
  c(
    "Total" = "Total Mental Health Facilities",
    "Psychiatric Hospitals",
    "Separate Inpatient Psychiatric Units of a General Hospital",
    "Residential Treatment Centers for Children",
    "Residential Treatment Centers for Adults",
    "Other Type of Residential Treatment Facility" =
      "Other Types of Residential Facilities",
    "Veterans Administration Medical Center (VAMC)" =
      "Veterans Administration Medical Centers",
    "Community Mental Health Center (CMHC)" =
      "Community Mental Health Centers",
    "Outpatient Mental Health Facilities",
    "Multi-setting Mental Health Facilities",
    "Other"
  ),
  selectInput(
    inputId = "state",
    label = h3("Select a State"),
    c(
      "Alabama (AL)" = "AL", "Alaska (AK)" = "AK",
      "Arizona (AZ)" = "AZ", "Arkansas (AR)" = "AR",
      "California (CA)" = "CA", "Colorado (CO)" = "CO",
      "Connecticut (CT)" = "CT", "Delaware (DE)" = "DE",
      "Florida (FL)" = "FL", "Georgia (GA)" = "GA",
      "Hawaii (HI)" = "HI", "Idaho (ID)" = "ID",
      "Illinois (IL)" = "IL", "Indiana (IN)" = "IN",
      "Iowa (IA)" = "IA", "Kansas (KS)" = "KS",
      "Kentucky (KY)" = "KY", "Louisiana (LA)" = "LA",
      "Maine (ME)" = "ME", "Maryland (MD)" = "MD",
      "Massachusetts (MA)" = "MA", "Michigan (MI)" = "MI",
      "Minnesota (MN)" = "MN", "Mississippi (MS)" = "MS",
      "Missouri (MO)" = "MO", "Montana (MT)" = "MT",
      "Nebraska (NE)" = "NE", "Nevada (NV)" = "NV",
      "New Hampshire (NH)" = "NH", "New Jersey (NJ)" = "NJ",
      "New Mexico (NM)" = "NM", "New York (NY)" = "NY",
      "North Carolina (NC)" = "NC",
      "North Dakota (ND)" = "ND",
      "Ohio (OH)" = "OH", "Oklahoma (OK)" = "OK",
      "Oregon (OR)" = "OR", "Pennsylvania (PA)" = "PA",
      "Rhode Island (RI)" = "RI",
      "South Carolina (SC)" = "SC",
      "South Dakota (SD)" = "SD", "Tennessee (TN)" = "TN",
      "Texas (TX)" = "TX", "Utah (UT)" = "UT",
      "Vermont (VT)" = "VT", "Virginia (VA)" = "VA",
      "Washington (WA)" = "WA", "West Virginia (WV)" = "WV",
      "Wisconsin (WI)" = "WI", "Wyoming (WY)" = "WY"
    )
  )
)

main_map <- mainPanel(
  plotlyOutput("facility_map"),
  plotOutput("facility_graph"),
  h2("More about the graphs"),
  p("We believe that the treatment of mental health is just as important as diagnoising
    it; however, mental health facilities are often sparse in
    many areas. The graphs above visually display information about 
    the number of different mental health facilities in each state."),
  h3("Map of the U.S."),
    p("The map of the U.S. gives viewers a holistic look
    at the number of facilities in each state. To the right of the map,
      there is a color scale indicating the number of mental health facilities correlating to the 
      color of each state. The input options on the left allow viewers
      to customize the type of facility the map will display. This
      allows viewers to quickly spot trends in the number of mental health facilities within 
      each state. Hovering over a state will provide the specific count of that type of facility within that state.", 
      em("*The state drop-down menu does not affect the map values; some states may
      appear white are due to insufficient data.")),
  h3("Charts about State Facilities"),
  p("The bottom chart allows viewers to see further information about mental health
    facilities in a specific state. By selecting a state and type of facility 
    from the drop-down menus on the left, the bar chart is automatically updated to show 
    how many facilities treat different age groups within a state. A viewer will be 
    able to see, for example, how many psychiatric hospitals in New York are dedicated
    to a certain age group like seniors or children.")
)

viz_one <- tabPanel(
  "Mental Health Facilities",
  icon = icon("globe-americas"),
  sidebarLayout(side_map, main_map)
)


# Interactive Page 2 ------------------------------------------------------

side_treemap <- sidebarPanel(
  selectInput(
    inputId = "sex",
    label = "Select A Sex",
    choices = list(
      "All" = "all",
      "Female",
      "Male"
    )
  ),
  selectInput(
    inputId = "race",
    label = "Select A Race",
    choices = list(
      "All" = "all",
      "American Indian/Alaska Native",
      "Asian",
      "Black/African American",
      "Native Hawaiian/Pacific Islander",
      "White",
      "Multiracial/Other"
    )
  ),
  selectInput(
    inputId = "ethnicity",
    label = "Select An Ethnicity",
    choices = list(
      "All" = "all",
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
      "All" = "all",
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
      "All" = "all",
      "Special Education" = 1,
      "Grades 0-8" = 2,
      "Grades 9-11" = 3,
      "Grade 12/GED" = 4,
      "More Than High School Degree/GED" = 5
    )
  )
)

main_treemap <- mainPanel(
  plotlyOutput("treemap"),
  h2("Visualizing Mental Health Demographics"),
  p("This interactive graph allows viewers to visualize how prevelant various mental
    illnesses are in the population of their choice. Hovering over a box with the 
    mouse will display the type of mental illness and what percentage of total mental 
    illness it makes up. By creating a treemap, viewers are able to distinguish
    patterns in mental health diagnoses and how certain races, sexes, or age groups
    are affected. One pattern that we found was how prevalent schizophrenia 
    seemed to be diagnosed among African American males. Upon further research this could be
    attributed to the redefining of what schizophrenia was in the 1960's, which then 
    correlated to a higher rate of male African-American protestors diagnosed 
    with the illness. This and many other intriguing patterns can be easily visualized,
    allowing viewers to see themselves and others in this highly customizable graph.")
)

viz_two <- tabPanel(
  "Mental Illness",
  icon = icon("th"),
  sidebarLayout(side_treemap, main_treemap)
)


# Conclusion Page --------------------------------------------------------------

concl <- tabPanel("Conclusion",
  titlePanel("Project Takeaways"),
  style = "text-align: center;",
  p(
    "Before this study, we sought to investigate 
                    how mental illness is distributed in the U.S. 
                    based on different demographic characteristics.  
                    The results of our investigation show that 
                    the most affected racial group in both genders 
                    and age groups is", strong("American Indian/Alaska Native"),
    ", which is not too surprising, but this new understanding 
                    should help address those issues regarding the 
                    margarlinzed groups facing oppression."
  ),
  p("We also found that depressive disorders are highly prevelant 
                    in older age groups compared to younger age groups. Due to
                    the stigma of mental health, society does not recognize
                    the struggles of older people struggling with their 
                    mental illnesses. Another important finding in this study is
                    that female children between the age of 0 and 14 are more likely 
                    to experience trauma-related disorders more than other age groups. 
                    In addition, Black and African American men who are older 
                    than 24 years old have the highest proporation rates in 
                    schizophrenia."),
  p("Unfortunately, our datasets did not show 
                  whether they received treatment and services for 
                  their mental illnesses. However, we learned a lot about those 
                  demographics in connection to gender, race, and age and 
                  challenged the research questions through discussion and 
                  crticial thinking. This information in the interactive chart 
                  shown below can be used to develop targetted interventions 
                  aimed at improving mental health care towards the marginalized groups."),
  plotlyOutput("bar")
)

ui <- navbarPage(
  fluid = FALSE,
  theme = shinytheme("united"),
  "Mental Health in the U.S.",
  intro,
  viz_one,
  viz_two,
  concl
)
