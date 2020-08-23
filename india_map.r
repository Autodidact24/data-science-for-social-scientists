library(leaflet)
library(jsonlite)
library(dplyr)


world_loans <- read_tsv('~/Downloads/datasets_14714_19678_kiva_locations.csv')
india_loans = filter(world_loans, country == 'India')

geojson <- readLines("~/Desktop/india_states.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

geojson$style = list(
  opacity = 0.5,
  fillOpacity = 0.8
)

leaflet() %>%
  setView(lng = 78.9, lat = 20.5, zoom = 10) %>%
  addGeoJSON(geojson) %>%
  addCircleMarkers(lng = india_loans$lng, lat = india_loans$lat, color = 'red')
