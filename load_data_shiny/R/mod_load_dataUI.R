# mod ui
mod_load_dataUI <- function(id) {

  ns <- NS(id)


  tagList(

    br(), br()

   , h2("Load Custom Data - EDA")

   , hr()
   , br()

  , fluidRow(
    column(2, 
    fluidRow(fileInput(ns("file1"), "Choose CSV File", accept = ".csv")),
    fluidRow(uiOutput(ns("custom_ui_x"))),
    fluidRow(uiOutput(ns("custom_ui_y"))),
    fluidRow(uiOutput(ns("custom_ui_grp")))
    ),
    column(6, echarts4rOutput(ns("ec_plot2")))
    ,column(4, 
    fluidRow(tableOutput(ns("contents")))
    )
  )

# end  

)
}