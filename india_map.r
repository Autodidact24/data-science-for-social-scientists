library(readr)
library(leaflet)
library(dplyr)
library(plotly)


world_loans <- read_tsv('~/Downloads/kiva_locations.csv') 
india_loans <- filter(world_loans, country == 'India')

loan_themes_by_region <- read_csv('~/Downloads/12414_19728_bundle_archive/loan_themes_by_region.csv')

## Understanding the distribution of loans

data <- data.frame(table(loan_themes_by_region$sector))
colnames(data) <- c("sector", "loans_frequency")

fig <- plot_ly(data, labels = ~sector, values = ~loans_frequency, type = 'pie')
fig <- fig %>% layout(title = "Sectorwise distribution of loans")
fig


geojson <- readLines("~/Downloads/india_states_low_res.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

geojson$style = list(
  opacity = 0.5,
  fillOpacity = 0.8,
  color = 'grey'
)

leaflet() %>%
  setView(lng = 78.9, lat = 20.5, zoom = 4.2) %>%
  addGeoJSON(geojson) %>%
  addMarkers(lng = india_loans$lng, lat = india_loans$lat, label = india_loans$region)
