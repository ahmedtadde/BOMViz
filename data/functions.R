# Load libraries

libraries <- function(){
  library(pacman)
  p_load(XML)
  p_load(dplyr)
  p_load(shiny)
  p_load(plotly)
  p_load(scales)
  p_load(stringi)
  p_load(grid)
  p_load(reshape2)
  p_load(data.table)
  p_load(DT)
  p_load(foreach)
  options(warn=-1) # turn off unneccessary NA warnings in the code from XML library

}
# =========================================================================
# function get_data_studio
#
# @description: calls scrape_table_studios to get studio data for all years from boxofficemojo
# @return: dataframe of studios and movies
# =========================================================================
get_data_studios <- function() {
    df <- data.frame(NULL)
    for (year in seq(2000, 2016, by=1)) {
        table <- scrape_table_studios(year)  # get data for each year
        df <- rbind_list(df, table)  # bind to final dataframe
    }
    df <- df %>%
        arrange(-YEAR, RANK)  # sort dataframe
    return(data.table(df))
}



# =========================================================================
# function get_data_oscars
#
# @description: get Oscar data for all years from boxofficemojo
# @return: dataframe of Oscar movies
# =========================================================================
get_data_oscars <- function(updateRecords = "") {
  
  if(tolower(updateRecords) %in% "update"){
    url <- "http://www.boxofficemojo.com/oscar/?sort=studio&order=ASC&p=.htm"
    colNames <- c("ROW"="character",
                  "YEAR"="numeric",
                  "MOVIE"="character",
                  "STUDIO"="character",
                  "BOXOFFICE"="Currency",
                  "NOMINATIONS"="numeric",
                  "WINS"="numeric",
                  "RELEASEDATE"="character")
    
    # get data
    tables <- readHTMLTable(url, header=TRUE, stringsAsFactors=FALSE, colClasses=unname(colNames))
    df <- tables[[4]]  # data is in the 4th table
    
    # reshape data
    colnames(df) <- names(colNames)
    df <- df %>%
      select(-ROW) %>%
      mutate(BOXOFFICE = round(BOXOFFICE / 1000000, 2),
             WIN_PERCENTAGE = round(WINS / NOMINATIONS, 4)) %>%
      arrange(-YEAR)
    
    data.table::fwrite(df, "data/oscars.csv")
    return(data.table(df))
  }else{
    return(fread('data/oscars.csv'))
    
  }
}



# =========================================================================
# function get_data_actors
#
# @description: calls scrape_people to get top 50 actors data from boxofficemojo
# @return: dataframe of top 50 actors and movies
# =========================================================================
get_data_actors <- function() {
  
    df <- scrape_people("Actor")
    return(data.table(df))
}



# =========================================================================
# function get_data_directors
#
# @description: calls scrape_people to get top 50 directors data for all years from boxofficemojo
# @return: dataframe of directors and movies
# =========================================================================
get_data_directors <- function() {
    df <- scrape_people("Director")
    return(data.table(df))
}



# =========================================================================
# function get_data_producers
#
# @description: calls scrape_people to get top 50 producers data for all years from boxofficemojo
# @return: dataframe of producers and movies
# =========================================================================
get_data_producers <- function() {
    df <- scrape_people("Producer")
    return(data.table(df))
}



# =========================================================================
# helper function scrape_table_studios
#
# @description: scrapes the boxofficemojo website for studio data given a year input
# @param year: integer year value
# @return: dataframe of table
# =========================================================================
scrape_table_studios <- function(year) {
    url <- sprintf("http://www.boxofficemojo.com/studio/?view=majorstudio&view2=yearly&yr=%s&p=.htm", year)
    colNames <- c("RANK"="integer",
                  "STUDIO"="character",
                  "MARKETSHARE"="Percent",
                  "BOXOFFICE"="Currency",
                  "MOVIES_COUNT"="integer",
                  "MOVIES_YEAR"="integer")
    
    # get data
    tables <- readHTMLTable(url, header=TRUE, stringsAsFactors=FALSE, colClasses=unname(colNames))
    df <- tables[[4]]  # data is in the 4th table
    
    
    # reshape data
    colnames(df) <- names(colNames)
    df <- df %>%
        mutate(YEAR = year) %>%
        filter(RANK <= 10)  # limit data to top 10 studios
    return(df)
}



# =========================================================================
# helper function scrape_people
#
# @description: scrapes the boxofficemojo website for people data given a role input
# @param role: string value
# @return: dataframe of table
# =========================================================================
scrape_people <- function(role) {
    url <- sprintf("http://www.boxofficemojo.com/people/?view=%s&sort=sumgross&p=.htm", role)
    colNames <- c("RANK"="numeric",
                  "PERSON"="character",
                  "TOTAL_BO"="Currency",
                  "MOVIES_COUNT"="numeric",
                  "AVERAGE_BO"="Currency",
                  "BEST_PICTURE"="character",
                  "BEST_BO"="Currency")
    
    # get data
    tables <- readHTMLTable(url, header=TRUE, stringsAsFactors=FALSE, colClasses=unname(colNames))
    df <- tables[[4]]  # data is in the 4th table
    
    # reshape data
    colnames(df) <- names(colNames)
    return(data.table(df))
}


