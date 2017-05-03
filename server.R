shinyServer(function(input, output) {
    
    # =========================================================================
    # Reactive resources
    # =========================================================================
    resource.studios <- reactive({
      return(copy(dataframes$studios)[YEAR >= input$studios_years[1] & YEAR <= input$studios_years[2],])
    })
    
    resource.oscars <- reactive({
        return(dataframes$oscars)
    })
    
    resource.actors <- reactive({
        return(copy(dataframes$actors))
    })
    
    resource.directors <- reactive({
        return(copy(dataframes$directors))
    })
    
    resource.producers <- reactive({
        return(copy(dataframes$producers))
    })
    
    
    
    # =========================================================================
    # Server outputs : Datatables
    # =========================================================================
    output$studios_datatable <- DT::renderDataTable({
      datatable(
        resource.studios(),
        filter = 'top',
        rownames = FALSE,
        selection="multiple", 
        escape=FALSE,
        extensions = c(
          'Buttons',
          'Responsive'
        ),
        
        options = list(
          dom = 'Blrtip',
          autoWidth = TRUE,
          buttons = list('excel', 'csv'),
          Responsive = TRUE,
          lengthMenu = list(c(10, 20, 50, 100), c('10', '20','50','100'))
        )
      )
    })
    
    output$oscars_datable <- DT::renderDataTable({
      datatable(
        setorder(resource.oscars()$data[,.(RELEASEDATE,YEAR,MOVIE,STUDIO,
                                           BOXOFFICE,NOMINATIONS, WINS, 
                                           WIN_PERCENTAGE)
                                        ],
                 -YEAR
                ),
        filter = 'top',
        rownames = FALSE,
        selection="multiple", 
        escape=FALSE,
        extensions = c(
          'Buttons',
          'Responsive'
        ),
        
        options = list(
          dom = 'Blrtip',
          autoWidth = TRUE,
          buttons = list('excel', 'csv'),
          Responsive = TRUE,
          lengthMenu = list(c(10, 20, 50, 100), c('10', '20','50','100'))
        )
      )
    })
    
    output$actors_datatable <- DT::renderDataTable({
      datatable(
        resource.actors(),
        filter = 'top',
        rownames = FALSE,
        selection="multiple", 
        escape=FALSE,
        extensions = c(
          'Buttons',
          'Responsive'
        ),
        
        options = list(
          dom = 'Blrtip',
          autoWidth = TRUE,
          buttons = list('excel', 'csv'),
          Responsive = TRUE,
          lengthMenu = list(c(10, 20, 50, 100), c('10', '20','50','100'))
        )
      )
    })
    
    output$directors_datatable <- DT::renderDataTable({
      datatable(
        resource.directors(),
        filter = 'top',
        rownames = FALSE,
        selection="multiple", 
        escape=FALSE,
        extensions = c(
          'Buttons',
          'Responsive'
        ),
        
        options = list(
          dom = 'Blrtip',
          autoWidth = TRUE,
          buttons = list('excel', 'csv'),
          Responsive = TRUE,
          lengthMenu = list(c(10, 20, 50, 100), c('10', '20','50','100'))
        )
      )
    })
    
    output$producers_datatable <- DT::renderDataTable({
      datatable(
        resource.producers(),
        filter = 'top',
        rownames = FALSE,
        selection="multiple", 
        escape=FALSE,
        extensions = c(
          'Buttons',
          'Responsive'
        ),
        
        options = list(
          dom = 'Blrtip',
          autoWidth = TRUE,
          buttons = list('excel', 'csv'),
          Responsive = TRUE,
          lengthMenu = list(c(10, 20, 50, 100), c('10', '20','50','100'))
        )
      )
    })
    
    
    
    
    # =========================================================================
    # Server outputs : Plots
    # =========================================================================
    output$studios_box_office_timeseries <- renderPlotly({
        # get data
        df <- setorder(copy(resource.studios()), -YEAR, RANK)[,STUDIO:= factor(STUDIO, levels=unique(STUDIO))]

        # Get list of unique studios in filtered dataframe and Build colormap 
        colormap <- peopleSelectionColorMapper(
          unique(df$STUDIO), 
          c(input$studios_studio1, input$studios_studio2, input$studios_studio3)
        )
        
        # plotting
        ax <- list(
                    title = "Year",
                    titlefont= list(
                                    family = "Courier New, monospace",
                                    size = 15
                                  ),
                    zeroline = FALSE,
                    showline = FALSE,
                    showticklabels = TRUE,
                    showgrid = FALSE,
                    autotick = TRUE
                  )
        ay <- list(
                    title = "Box Office",
                    titlefont= list(
                                    family = "Courier New, monospace",
                                    size = 15
                                  ),
                    zeroline = FALSE,
                    showline = FALSE,
                    showticklabels = TRUE,
                    showgrid = FALSE,
                    autotick = TRUE
                  )
        
        plot_ly(
          df, 
          x = ~YEAR, 
          y = ~BOXOFFICE,
          color = ~STUDIO,
          type = 'scatter',
          mode = 'lines+markers',
          line = list(width=2),
          colors = colormap,
          hoverinfo = 'text',
          text = ~paste0(STUDIO,
                        '</br> Year: ',YEAR,
                        '</br> Box Office Total: $', BOXOFFICE,' MILLIONS'
                        )
        )%>%
          layout(xaxis = ax, yaxis = ay)
    })
    
    
    output$studios_movies_facet <- renderPlotly({
      
         # get data
         df <- copy(resource.studios())[,.(number = sum(MOVIES_YEAR), bo = sum(BOXOFFICE), avg = sum(BOXOFFICE)/sum(MOVIES_COUNT)),by=STUDIO]
         setorder(df, -avg)[,STUDIO:= factor(STUDIO, levels=df$STUDIO, ordered = TRUE)]
        
        # Get list of unique studios in filtered dataframe and Build colormap 
        colormap <- peopleSelectionColorMapper(df$STUDIO, c(input$studios_studio1, input$studios_studio2, input$studios_studio3))
        
        
        # plotting
        ax <- list(
                    title = "Studio (Hover on bar for information)",
                    titlefont= list(
                                    family = "Courier New, monospace",
                                    size = 15
                                  ),
                    zeroline = FALSE,
                    showline = FALSE,
                    showticklabels = FALSE,
                    showgrid = FALSE,
                    tickangle = 0
                  )
        ay <- list(
                    title = "Movies Produced",
                    titlefont= list(
                                    family = "Courier New, monospace",
                                    size = 15
                                  ),
                    zeroline = FALSE,
                    showline = FALSE,
                    showticklabels = TRUE,
                    showgrid = FALSE
                    
                  )
        
        plot_ly(
          df,
          x = ~STUDIO, 
          y = ~number,
          color = ~STUDIO,
          type = 'bar',
          colors = colormap,
          hoverinfo = 'text',
          text = ~paste0(
                        '</br>', STUDIO,
                        '</br> Number of Movies: ', number,
                        '</br> Total BO: $', bo ,' MILLIONS',
                        '</br> Average per Movie: $', floor(avg),' MILLIONS'
                        )
        )%>%
          layout(xaxis = ax, yaxis = ay, legend=list(traceorder="reversed"))
    })
    
    
    output$oscars_ranking <- renderPlotly({
      oscarsRankingPlotly(resource.oscars())
    })
    
    output$oscars_months <- renderPlotly({
      oscarsMonthsPloty(copy(resource.oscars()$data))
    })
    
    
    
    
    output$actors_boxoffice <- renderPlotly({
      
        barPlotly(c(input$actors_actor1, input$actors_actor2, input$actors_actor3), "Actors", input$actors_movies_metric, resource.actors())
    })
    
    
    output$directors_boxoffice <- renderPlotly({
        barPlotly(c(input$directors_director1, input$directors_director2, input$directors_director3), "Directors", input$directors_movies_metric, resource.directors())
      
    })
    
    
    output$producers_boxoffice <- renderPlotly({
        barPlotly(c(input$producers_producer1, input$producers_producer2, input$producers_producer3), "Producers", input$producers_movies_metric, resource.producers())
    })
    
    
    
})