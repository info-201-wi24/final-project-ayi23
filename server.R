

library(ggplot2)
library(plotly)
library(dplyr)
library(leaflet)
library(tigris)
options(tigris_class = "sf")
options(tigris_use_cache = TRUE)



suicide_df<- read.csv("2015 Suicide Rates By State.csv")
stateexp_df<- read.csv("StateExpenditures.csv")
combined_df<-read.csv("State Expenditures and Suicide Rates.csv")
combined_df <- combined_df %>%
  mutate(DEATHS = gsub(",", "", DEATHS), # Remove commas
         DEATHS = as.numeric(DEATHS))

# Load US states geographic data from the tigris package
us_states_sf <- states()

# Assuming 'combined_df' is defined elsewhere or loaded before this code runs
# Load your data
combined_sf <- us_states_sf %>%
  left_join(combined_df, by = c("NAME" = "STATE"))

# Perform a left join to merge your data with the US states geographic data
combined_df<-read.csv("State Expenditures and Suicide Rates.csv")

server <- function(input, output){
  # Create a reactive expression to dynamically process and select data based on user input
  selected_data <- reactive({
    combined_sf %>%
      mutate(DEATHS = gsub(",", "", DEATHS),
             DEATHS = as.numeric(DEATHS),
             Value = .[[input$viz1radio]]) # After conversion, dynamically select the column
  })
  #The following code ia for Viz1, AKA the two interactive heat maps.
  
  # Render a Leaflet map output based on the selected data
  output$your_viz_1_output_id <- renderLeaflet({
    # Use the reactive 'selected_data()' in place of 'combined_sf'
    leaflet(data = selected_data()) %>% # Use the processed and selected data
      addTiles() %>% # Add default OpenStreetMap tiles
      addProviderTiles(providers$CartoDB.Positron) %>% # Add CartoDB Positron tiles for a different look
      setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>% # Set the initial view to center on the US
      addPolygons(
        fillColor = ~colorNumeric("YlOrRd", Value)(Value), # Color polygons based on the selected data column
        weight = 1, 
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        smoothFactor = 0.5,
        popup = ~paste(NAME, Value) # Popup shows state name and selected measure
      )
  })
  
  # Following code is for Viz2, aka MH Expenditure Heatmaps 
  
  MHselected_data <- reactive({
    combined_sf %>%
      mutate(TotalMHExpend = gsub(",", "", TotalMHExpend),
             TotalMHExpend = as.numeric(TotalMHExpend),
             Value = .[[input$viz2radio]])
  })
  
  output$your_viz_2_output_id <- renderLeaflet({
    leaflet(data = MHselected_data() %>% select(NAME, Value)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
      addPolygons(
        fillColor = ~colorNumeric("YlOrRd", MHselected_data()$Value)(MHselected_data()$Value),
        weight = 1,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        smoothFactor = 0.5,
        popup = ~paste(NAME, MHselected_data()$Value)
      )
  })
  
  # Following code is for viz3, aka correlational scatterplot
  output$your_viz_3_output_id <-  renderPlotly({
    combined_df <- read.csv("State Expenditures and Suicide Rates.csv")
    
    expendsuicide_plot <- ggplot(combined_df) +
      geom_point(mapping = aes(x = PerCapitaMHExpend, y = RATE, fill = STATE, text = paste0(STATE,", ", RATE, "%"))) +
      (labs(title = "Suicide Rates vs. State Per Capita Expenditures", x = "State Expenditures Per Capita", y = "Suicide Rate")) +
      geom_smooth(aes(PerCapitaMHExpend, RATE), method="lm", se=F)
    expendsuicide_plot %>% ggplotly(tooltip=c("text"))
  })
  
  # TODO Make outputs based on the UI inputs here
}

# TO DO make outputs
