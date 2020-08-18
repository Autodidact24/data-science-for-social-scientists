library(dplyr)
library(readr)
library(ggplot2)
library(maps)

df <- read_csv("~/Desktop/Indicators.csv")
head(df)

indicator <- ""
year <- 

co2_emissions <- filter(df, IndicatorName == indicator, Year == year)

# making a base map

world_map <- map_data("world")
# p <- ggplot() +
#   geom_polygon(data=world_map, aes(x=long, y=lat, group=group),
#                 color="white", fill="red" )
# 
# print(p)
map.world <- merge(x=world_map,
                   y=select(co2_emissions, CountryName, Value),
                   by.x="region",
                   by.y="CountryName",
                   all.x=TRUE)



p <- ggplot(map.world) +
  geom_map(map=map.world, aes(map_id=region, x=long, y=lat, fill=Value)) +
  scale_fill_gradient(low = "green", high = "red", guide = "colourbar") +
  coord_equal() +
  ggtitle(paste0(indicator, " in ", year))
ggsave("map.png", p, width=7, height=4, units="in")

print(p)
