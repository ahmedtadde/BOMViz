# =========================================================================
# Load libraries and scripts
# =========================================================================
source('data/functions.R')
libraries()


# =========================================================================
# GET parsed data from parser.R script into dataframes
# =========================================================================
dataframes <- list(
  studios = get_data_studios(),
  oscars = get_data_oscars(),
  actors = get_data_actors(),
  directors = get_data_directors(),
  producers = get_data_producers()
)


# =========================================================================
# ui.R variables
# =========================================================================
choices <- list(
    studios = unique(dataframes$studios$STUDIO),
    oscars_years = unique(dataframes$oscars$YEAR),
    studios_years = unique(dataframes$studios$YEAR),
    
    actors = unique(dataframes$actors$PERSON),
    directors = unique(dataframes$directors$PERSON),
    producers = unique(dataframes$producers$PERSON),
    oscars_metric = c("BOXOFFICE", "NOMINATIONS", "WINS", "WIN_PERCENTAGE")
)


# =========================================================================
# server.R variables and functions
# =========================================================================
peopleSelectionColors <- c("#ff9800","#72142e","#0f2a56")
movieMetricInputLabels <- c("Highest Grossing Movie"="BEST_BO", "Total Box Office"="TOTAL_BO", "Average Gross per Movie"="AVERAGE_BO", "Total Movie Count"="MOVIES_COUNT")

