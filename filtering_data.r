library(readr)
library(dplyr)
library(plotly)

df <- read_csv("~/Desktop/Indicators.csv")
head(df)

indicator <- "Enrolment in primary education, both sexes (number)"
year <- 2011

enrolment <- filter(df, IndicatorName == indicator, Year == year)

data = select(enrolment, CountryName, CountryCode, Value)

specific_countries <- filter(data, CountryName %in% c('India', 'China', 'Germany'))
barchart <- plot_ly(specific_countries, type='bar',
                    x = specific_countries$CountryName,
                    y = specific_countries$Value
                    )
barchart

 fig <- plot_ly(data, type='choropleth', locations=data$CountryCode, z=data$Value, 
                text=data$CountryName, colorscale="blues")
 fig
