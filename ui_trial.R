library(shiny)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Introduction",
                         fluidPage(
                           h1("Introduction"),
                           p("This Shiny app explores the correlation between state expenditures on mental health and suicide rates in the United States."),
                           p("Select options below to explore the data.")
                         )
)

## HEATMAP OF SUICIDE RATES TAB INFO

suicide_heatmap_sidebar <- sidebarPanel(
  radioButtons("suicide_metric", "Select metric:", choices = c("Suicide Rate" = "RATE", "Total Suicide Death Count" = "DEATH"))
)

suicide_heatmap_main_panel <- mainPanel(
  leafletOutput("suicide_map")
)

suicide_heatmap_tab <- tabPanel("Suicide Rate Heatmap",
                                fluidPage(
                                  h2("Suicide Rate Heatmap"),
                                  sidebarLayout(
                                    suicide_heatmap_sidebar,
                                    suicide_heatmap_main_panel
                                  )
                                )
)

## HEATMAP OF STATE MENTAL HEALTH EXPENDITURES TAB INFO

mh_expenditure_heatmap_sidebar <- sidebarPanel(
  radioButtons("mh_expenditure", "Select expenditure type:", choices = c("Total Spending" = "TotalMHExpend", "Per Capita Spending" = "PerCapitaMHExpend"))
)

mh_expenditure_heatmap_main_panel <- mainPanel(
  leafletOutput("mh_expenditure_map")
)

mh_expenditure_heatmap_tab <- tabPanel("Mental Health Expenditure Heatmap",
                                       fluidPage(
                                         h2("Mental Health Expenditure Heatmap"),
                                         sidebarLayout(
                                           mh_expenditure_heatmap_sidebar,
                                           mh_expenditure_heatmap_main_panel
                                         )
                                       )
)

## SCATTERPLOT OF PER CAPITA SPENDING VS. SUICIDE RATES TAB INFO

scatterplot_sidebar <- sidebarPanel(
  # Add any sidebar inputs here if needed
)

scatterplot_main_panel <- mainPanel(
  plotOutput("scatterplot")
)

scatterplot_tab <- tabPanel("Scatterplot",
                            fluidPage(
                              h2("Scatterplot of Per Capita Spending vs. Suicide Rates"),
                              sidebarLayout(
                                scatterplot_sidebar,
                                scatterplot_main_panel
                              )
                            )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
                           fluidPage(
                             h1("Conclusion"),
                             p("Summarize your findings and conclusions here.")
                             # Add any additional content as needed
                           )
)

# Define UI for application
ui <- navbarPage("State Expenditures and Suicide Rates Analysis",
                 overview_tab,
                 suicide_heatmap_tab,
                 mh_expenditure_heatmap_tab,
                 scatterplot_tab,
                 conclusion_tab