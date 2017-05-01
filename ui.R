shinyUI(fluidPage(
    tags$head(tags$link(rel="stylesheet", type="text/css", href="app.css")),
    tags$head(tags$link(rel="stylesheet", type="text/css", href="https://fonts.googleapis.com/css?family=Architects+Daughter|Ubuntu")),
    
    titlePanel("Box Office Explorer"),
    
    sidebarLayout(
        sidebarPanel(
            p(class="text-small",
              a(href="https://ahmedtadde.github.io/DataQuest", target="_blank", "by Ahmed Tadde"),
              a(href="https://github.com/ahmedtadde/BOMViz", target="_blank", icon("github")), " | ",
              a(href="https://www.linkedin.com/in/ahmedtadde", target="_blank", icon("linkedin"))),
            hr(),
            p(class="text-small", "Data visualizations on Oscars and Top Hollywood Personalities. Data derived from ",
              a(href="http://www.boxofficemojo.com/", target="_blank", "Box Office Mojo"),
              " and", a(href="http://www.omdbapi.com/", target="_blank", "The Open Movie Database")),
            hr(),
            
            conditionalPanel(
                condition="input.tabset == 'Oscars'"
                # selectInput(inputId="oscars_metric", label="Select Metric", choices=choices$oscars_metric, selected=choices$oscars_metric[[1]]),
                # sliderInput(inputId="oscars_years", label="Filter Years", min=min(choices$oscars_years), max=max(choices$oscars_years),
                #             value=c(min(choices$oscars_years), max=max(choices$oscars_years)), step=1, sep = "")
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Actors'",
                selectInput(inputId="actors_movies_metric", label="Select Metric", choices=movieMetricInputLabels, selected=movieMetricInputLabels[1]),
                selectInput(inputId="actors_actor1", label="Actor 1:", choices=choices$actors, selected=choices$actors[[1]]),
                selectInput(inputId="actors_actor2", label="Actor 2:", choices=choices$actors, selected=choices$actors[[2]]),
                selectInput(inputId="actors_actor3", label="Actor 3:", choices=choices$actors, selected=choices$actors[[3]])
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Directors'",
                selectInput(inputId="directors_movies_metric", label="Select Metric", choices=movieMetricInputLabels, selected=movieMetricInputLabels[1]),
                selectInput(inputId="directors_director1", label="Director 1:", choices=choices$directors, selected=choices$directors[[1]]),
                selectInput(inputId="directors_director2", label="Director 2:", choices=choices$directors, selected=choices$directors[[2]]),
                selectInput(inputId="directors_director3", label="Director 3:", choices=choices$directors, selected=choices$directors[[3]])
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Producers'",
                selectInput(inputId="producers_movies_metric", label="Select Metric", choices=movieMetricInputLabels, selected=movieMetricInputLabels[1]),
                selectInput(inputId="producers_producer1", label="Producer 1:", choices=choices$producers, selected=choices$producers[[1]]),
                selectInput(inputId="producers_producer2", label="Producer 2:", choices=choices$producers, selected=choices$producers[[2]]),
                selectInput(inputId="producers_producer3", label="Producer 3:", choices=choices$producers, selected=choices$producers[[3]])
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Studios'",
                selectInput(inputId="studios_studio1", label="Studio 1:", choices=choices$studios, selected=choices$studios[[1]]),
                selectInput(inputId="studios_studio2", label="Studio 2:", choices=choices$studios, selected=choices$studios[[2]]),
                selectInput(inputId="studios_studio3", label="Studio 3:", choices=choices$studios, selected=choices$studios[[3]]),
                sliderInput(inputId="studios_years", label="Filter Years", min=min(choices$studios_years), max=max(choices$studios_years),
                            value=c(min(choices$studios_years), max(choices$studios_years)), step=1, sep = "")
            ),
            
            width=3
        ),
        
        mainPanel(
            tabsetPanel(id="tabset",
                        
                        tabPanel("Oscars",
                                 h2("Visual Ranking"),
                                 p(class="text-small", "This session displays the visual ranking of oscars 'Best Picture' winning movies (2000-)
                                   by plotting critical success against domestic box office"),
                                 hr(),
                                 
                                 plotlyOutput("oscars_ranking", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Oscars Season"),
                                 p(class="text-small", "The data perfectly shows the so-called 'Oscars Season' with December and November as the most prolific month of oscars winning movies.
                                   There has never been an oscars winning movie released in the first quarter of the year."),
                                 plotlyOutput("oscars_months", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Data"),
                                 p(class="text-small", "Table data similar to that found in the original ",
                                   a(href="http://www.boxofficemojo.com/oscar/", target="_blank", "source")),
                                 p(class="text-small-italic", "Box office units are in million dollars ($M)."),
                                 p(class="text-small-italic", "You can download the data with the download buttons below."),
                                 dataTableOutput("oscars_datable"),
                                 hr()
                        ),
                        
                        tabPanel("Actors",
                                 h2("Top 50 Actors"),
                                 p(class="text-small", "This section displays visualizations for the top 50 actors by box office numbers."),
                                 hr(),
                                 
                                 h3("Compare Box Office Numbers"),
                                 plotlyOutput("actors_boxoffice", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Data"),
                                 p(class="text-small", "Table data similar to that found in the original ", 
                                   a(href="http://www.boxofficemojo.com/people/?view=Actor&sort=sumgross&order=DESC&p=.htm", target="_blank", "source")),
                                 p(class="text-small", "Box office units are in million dollars ($M)."),
                                 p(class="text-small-italic", "You can download the data with the download buttons below."),
                                 dataTableOutput("actors_datatable"),
                                 hr()
                        ),
                        
                        tabPanel("Directors",
                                 h2("Top 50 Directors"),
                                 p(class="text-small", "This section displays visualizations for the top 50 directors by box office numbers."),
                                 hr(),
                                 
                                 h3("Compare Box Office Numbers"),
                                 plotlyOutput("directors_boxoffice", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Data"),
                                 p(class="text-small", "Table data similar to that found in the original ", 
                                   a(href="http://www.boxofficemojo.com/people/?view=Director&sort=sumgross&order=DESC&p=.htm", target="_blank", "source")),
                                 p(class="text-small-italic", "Box office units are in million dollars ($M)."),
                                 p(class="text-small-italic", "You can download the data with the download buttons below."),
                                 dataTableOutput("directors_datatable"),
                                 hr()
                        ),
                        
                        tabPanel("Producers",
                                 h2("Top 50 Producers"),
                                 p(class="text-small", "This section displays visualizations for the top 50 producers by box office  numbers."),
                                 hr(),
                                 
                                 h3("Compare Box Office Numbers"),
                                 plotlyOutput("producers_boxoffice", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Data"),
                                 p(class="text-small", "Table data similar to that found in the original ", 
                                   a(href="http://www.boxofficemojo.com/people/?view=Producer&sort=sumgross&order=DESC&p=.htm", target="_blank", "source")),
                                 p(class="text-small-italic", "Box office units are in million dollars ($M)."),
                                 p(class="text-small-italic", "You can download the data with the download buttons below."),
                                 dataTableOutput("producers_datatable"),
                                 hr()
                        ),
                        
                        tabPanel("Studios",
                                 h2("Top Studios"),
                                 p(class="text-small",
                                   "This section displays visualizations for 
                                   all studios that appeared at least once in 
                                   the Top 10 Studio Box Office ranking 
                                   since the year 2000"),
                                 hr(),
                                 
                                 h3("Box Office Time Series"),
                                 p(class="text-small", "Compare studios' box office numbers over the years."),
                                 p(class="text-small-italic", "Click and/or Double-Click plot legend for selected displays"),
                                 plotlyOutput("studios_box_office_timeseries", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("More Movies, More Money?"),
                                 p(class="text-small", "This plot displays the number of produced by each studio. 
                                   The bars are arranged in descending order by average revenue per movie."),
                                 p(class="text-small-italic", "Note that producing more movies does not correlate 
                                   directly with box office success. In recent years, Buena Vista has had 
                                   the best average revenue per movie."),
                                 plotlyOutput("studios_movies_facet", height="auto", width="auto"),
                                 hr(),
                                 
                                 h3("Data"),
                                 p(class="text-small", "Table data similar to that found in the original ", 
                                   a(href="http://www.boxofficemojo.com/studio/", target="_blank", "source")
                                  ),
                                 p(class="text-small-italic", "Box office units are in million dollars ($M)."),
                                 p(class="text-small-italic", "You can download the data with the download buttons below."),
                                 dataTableOutput("studios_datatable"),
                                 hr()
                        )
            ),
            width=9
        )
    )
))
