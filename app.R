library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(reshape2)

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
