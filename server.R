library(ggplot2)
library(plotly)
library(dplyr)
library(leaflet)
library(tigris)
options(tigris_class = "sf")
options(tigris_use_cache = TRUE)

us_states_sf <- states()

combined_sf <- us_states_sf %>%
  left_join(combined_df, by = c("NAME" = "STATE"))

combined_df<-read.csv("State Expenditures and Suicide Rates.csv")

server <- function(input, output){
  selected_data <- reactive({
    combined_sf %>%
      mutate(DEATHS = gsub(",", "", DEATHS),
             DEATHS = as.numeric(DEATHS),
             Value = .[[input$viz1radio]]) # After conversion, dynamically select the column
  })
  
  output$your_viz_1_output_id <- renderLeaflet({
    # Use the reactive 'selected_data()' in place of 'combined_sf'
    leaflet(data = selected_data()) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
      addPolygons(
        fillColor = ~colorNumeric("YlOrRd", Value)(Value),
        weight = 1,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        smoothFactor = 0.5,
        popup = ~paste(NAME, Value) # Popup shows state name and selected measure
      )
  })
  
  # TODO Make outputs based on the UI inputs here
  
}