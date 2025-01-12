#code a for-loop to create separate folders for each county in Oklahoma

library(tidyverse)
library(tidycensus)
library(stringr)

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
library(dplyr)

dir <- "C:/Users/mttwh/OneDrive/Documents/R Projects/first/ok_counties"

# Extract unique values for each county "NAME" 
unique_values <- unique(ok_counties$NAME)

# Use for-loop to create subfolders for each unique value
for (value in unique_values) {
  dir.create(file.path(dir, as.character(value)))
}

