library(dplyr)

# Read CSV files
csv1 <- read.csv("2015 Suicide Rates By State.csv")
csv2 <- read.csv("StateExpenditures.csv")

# Join CSV files based on the "STATE" column
joined_data <- left_join(csv1, csv2, by = "STATE")

# Write joined data to a new CSV file
write.csv(joined_data, "State Expenditures and Suicide Rates.csv", row.names = FALSE)

#one new categorical variable

#one new numerical variable (continuous)

#one data summarization table