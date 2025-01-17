#code a for-loop to create separate folders for each county in Oklahoma
library(tidyverse)
library(tidycensus)
library(dplyr)

#create object by getting county level data for Oklahoma
ok <- get_acs(
geography = "county",
state = "OK",
variables = "B19013_001",
year = 2020,
)

#create counties object by selecting NAME to remove other variables
ok_counties <- ok |>
select(NAME)

#remove "County, Oklahoma" text from every value
ok_counties$NAME <- gsub(" County, Oklahoma", "", ok_counties$NAME)

#create a sub-folder for ok_counties
# Get the current working directory
getwd()
main_directory <- "C:/Users/mttwh/OneDrive/Documents/R Projects/first"
new_subfolder <- "ok_counties"
full_path <- file.path(main_directory, new_subfolder)

# Create the new subfolder
dir.create(full_path)

#dir.create(file.path("C:/Users/mttwh/OneDrive/Documents/R Projects/first", ok_counties))
#create sub-folders for every county in Oklahoma
dir <- "C:/Users/mttwh/OneDrive/Documents/R Projects/first/ok_counties"

# Extract unique values for each county "NAME" 
unique_values <- unique(ok_counties$NAME)

# Use for-loop to create subfolders for each unique value
for (value in unique_values) {
  dir.create(file.path(dir, as.character(value)))
}


###############################################################################

#explore tidycensus, make maps of housing in Oakland 

dpvars <- load_variables(2020, "dp")

oakland_housing <- get_decennial(
  geography = "tract",
  variables = c("DP1_0147C", "DP1_0158C"),
  state = "CA",
  place = "Oakland",
  geometry = TRUE,
  sumfile = "dp",
  year = 2020,
  output = "wide"
)

sum_th <- sum(oakland_housing$DP1_0147C)
sum_oh <- sum(oakland_housing$DP1_0158C)

unoccupied <- sum_th - sum_oh

unoccupied/sum_th

sum_oakland <- oakland_housing |>
  mutate(total_housing = sum("DP1_0147C"),
         occupied_housing = sum("DP1_0158C")) |>
  select(NAME, percent, total_housing, occupied_housing)

un_oakland <- oakland_housing |>
  mutate(unoccupied = DP1_0147C - DP1_0158C)


occupied_percent <- oakland_housing |>
  mutate(percent = 100 * (DP1_0158C / DP1_0147C)) |> 
  select(GEOID, NAME, percent, geometry) 


mapview(occupied_percent, zcol = "percent")

mapview(occupied_percent, zcol = "percent",
        at = c(60, 70, 80, 90, 100))

unoccupied_dots <- as_dot_density(
  un_oakland,
  value = "unoccupied",
  values_per_dot = 10
)

mapview(unoccupied_dots, cex = 0.0001, layer.name = "Unoccupied Oakland<br>1 dot = 1 unoccupied house",
        col.regions = "navy", color = "navy")


total_housing = "DP1_0147C"
occupied_housing = "DP1_0158C"





