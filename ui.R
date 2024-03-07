library(sf)
library(tigris)
library(ggplot2)
library(plotly)
library(dplyr)
library(leaflet)
library(tigris)


suicide_df<- read.csv("2015 Suicide Rates By State.csv")
stateexp_df<- read.csv("StateExpenditures.csv")
combined_df<-read.csv("State Expenditures and Suicide Rates.csv")
combined_df <- combined_df %>%
  mutate(DEATHS = gsub(",", "", DEATHS), # Remove commas
         DEATHS = as.numeric(DEATHS))

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview",
                         h1("Mental Health Expenditures & Suicide Rates"),
                         p("WIP")
)



## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Suicide rates"),
  radioButtons(
    inputId = "viz1radio",
    label = h3("Choose an option."),
    choices = list("Suicide Rates by State" = "RATE", "Suicide Death Count" = "DEATHS")
  )
  #TODO: Put inputs for modifying graph here
)


viz_1_main_panel <- mainPanel(
  h2("Heatmap of Suicide Rates"),
  leafletOutput(outputId = "your_viz_1_output_id")
)

viz_1_tab <- tabPanel("Suicide Rates per State",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("State Mental Health Expenditure"),
  radioButtons(
    inputId ="viz2radio",
    label = h3("Choose an option."),
    choices = list("Per Capita Expenditure" = "PerCapitaMHExpend", "Total Expenditure" = "TotalMHExpend")
  )
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Heatmap of State Mental Health Expenditures"),
  leafletOutput(outputId = "your_viz_2_output_id"),
)

viz_2_tab <- tabPanel("MH Expenditure per State",
                      sidebarLayout(
                        viz_2_sidebar,
                        viz_2_main_panel
                      )
)


## VIZ 3 TAB INFO

viz_3_main_panel <- mainPanel(
  h2("Scatterplot of MH Expenditures and Suicide Rates"),
  plotlyOutput(outputId = "your_viz_3_output_id")
)

viz_3_tab <- tabPanel("Correlation",
                      (
                        viz_3_main_panel
                      )
)


## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Closing",
                           h1("Conclusion"),
                           p("WIP concluding statements")
)



ui <- navbarPage("US Mental Health Budget",
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)
