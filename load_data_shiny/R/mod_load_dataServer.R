
# mod server
mod_load_dataServer <- function(id) {
  moduleServer(id, function(input, output, session) {


  #?
  ns <- session$ns  

  #? custom data
   react_data <- reactive({

    file <- input$file1
    ext <- tools::file_ext(file$datapath)

    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))

    read.csv(file$datapath) %>%
    na.omit()

   })

    #? table
    output$contents <- renderTable({
    req(input$file1)
    validate(need(nrow(react_data()) != 0, "Please upload a csv file"))
    react_data() %>% head()
    })


  #? custom ui part

  # x
  output$custom_ui_x <- renderUI({
    req(input$file1)
    num_cols <- react_data() %>% purrr::discard(~ !is.numeric(.)) %>% names()
    selectInput(ns("sc_x"), 'X-Axis', num_cols)
  })  

  # y
  output$custom_ui_y <- renderUI({
   req(input$file1)
   num_cols <- react_data() %>% purrr::discard(~ !is.numeric(.)) %>% names()
   selectInput(ns("sc_y"), 'Y-Axis', num_cols[ !num_cols == input$sc_x])
  })  
  
  # groupby
   output$custom_ui_grp <- renderUI({
   req(input$file1)
   non_num_cols <- react_data() %>% purrr::discard(~is.numeric(.)) %>% names()
   selectInput(ns("sc_grp"), 'Group-by', non_num_cols)
  }) 

  
  #? plot2
    output$ec_plot2 <- renderEcharts4r({

    req(input$file1)
    validate(need(nrow(react_data()) != 0, "Please upload a csv file"))

     req(input$sc_x)
     req(input$sc_y)
     req(input$sc_grp)

     #?
     temp_df2 <- react_data() %>% 
                 dplyr::select(input$sc_x, input$sc_y, input$sc_grp) 
                  
     
     names(temp_df2) <- c('x','y','grp')         
         
         temp_df2 %>%
          group_by(grp) %>%
          e_charts(x) %>% 
          e_scatter(y, symbol_size = 8) %>%
          e_x_axis(scale = TRUE) %>%
          e_y_axis(scale = TRUE) %>%
          e_tooltip()

    })



  # end

  })
}