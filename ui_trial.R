## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview",
   h1("Mental Health Expenditures & Suicide Rates"),
   p("WIP")
)

## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("WIP heatmap"),
  #TODO: Put inputs for modifying graph here
)

viz_1_main_panel <- mainPanel(
  h2("Heatmap of Suicide Rates"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_1_tab <- tabPanel("Suicide Rates per State",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("WIP heatmap"),
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Heatmap of State Mental Health Expenditures"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_2_tab <- tabPanel("MH Expenditure per State",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Scatterplot of MH Expenditures and Suicide Rates"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Correlation",
  sidebarLayout(
    viz_3_sidebar,
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
