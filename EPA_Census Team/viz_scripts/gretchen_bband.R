
library(rgdal)
library(tidyverse)
library(stringr)
library(leaflet)
library(RColorBrewer)

# Get Data (in this folder)
maniblocks <- readOGR(dsn = "data_files/manistee bband blocks.shp")

#plot
#define bins 
bins <- c(1:9)
pal <- colorNumeric("YlGnBu", domain = maniblocks@data$ProvideNum)

bbandmap <- leaflet(maniblocks) %>%
  addPolygons(stroke = TRUE, smoothFactor = 0.5,
              weight=1, color='#333333',  
              fillColor = ~pal(ProvideNum), 
              fillOpacity = 1,
              #add pinpoint label
              label = ~stringr::str_c(NAME10, ':',
                                      formatC(ProvideNum)),
              labelOptions = labelOptions(direction = 'auto'),
              #add hover highlight
              highlightOptions = highlightOptions(
                color='#000000', weight = 3,
                bringToFront = TRUE, sendToBack = TRUE))

bbandmap2 <- bbandmap %>% 
  addLegend("bottomleft", 
            pal = pal, 
            values = ~ProvideNum, 
            title = htmltools::HTML("Number of Providers"))

bbandmap3 <- setView(bbandmap2, lng = -86.1, lat = 44.3350, zoom = 10)
bbandmap3
