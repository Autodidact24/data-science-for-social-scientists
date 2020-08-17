library(dplyr)
library(readr)


df <- read_csv("~/Desktop/Indicators.csv")
head(df)

indicator <- "Compulsory education, duration (years)"

compulsory_edu <- filter(df, 'IndicatorName' == indicator & 'Year' == 2013)
