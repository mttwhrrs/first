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

#create a sub-folder for ok_counties

# Get the current working directory
current_directory <- getwd()
# Print the current working directory
print(current_directory)


# Define the path where you want to create the new subfolder
main_directory <- "C:/Users/mttwh/OneDrive/Documents/R Projects/first"
new_subfolder <- "ok_counties"

# Combine the main directory path with the new subfolder name
full_path <- file.path(main_directory, new_subfolder)

# Create the new subfolder
dir.create(full_path)

# Print a message to confirm creation
if (dir.exists(full_path)) {
  cat("Subfolder created successfully at:", full_path, "\n")
} else {
  cat("Failed to create subfolder at:", full_path, "\n")
}

