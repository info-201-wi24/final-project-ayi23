library(dplyr)

# Read CSV files
csv1 <- read.csv("2015 Suicide Rates By State.csv")
csv2 <- read.csv("StateExpenditures.csv")

# Join CSV files based on the "STATE" column
joined_data <- left_join(csv1, csv2, by = "STATE")

# Write joined data to a new CSV file
write.csv(joined_data, "State Expenditures and Suicide Rates.csv", row.names = FALSE)

#one categorical variable -> State
#one new continuous/numerical variable -> Suicide Rates, Expenditures

#one data summarization table
summarization_df <- joined_data %>%
  summarize(
    (Mean_Suicide_Rate = mean(RATE, na.rm = TRUE)),
    (Mean_Deaths = mean(DEATHS, na.rm = TRUE)),
    (Mean_State_Expenditure = mean(TotalMHExpend, na.rm = TRUE)),
    (Mean_Per_Capita_Expenditure = mean(PerCapitaMHExpend, na.rm = TRUE))
    )
