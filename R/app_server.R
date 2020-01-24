#' @import shiny
#' @import shinydashboard
#' @import leaflet
#' @import readr
#' @import sf
#' @importFrom osrm osrmIsochrone



app_server <- function(input, output, session) {
  output$map <- renderLeaflet({

    stops <- get_stops_from_file("data/hamburg.csv")

    pal <- colorFactor(
      palette = c("yellow", "grey", "orange", "purple", "red", "blue"), # "Accent"
      domain = stops$name
    )


    leaflet(stops, options = leafletOptions(minZoom = 0, maxZoom = 18), height = "100%") %>%
      setView(lng = 9.99, lat = 53.55, zoom = 12) %>%
      addTiles() %>% # Add default OpenStreetMap map tiles
      addCircles(color = ~ pal(name), radius = 400, stroke = FALSE, label = ~stop_name, fillOpacity = 0.6, group = ~name) %>%
      addLayersControl(
        overlayGroups = ~name,
        options = layersControlOptions(collapsed = FALSE)
      ) %>%
      addLegend("bottomright", pal = pal, values = ~name, opacity = 1, title = "Type of Transportation")
  })


  output$mapIsochrone <- renderLeaflet({

    # isochrones <- st_read("hh_osrm_isochrones.geojson")
    isochrones <- st_read("data/hh_xbahn_osrm_isochrones.geojson")


    leaflet(isochrones, options = leafletOptions(minZoom = 0, maxZoom = 18), height = "100%") %>%
      setView(lng = 9.99, lat = 53.55, zoom = 12) %>%
      addTiles() %>% # Add default OpenStreetMap map tiles
      addPolygons(color = "red", fillOpacity = 0.8, fill = TRUE)
  })


  output$map_hbf_isochrone <- renderLeaflet({

    stops <- get_stops_from_file("data/hamburg.csv")

    # Get isochones with an sf POINT
    hh_mainstation <- stops[2585, ]
    iso <- osrmIsochrone(
      loc = hh_mainstation, returnclass = "sf",
      breaks = seq(from = 0, to = 20, by = 5)
    )

    pal_isochrone <- colorFactor(
      palette = "YlOrRd",
      domain = iso$min
    )

    leaflet(iso, options = leafletOptions(minZoom = 0, maxZoom = 18), height = "100%") %>%
      setView(lng = 9.99, lat = 53.55, zoom = 12) %>%
      addTiles() %>% # Add default OpenStreetMap map tiles
      addPolygons(color = ~ pal_isochrone(min), fillOpacity = 0.8, fill = TRUE) %>%
      addLegend("bottomleft", pal = pal_isochrone, values = ~min, opacity = 1, title = "Min. Duration")
  })
}
