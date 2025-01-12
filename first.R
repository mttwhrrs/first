#code for loop to create separate files for each county in Oklahoma

#create object

ok <- get_acs(
geography = "county",
state = "OK",
variables = "B19013_001",
year = 2020,
)

ok_counties <- ok |>
select(GEOID, NAME)

ok_counties
