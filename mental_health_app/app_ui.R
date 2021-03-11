# User Interface 


# Introduction Page -------------------------------------------------------

intro <- tabPanel("Introduction", 
                  )


# Interactive Page 1 ------------------------------------------------------

viz_one <- tabPanel("(Insert a title)"
                    
                    )




# Interactive Page 2 ------------------------------------------------------

viz_two <- tabPanel("(Insert a title)"
                    )



# Conclusion Page --------------------------------------------------------------

concl <- tabPanel("Conclusion"
                  )


ui <- navbarPage(theme = shinytheme("united"),
                 "Mental Health in the U.S.", 
                 intro, 
                 viz_one,
                 viz_two, 
                 concl
  ) 
