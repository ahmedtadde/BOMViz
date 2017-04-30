





# if(role %in% "" | peopleInput %in% ""){
#   # get data
#   df <- setorderv(copy(data), metricInput)[,MOVIE:=factor(MOVIE, levels = MOVIE, ordered = TRUE )]
#   df[, 
#      c("METRIC","PERFORMANCE") := list(
#        # factor(MOVIE, levels = MOVIE, ordered = TRUE ),
#        df[, get(metricInput)],
#        cut(df[, get(metricInput)], quantile(df[, get(metricInput)],(0:5)/5), ordered_result = TRUE, labels =  performanceLabels)
#      )
#      
#      ]
#   
#   
#   ax <- list(
#     title = paste0("Metric Value (", metricInput,")"),
#     titlefont= list(
#       family = "Courier New, monospace",
#       size = 15
#     ),
#     zeroline = FALSE,
#     showline = FALSE,
#     showticklabels = TRUE,
#     showgrid = FALSE,
#     tickangle = 0
#   )
#   ay <- list(
#     # title = "MOVIES",
#     # titlefont= list(
#     #   family = "Courier New, monospace",
#     #   size = 15
#     # ),
#     zeroline = FALSE,
#     showline = FALSE,
#     showticklabels = FALSE,
#     showgrid = FALSE
#     # tickfont = list(
#     #   family = "Courier New, monospace",
#     #   size = 10
#     # )
#     
#   )
#   
#   if(metricInput %in% "BOXOFFICE"){
#     
#     plot_ly(
#       df,
#       y = ~MOVIE, 
#       x = ~METRIC,
#       color = ~MOVIE,
#       type = 'bar', orientation = 'h',
#       colors = oscarsColorMapper(df[,get("MOVIE")], df[,get("PERFORMANCE")]),
#       hoverinfo = 'text',
#       text = ~paste0(
#         '</br>', MOVIE, 
#         '</br> Released in ', YEAR, ' by ', STUDIO,
#         '</br> It made $', METRIC,' MILLIONS at Box Office.',
#         '</br>', toupper(PERFORMANCE), ' performer amongst Oscars winning movies.'
#       )
#     )%>%layout(xaxis = ax, yaxis = ay, legend = list(x =-0.4, y=1.2)) -> thePlot
#     
#     rm(list = c("df","ax", "ay")) #"metricMeanValue"
#     
#     return(thePlot)
#     
#   }else if(metricInput %in% "WIN_PERCENTAGE"){
#     plot_ly(
#       df,
#       y = ~MOVIE, 
#       x = ~METRIC,
#       color = ~MOVIE,
#       type = 'bar', orientation = 'h',
#       colors = oscarsColorMapper(df[,get("MOVIE")], df[,get("PERFORMANCE")]),
#       hoverinfo = 'text',
#       text = ~paste0(
#         '</br>', MOVIE, 
#         '</br> Released in ', YEAR, ' by ', STUDIO,
#         '</br> It won ', WINS, ' out of ', NOMINATIONS, 
#         '</br> This represents a ', toupper(METRIC),' winning rate.',
#         '</br>', toupper(PERFORMANCE), ' performer amongst Oscars winning movies.'
#       )
#     )%>%layout(xaxis = ax, yaxis = ay) -> thePlot
#     
#     rm(list = c("df","ax", "ay")) #"metricMeanValue"
#     
#     return(thePlot)
#   }else{
#     
#     plot_ly(
#       df,
#       y = ~MOVIE, 
#       x = ~METRIC,
#       color = ~MOVIE,
#       type = 'bar', orientation = 'h',
#       colors = oscarsColorMapper(df[,get("MOVIE")], df[,get("PERFORMANCE")]),
#       hoverinfo = 'text',
#       text = ~paste0(
#         '</br>', MOVIE, 
#         '</br> Released in ', YEAR, ' by ', STUDIO,
#         '</br> It has ', METRIC, ifelse(metricInput %in% "NOMINATIONS", " nominations", " wins"),
#         '</br>', toupper(PERFORMANCE), ' performer amongst Oscars winning movies.'
#       )
#     )%>%layout(xaxis = ax, yaxis = ay) -> thePlot
#     
#     rm(list = c("df","ax", "ay")) #"metricMeanValue"
#     
#     return(thePlot)
#     
#   }
#   
# }
# 
