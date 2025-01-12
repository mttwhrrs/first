#code a for-loop to create separate folders for each county in Oklahoma

library(tidyverse)
library(tidycensus)

#create object by getting county level data for Oklahoma

ok <- get_acs(
geography = "county",
state = "OK",
variables = "B19013_001",
year = 2020,
)

#create counties object by selecting NAME to remove other variables

ok_counties <- ok |>
select(GEOID, NAME)

ok_counties


