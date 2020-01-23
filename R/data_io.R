
get_isochrones_from_file <- function(file) {
  col_types <- list(col_character(), col_double(), col_double(),col_double(), col_character())
  isoc <- read_csv(file, header = TRUE)
  isoc$geometry <- st_as_sfc(isoc$geometry)
  isoc <- st_as_sf(isoc, sf_column_name="geometry")
  return(isoc)
}

get_stops_from_file <- function(file) {
  col_types <- list(col_character(), col_character(), col_character(), col_character(), col_character(), col_character(), col_double(), col_double())
  input <- read_csv(file, col_types = col_types)
  stops <- st_as_sf(input, coords = c("lon", "lat"), crs = 4326)
  return(stops)
}
