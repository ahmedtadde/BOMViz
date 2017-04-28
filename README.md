# Box Office Mojo Explorer
AWS EC2 Project <a href="http://shiny.vis.datanaut.io/BoxOfficeMojo/" target="_blank">here</a>

------

## About
<a href="http://www.boxofficemojo.com/" target="_blank">Box Office Mojo</a> is an online movie publication and box office reporting service.

The data is parsed using the `XML` package and reshaped using the amazing R package `dplyr`.  For more information on this data collection and cleaning implementation, please refer to the `parser.R` file for more details.

Throughout the application, the user is empowered with selection widgets to zoom in on data exploration of the dataset.  This site is designed with analysts in mind, and provides a layer of visualization that is otherwise masked behind tabular display of datasets.  Some examples of data insights with this application:

- *Learn how different actors, producers and directors have different performances with regards to total grossing box office sales, best movies box office sales and total movies produced.  Note that the metric for success here isn't a fixed rule of box office performances, so feel free to draw your own conclusions from the visualizations.*
- *Track the history of studios over the years, and see the rise and fall of a number of studios.  In particular, note that some studios have a prolific production of movies but they don't neccessarily top the box office rankings over the years.*

------

## Visualizations:
- **Studios:** This section displays visualizations of studio rankings by box office over time, as well as a facet plot of movies produced by studios over time. You can use the highlight filters to the left to highlight specific studios listed in the legends of the plots shown.
- **Oscars:** This section displays a timeline of Oscars winners. Select a metric (box office, Oscar Nominations, Oscar Wins, Oscar Nominations-Win ratio) to view the results with more details.
- **Actors:** This section displays visualizations of actors rankings by box office and movies acted. You can use the highlight filters to the left to highlight specific actors listed in the legends of the plots shown below.
- **Directors:** This section displays visualizations of directors rankings by box office and movies directred. You can use the highlight filters to the left to highlight specific directors listed in the legends of the plots shown below.
- **Producers:** This section displays visualizations of producers rankings by box office and movies produced. You can use the highlight filters to the left to highlight specific producers listed in the legends of the plots shown below.

------

## Other notes:
- Use the selection widgets to help highlight specific data subsets of interest, and to view a different visualization based on the selected metric report.

- Download the "cleaned" and filtered dataset for each tab from the `Data` section using the download button found next to the `Data` section header.

- This project is done with `ggplot`.  This is a rich library for data visualization and works tremendously well with organized data living in dataframes.

- This project/application is not affiliated with Box Office Mojo.  The work is intended as a showcase of R Shiny data visualization capabilities.  All information courtesy of Box Office Mojo. Used with permission.

------

## Resources
- <a href="http://chrisrzhou.datanaut.io/" target="_blank">Homepage</a>
- <a href="http://shiny.vis.datanaut.io/" target="_blank">R Shiny Projects</a>
- <a href="https://github.com/chrisrzhou/RShiny-BoxOfficeMojo" target="_blank">Github Project</a>
- <a href="http://www.boxofficemojo.com/" target="_blank">Box Office Mojo</a>
- <a href="http://www.imdb.com/" target="_blank">IMDB</a>