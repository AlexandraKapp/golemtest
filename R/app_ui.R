#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    dashboardPage(
      dashboardHeader(title = "Hamburg"),
      sidebar,
      body
    )
    
  )
}

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Stops", tabName = "stops"),
    menuItem("Isochrone", tabName = "isochrone"),
    menuItem("Hbf isochrone", tabName = "hbf_isochrone")
  )
)

body <- dashboardBody(
  tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}", 
             "#mapIsochrone {height: calc(100vh - 80px) !important;}",
             "#map_hbf_isochrone {height: calc(100vh - 80px) !important;}", ),
  
  tabItems(
    tabItem(
      tabName = "stops",
      leafletOutput("map")
    ),
    
    tabItem(
      tabName = "isochrone",
      leafletOutput("mapIsochrone")
    ),
    tabItem(
      tabName = "hbf_isochrone",
      leafletOutput("map_hbf_isochrone")
    )
    
  )
)


#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'golemtest')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
