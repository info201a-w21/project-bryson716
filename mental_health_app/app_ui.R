# User Interface 


# Introduction Page -------------------------------------------------------

intro <- tabPanel("Introduction", 
                  )


# Interactive Page 1 ------------------------------------------------------

viz_one <- tabPanel("Mental Health Facilities in America"
                    
                    )


# Interactive Page 2 ------------------------------------------------------

viz_two <- tabPanel("(Insert a title)"
                    )


# Conclusion Page --------------------------------------------------------------

concl <- tabPanel("Conclusion", 
                  titlePanel("Project Takeaways"), 
                             style = "text-align: center;",
                  p("Before this study, we sought to investigate 
                    how mental illness is distributed in the U.S. 
                    based on different demographic characteristics.  
                    The results of our investigation show that 
                    the most affected racial group in both genders 
                    and age groups is", strong("American Indian/Alaska Native"), 
                    ", which is not too surprising, but this new understanding 
                    should help address those issues regarding the 
                    margarlinzed groups facing oppression."),
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
                  plotlyOutput("bar"))

ui <- navbarPage(theme = shinytheme("united"),
                 "Mental Health in the U.S.", 
                 intro, 
                 viz_one,
                 viz_two, 
                 concl
  ) 
