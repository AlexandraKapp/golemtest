#' Run the Shiny Application
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#' @import shinydashboard
#' @import leaflet
#' @import readr
#' @import sf
#' @import osrm

run_app <- function(...) {
  with_golem_options(
    app = shinyApp(ui = app_ui, server = app_server), 
    golem_opts = list(...)
  )
}
