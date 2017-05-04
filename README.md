
# Oscars and Hollywood Box Office Explorer
<a href="https://ahmedtadde.shinyapps.io/hollywoodViz/" target="_blank">A Shiny Visualization Project</a>

------

## About
<a href="http://www.boxofficemojo.com/" target="_blank">Box Office Mojo</a> is an online movie publication and box office reporting service. The <a href="http://www.omdbapi.com/" target="_blank"> Open Movie Database</a> is a  free web service to obtain movie information, with all content and images contributed and maintained by self-volunteered users. 

The data from Box Office Mojo is parsed using the `XML` package and wrangled using the amazing R packages `dplyr` and `data.table`.  For details on the data collection and manipulation implementation, please refer to the `functions.R` file located in the github <a href="https://github.com/ahmedtadde/hollywoodViz" target="_blank">repository's</a> `data` folder. The data collection from The OMDBAPI is documented in the  `OMDB Critics Data.ipynb` ipython notebook also located in the github repository's `data` folder.



Throughout the application, the user is empowered with selection widgets to zoom in on data exploration of the dataset.  This application provides a layer of visualization that is otherwise masked behind tabular display of datasets.  Some examples of data insights with this application:

- * Compare different actors, producers and directors performances with regards to total grossing box office sales, best movies box office sales and total movies count.  Note that the metric for success here isn't a fixed rule of box office performances, so feel free to draw your own conclusions from the visualizations.*

- *Track the history of studios over the years, and see the rise and fall of a number of studios.  In particular, note that some studios have a prolific production of movies but they don't neccessarily top the box office rankings over the years.*

------

## Visualizations:
- **Studios:** This section displays visualizations of studio rankings by box office over time, as well as a plot of movies produced by studios over time. You can use the highlight filters to the left to highlight specific studios ranked in the legends.

- **Oscars:** This session shows the ranking list and visual clustering of oscars 'Best Picture' winning movies (1978-) by calculating an overall score and plotting prestige (critics & oscars performance score) against domestic box office. The so-called 'Oscars Season' is also visually illustrated. The o

- **Actors:** This section displays visualizations for the top 50 actors by box office numbers. You can use the highlight filters to the left to highlight specific actors ranked in the legends.

- **Directors:** This section displays visualizations for the top 50 directors by box office numbers. You can use the highlight filters to the left to highlight specific directors ranked in the legends.

- **Producers:** This section displays visualizations for the top 50 producers by box office numbers. You can use the highlight filters to the left to highlight specific producers ranked in the legends.

------

## Other notes:

- The `Prestige` index of each Oscars movie is calculated by: 


        * Calculating `critics performance` by taking the mean of its metascore and tomatometer.
  
        * Calculating `oscars performance` by adding its win percentage (#wins/#nominations) to 
          its nominations divided by 10. 
  
        * Finally, the `Prestige` index is calculated by taking the geometric mean of 
          the `critics performance` and `oscars performance` 
     

- The `Overall Score` index of each Oscars movie is calculated  by taking the geometric mean of its domestic `Box Office` and `Prestige` index.
     

- The engineered features `Prestige` and `Overall Score` are not gospel, obviously. They are subjective and simplistic; it could definitely be done differently or improved upon. Suggestions welcomed.

- Download the "cleaned" datasets for each tab from the `Data` section using the download buttons labeled 'CSV', 'EXCEL' found below the `Data` section header.

- This project is done with `plotly`, a rich library for data visualization that works tremendously well with organized data living in dataframes.

- This project/application is not affiliated with Box Office Mojo or the OMDB API.  The work is intended as a showcase of R Shiny data visualization capabilities.  All information courtesy of Box Office Mojo and OMDB API.

------

## Links
- <a href="https://ahmedtadde.github.io/DataQuest" target="_blank">Personal Page</a>
- <a href="https://www.linkedin.com/in/ahmedtadde" target="_blank">LinkedIn Profile</a>
- <a href="https://ahmedtadde.github.io/DataQuest/Projects" target="_blank">My Portfolio</a>
- <a href="https://github.com/ahmedtadde/hollywoodViz" target="_blank">Github Project Permalink</a>
- <a href="http://www.boxofficemojo.com/" target="_blank">Box Office Mojo</a>
- <a href="http://www.omdbapi.com/" target="_blank">The Open Movie Database</a>