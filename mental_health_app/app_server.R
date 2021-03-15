# Loading Data

facilities <- read.csv("data/nmhss-puf-2018-csv.csv")
source("data/facility.R")
source("data/clean_mhcld.R")

# Server
server <- function(input, output) {

  # Introduction Variables ----------------------------------------------------

  output$facility_num <- renderText({
    facilities %>%
      distinct() %>%
      nrow()
  })

  output$common_illness <- renderText({
    mhcld %>%
      dplyr::filter(MH1 != "NA") %>%
      dplyr::group_by(MH1) %>%
      dplyr::summarise("freq" = length(MH1)) %>%
      dplyr::filter(freq == max(freq)) %>%
      dplyr::pull(MH1)
  })

  output$common_percent <- renderText({
    mhcld %>%
      dplyr::filter(MH1 != "NA") %>%
      dplyr::group_by(MH1) %>%
      dplyr::summarise("percent" = (length(MH1) / nrow(mhcld)) * 100) %>%
      dplyr::filter(percent == max(percent)) %>%
      dplyr::pull(percent) %>%
      round(digits = 2) %>%
      paste0("%")
  })


  # First Visual (Map) -------------------------------------------------------

  facilities_input <- reactive({
    if (input$facilities == "Total Mental Health Facilities") {
      dataset <- final_total
    }
    if (input$facilities == "Psychiatric Hospitals") {
      dataset <- final_psych
    }
    if (input$facilities == "Separate Inpatient Psychiatric Units of a
            General Hospital") {
      dataset <- final_separate
    }
    if (input$facilities == "Residential Treatment Centers for Children") {
      dataset <- final_res_child
    }
    if (input$facilities == "Residential Treatment Centers for Adults") {
      dataset <- final_res_adult
    }
    if (input$facilities == "Other Types of Residential Facilities") {
      dataset <- final_other_res
    }
    if (input$facilities == "Veterans Administration Medical Centers") {
      dataset <- final_vet
    }
    if (input$facilities == "Community Mental Health Centers") {
      dataset <- final_com
    }
    if (input$facilities == "Partial Hospitalization/Day Treatment
            Facilities") {
      dataset <- final_partial
    }
    if (input$facilities == "Outpatient Mental Health Facilities") {
      dataset <- final_outpatient
    }
    if (input$facilities == "Multi-setting Mental Health Facilities") {
      dataset <- final_multi
    }
    else if (input$facilities == "Other") {
      dataset <- final_other
    }
    return(dataset)
  })

  output$facility_map <- renderPlotly({
    {
      facilities_input() %>%
        full_join(state_map, by = "LST") %>%
        dplyr::select(CASEID, long, lat, group, order, LST, number) %>%
        distinct(order, .keep_all = TRUE) %>%
        ggplot(
          mapping = aes(
            x = long, y = lat, group = group,
            LST = LST, fill = number,
            text = paste(
              "State:", LST,
              "<br>Number of Facilities:",
              number
            )
          ),
          color = "gray", size = 0.3
        ) +
        geom_polygon() +
        coord_map() +
        scale_fill_continuous(
          limits = c(
            0,
            max(facilities_input()$number)
          ),
          na.value = "white", low = "#56B4E9",
          high = "#D55E00"
        ) +
        labs(title = str_wrap(paste(
          "Number of", input$facilities,
          "in Each State, 2018"
        ), 60)) +
        labs(fill = "Number of Facilities") +
        blank_theme
    } %>%
      ggplotly(tooltip = "text")
  })

  output$facility_graph <- renderPlotly({
    level_order <- c("CHILDAD", "ADOLES", "YOUNGADULTS", "ADULT", "SENIORS")
    {
      facilities_input() %>%
        left_join(age_data, by = "CASEID") %>%
        dplyr::filter(LST.x == input$state) %>%
        dplyr::select(
          CASEID, CHILDAD, ADOLES, YOUNGADULTS, ADULT, SENIORS,
          LST.x
        ) %>%
        na.omit() %>%
        distinct(CASEID, .keep_all = TRUE) %>%
        dplyr::select(CHILDAD, ADOLES, YOUNGADULTS, ADULT, SENIORS) %>%
        summarise_each(funs = sum) %>%
        gather() %>%
        ggplot(aes(
          x = factor(key, level = level_order), y = value,
          fill = key,
          text = paste("Number of Facilities:", value)
        )) +
        geom_col() +
        scale_fill_manual(values = colorscheme, name = "Age Group") +
        scale_x_discrete(labels = c("0-12", "13-17", "18-25", "26-64",
          "65+",
          labels = c(
            "0-12", "13-17",
            "18-25", "26-64",
            "65+"
          )
        )) +
        labs(title = str_wrap(paste(
          "Number of", input$facilities,
          "in", input$state, ", 2018"
        ), 60)) +
        xlab("Ages Accepted") +
        ylab("Number of Facilities")
    } %>%
      ggplotly(tooltip = "text")
  })

  # Second Visual (Treemap) ----------------------------------------------------

  output$treemap <- renderPlotly({
    filtered <- mhcld %>%
      dplyr::filter(if (input$sex == "all") {
        GENDER %in% c("Male", "Female", "Unknown")
      } else {
        GENDER == input$sex
      }) %>%
      dplyr::filter(if (input$age == "all") {
        AGE %in% c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, -9)
      } else {
        AGE == input$age
      }) %>%
     dplyr::filter(if (input$education == "all") {
        EDUC %in% c(1, 2, 3, 4, 5, -9)
      } else {
        EDUC == input$education
      }) %>%
      dplyr::filter(if (input$race == "all") {
        RACE %in% c(
          "American Indian/Alaska Native", "Asian",
          "Black/African American",
          "Native Hawaiian/Pacific Islander", "White",
          "Multiracial/Other", -9
        )
      } else {
        RACE == input$race
      }) %>%
      dplyr::filter(if (input$ethnicity == "all") {
        ETHNIC %in% c(1, 2, 3, 4, -9)
      } else {
        ETHNIC == input$ethnicity
      }) %>%
      dplyr::group_by(MH1) %>%
      tally()

    palette_okabeito_black <- c(
      "#E69F00", "#56B4E9", "#009E73", "#F0E442",
      "#0072B2", "#D55E00", "#CC79A7", "#000000"
    )

    treemap <- plot_ly(
      filtered,
      labels = ~MH1,
      parents = NA,
      values = ~n,
      type = "treemap",
      hovertemplate = "Mental Illness: %{label}<br>Contribution: 
      %{percentRoot:%}<extra></extra>",
      marker = list(colors = palette_okabeito_black)
    )

    treemap <- treemap %>%
      layout(title = "Visualizing Mental Illnesses for Different Demographics")

    treemap
  })


  # Conclusion Plot -----------------------------------------------------------

  output$bar <- renderPlotly({
    p_data <- mhcld %>%
      dplyr::filter(GENDER != "Unknown") %>%
      dplyr::select(AGE, GENDER, RACE, MH1) %>%
      dplyr::group_by(AGE, GENDER, RACE) %>%
      # n = the numbers of people who have specific mental illnesses
      count(MH1) %>%
      # prop = the proportion rate of people with specific mental illnesses in
      # age and race groups
      dplyr::mutate(PROP = round((n / sum(n) * 100), digits = 2)) %>%
      dplyr::filter(PROP == max(PROP)) %>%
      arrange()

    categories <- cut(p_data$AGE,
      breaks = c(0, 2, 5, 13, Inf),
      labels = c("Children", "Youth", "Adult", "Senior")
    )

    p_data <- data.frame(p_data, categories)

    q <- ggplot(p_data, aes(fill = MH1, y = PROP, x = RACE, color = GENDER)) +
      geom_bar(position = "dodge", stat = "identity") +
      theme_minimal() +
      facet_wrap(~categories) +
      scale_y_continuous(breaks = seq(0, 60, 10)) +
      scale_fill_OkabeIto() +
      labs(
        fill = "Mental Illnesses",
        color = "",
        y = "Proporation Rate of People with Specific Mental Illnesses",
        title = "What age and race groups are most affected by specific mental illness?"
      ) +
      theme(
        axis.title.y = element_blank(),
        axis.title.x = element_text(size = 10, vjust = 1),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()
      ) +
      coord_flip()

    ggplotly(q)
  })
}
