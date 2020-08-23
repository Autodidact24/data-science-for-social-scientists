library(readr)
library(plotly)
library(dplyr)
library(leaflet)
library(jsonlite)

world_loans <- read_tsv('~/Downloads/datasets_14714_19678_kiva_locations.csv')


g <- list(
  scope = 'world',
  projection = list(type = 'Mercator'),
  showframe = FALSE,
  showland = TRUE,
  showcoastlines = TRUE,
  landcolor = toRGB("grey85"),
  countrywidth = 0.2
)

# Plotting all the Kiva loans

fig <- world_loans %>% plot_geo(
  color = I("blue"), text = world_loans$country
)

fig <- fig %>% add_markers(
  y = world_loans$lat, x = world_loans$lng
)

fig <- fig %>% layout(
  title = 'Kiva loans accross the world', geo = g
)

#fig

## Getting Kiva loans in Philippines
philippines_loans = filter(world_loans, country == 'Philippines')


# g <- list(
#   scope = 'asia',
# 
#   lakecolor = toRGB('white')
# )
# 
# plot_geo() %>%
#   add_trace(
#     text = philippines_loans$region , span = I(0),
#     y = philippines_loans$lat, x = philippines_loans$lng, locationmode = 'PHL'
#   ) %>%
#   layout(geo = data)

geojson <- readLines("~/Desktop/philippines.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 1,
  fillOpacity = 0.8
)

leaflet(philippines_loans) %>%
  setView(lng = 12.27, lat = 122.77, zoom = 1) %>%
  addGeoJSON(geojson)
