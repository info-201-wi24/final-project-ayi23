library(dplyr)

# Read CSV files
csv1 <- read.csv("2015 Suicide Rates By State.csv")
csv2 <- read.csv("StateExpenditures.csv")

# Join CSV files based on the "STATE" column
joined_data <- inner_join(csv1, csv2, by = c("STATE" = "state"))

# Write joined data to a new CSV file
write.csv(joined_data, "State Expenditures and Suicide Rates.csv", row.names = FALSE)