# =========================================================================
# peopleSelectionColorMapper
# @param array: an array to be assigned colors based on its index values
# @param conditions: condition array to determine which color is assigned (these are basically shiny input UI selections)
# @return: returns a named vector mapping colors to the original array.
# # =========================================================================
peopleSelectionColorMapper <- function(array, conditions){
  
  colormap <- rep("gray85", length(array))
  foreach( j = 1:length(conditions))%do%{
    colormap[which(array %in% conditions[j])] <- peopleSelectionColors[j]
  }
  
  
  names(colormap) <- array
  rm(list = c("j"))
  return(colormap)
}


# =========================================================================
# @description: returns a barPlot for people data given a role input
# @param: peopleInput(vector of people selected, string); role(string) ; metricInput(which metric, string); dataframe
# @return: plotly barPlot for display
# =========================================================================

barPlotly <- function(peopleInput ="",role ="", metricInput, data){
  # get data
  df <- setorderv(copy(data), metricInput)[,PERSON:= factor(PERSON, levels = PERSON, ordered = TRUE )]
  df[, METRIC:= df[, get(metricInput)]]
  
  # Build colormap
  colormap <- peopleSelectionColorMapper(df$PERSON, peopleInput) 
  
  # set axis parameters
  ax <- list(
    title = paste0("Metric Value (", metricInput,")"),
    titlefont= list(
      family = "Courier New, monospace",
      size = 15
    ),
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = TRUE,
    showgrid = FALSE,
    tickangle = 0
  )
  ay <- list(
    title = role,
    titlefont= list(
      family = "Courier New, monospace",
      size = 15
    ),
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = FALSE,
    showgrid = FALSE
    
  )
  
  
  # plotting
  if(metricInput %in% "MOVIES_COUNT"){
    plot_ly(
      df,
      y = ~PERSON, 
      x = ~METRIC,
      color = ~PERSON,
      type = 'bar', orientation = 'h',
      colors = colormap,
      hoverinfo = 'text',
      text = ~paste0(
        '</br>', PERSON,
        '</br> *Total #Movies: ',  METRIC,
        '</br> Best Grossing Movie: ', BEST_PICTURE
      )
    )%>%
      layout(xaxis = ax, yaxis = ay) -> thePlot
  }
  
  plot_ly(
    df,
    y = ~PERSON, 
    x = ~METRIC,
    color = ~PERSON,
    type = 'bar', orientation = 'h',
    colors = colormap,
    hoverinfo = 'text',
    text = ~paste0(
      '</br>', PERSON,
      '</br> $', METRIC,' MILLIONS',
      '</br> Best Grossing Movie: ', BEST_PICTURE
    )
  )%>%
    layout(xaxis = ax, yaxis = ay) -> thePlot
  
  rm(list = c("colormap","df","ax", "ay"))
  
  return(thePlot)
}






# =========================================================================
# @description: A barPlot showing release month frequencies for oscars moviews
# @param: oscars dataframe
# @return: plotly object for display
# =========================================================================
oscarsMonthsPloty <- function(data){
  data[, FULLDATE:= paste0(data[,RELEASEDATE],"/",data[, YEAR])]
  data[, MONTH:= months.Date(as.Date(FULLDATE, "%m/%d/%Y"))]
  table <- data[, .N, by = MONTH]
  # table[, MOVIES:= rep("", length(table$MONTH))]
  # names(table) <- c("month","oscars","movies")
  
  names(table) <- c("month","oscars")
  setorder(table, -oscars,month)
  
  # foreach(i= 1:length(table$month))%do%{
  #   movies <- data[MONTH %in% table$month[i]][,MOVIE]
  #   
  #   # foreach(j=1:length(movies), .combine = c)%do%{
  #   #   paste0("<li> ", movies[j], " </li> ")
  #   # } -> movies
  #   
  #   movies <- paste0(movies,collapse = ",")
  #   table$movies[i] <- movies; rm(movies)
  #   
  # }
  
  # rm(data)
  
  # set axis parameters
  ax <- list(
    title = "",
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = TRUE,
    showgrid = FALSE,
    tickangle = 0,
    tickfont = list(
      family = "Courier New, monospace",
      size = 15
    )
  )
  ay <- list(
    title = "Oscars (hover on bar for count)",
    titlefont= list(
      family = "Courier New, monospace",
      size = 15
    ),
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = FALSE,
    showgrid = FALSE

  )
  plot <- plot_ly(
    table,
    x=~month,
    y=~oscars,
    type="bar",
    hoverinfo = 'text',
    text = ~paste0(
      '</br> ', toupper(month),
      '</br> Total Count: ', oscars
    )
  ) %>% layout(xaxis=ax, yaxis=ay)
  rm(table);rm(data)
  return(plot)
}
