library(dplyr)
library(stringr)
library(ggplot2)
library(plotly)
library(tidyr)

combined_df <- read.csv("State Expenditures and Suicide Rates.csv")

expendsuicide_plot <- ggplot(combined_df) +
    geom_point(mapping = aes(x = PerCapitaMHExpend, y = RATE, fill = STATE, text = paste0(STATE,", ", RATE, "%"))) +
    (labs(title = "Suicide Rates vs. State Per Capita Expenditures", x = "State Expenditures Per Capita", y = "Suicide Rate"))
expendsuicide_plot %>% ggplotly(tooltip=c("text"))