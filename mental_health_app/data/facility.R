library(shiny)
library(tidyverse)
library(plotly)
library(countrycode)
library(maps)
library(dplyr)
mental_health <- read.csv("data/nmhss-puf-2018-csv.csv")
state_populations <- read.csv("data/state.csv")
colorscheme <- c("#E69F00", "#56B4E9", "#009E73", 
                 "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
mental_health_facilities <- full_join(mental_health, state_populations,
  by = "LST"
)
state_shapes <- map_data("state") %>%
  dplyr::mutate(name = toupper(region))
abbreviations <- data.frame(name = state.name, abb = state.abb) %>%
  dplyr::mutate(name = toupper(name))
state_map <- left_join(state_shapes, abbreviations, by = "name") %>%
  dplyr::mutate(LST = abb)
psych <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 1)
agg_psych <- aggregate(psych["FACILITYTYPE"], by = psych["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE)
final_psych <- left_join(psych, agg_psych, by = "LST")
total <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, MHINTAKE) %>%
  dplyr::filter(MHINTAKE == 1)
agg_total <- aggregate(total["MHINTAKE"], by = total["LST"], sum) %>%
  dplyr::mutate(number = MHINTAKE)
final_total <- left_join(total, agg_total, by = "LST")
separate <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 2)
agg_separate <- aggregate(separate["FACILITYTYPE"], by = separate["LST"],
                          sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 2)
final_separate <- left_join(separate, agg_separate, by = "LST")
res_child <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 3)
agg_res_child <- aggregate(res_child["FACILITYTYPE"], by = res_child["LST"],
                           sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 3)
final_res_child <- left_join(res_child, agg_res_child, by = "LST")
res_adult <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 4)
agg_res_adult <- aggregate(res_adult["FACILITYTYPE"], by = res_adult["LST"],
                           sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 4)
final_res_adult <- left_join(res_adult, agg_res_adult, by = "LST")
other_res <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 5)
agg_other_res <- aggregate(other_res["FACILITYTYPE"],
  by = other_res["LST"],
  sum
) %>%
  dplyr::mutate(number = FACILITYTYPE / 5)
final_other_res <- left_join(other_res, agg_other_res, by = "LST")
vet <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 6)
agg_vet <- aggregate(vet["FACILITYTYPE"], by = vet["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 6)
final_vet <- left_join(vet, agg_vet, by = "LST")
com <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 7)
agg_com <- aggregate(com["FACILITYTYPE"], by = com["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 7)
final_com <- left_join(com, agg_com, by = "LST")
partial <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 8)
agg_partial <- aggregate(partial["FACILITYTYPE"], by = partial["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 8)
final_partial <- left_join(partial, agg_partial, by = "LST")
outpatient <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 9)
agg_outpatient <- aggregate(outpatient["FACILITYTYPE"],
  by = outpatient["LST"],
  sum
) %>%
  dplyr::mutate(number = FACILITYTYPE / 9)
final_outpatient <- left_join(outpatient, agg_outpatient, by = "LST")
multi <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 10)
agg_multi <- aggregate(multi["FACILITYTYPE"], by = multi["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 10)
final_multi <- left_join(multi, agg_multi, by = "LST")
other <- mental_health_facilities %>%
  dplyr::select(CASEID, LST, FACILITYTYPE) %>%
  dplyr::filter(FACILITYTYPE == 11)
agg_other <- aggregate(other["FACILITYTYPE"], by = other["LST"], sum) %>%
  dplyr::mutate(number = FACILITYTYPE / 11)
final_other <- left_join(other, agg_other, by = "LST")
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
  )
age_data <- mental_health %>%
  dplyr::select(CASEID, LST, CHILDAD, ADOLES, YOUNGADULTS, ADULT, SENIORS)
