
library(shiny)
library(palmerpenguins)
library(ggplot2)
library(purrr)
library(dplyr)
library(echarts4r)

# source external files

# source all modules
mod_file_path <- paste0('./R')

# only specific pattern in the directory
mod_scripts <- list.files(path= mod_file_path, pattern = glob2rx("mod_*.R")) %>% as_vector()

#
analyticscripts <- c(mod_scripts) %>% 
                   as_tibble() %>%
                   mutate(value = paste0(mod_file_path,'/',value))

# load all functions
purrr::walk(analyticscripts$value, source)

#? Shiny modules
# mod app
load_dataApp <- function() {
  ui <- fluidPage(
    mod_load_dataUI("id1")
  )
  server <- function(input, output, session) {
    mod_load_dataServer("id1")
  }
  shinyApp(ui, server)  
}


load_dataApp()