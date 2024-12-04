#### Preamble ####
# Purpose: Simulates a dataset similar to the High rise Fire Inspection Results dataset.
# Author: Maryam Ansari
# Date: 26 November 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed.
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(tidyverse)
set.seed(853)

#### Simulate data ####
# Property types
property_types <- c(
  "Detention", "Group Home", "Group Home (VO)", "High Rise",
  "Hospital", "Hotel & Motel", "Low Rise", "Nursing Home",
  "Residential Care", "Rooming House"
)

# Create a dataset
simulated_data <- tibble(
  id = 1:1000,  # Simulate 1000 rows
  property_address = paste("Address", 1:1000),  # Simulated addresses
  enforcement_proceedings = sample(
    c("Yes", "No"),
    size = 1000,
    replace = TRUE,
    prob = c(0.3, 0.7) # Assume 30% have enforcement proceedings
  ),
  property_type = sample(
    property_types,
    size = 1000,
    replace = TRUE,
    prob = c(0.05, 0.1, 0.1, 0.3, 0.05, 0.05, 0.2, 0.05, 0.05, 0.05) # Rough distribution
  ),
  property_ward = sample(
    c(1:25, NA),  # Include a small proportion of blanks (NA)
    size = 1000,
    replace = TRUE,
    prob = c(rep(0.04, 25), 0.04)
  ),
  inspection_open_date = sample(
    seq(as.Date("2020-01-01"), as.Date("2023-01-01"), by = "day"),
    size = 1000,
    replace = TRUE
  ),
  inspection_closed_date = as.Date(NA),  # Initialize as NA
  violation_code = sample(
    c(paste("Code", 1:20), NA),  # Include some blank values
    size = 1000,
    replace = TRUE,
    prob = c(rep(0.045, 20), 0.1)
  )
)

# Ensure the inspection_closed_date is after the inspection_open_date
simulated_data <- simulated_data %>%
  mutate(
    inspection_closed_date = inspection_open_date + sample(0:100, size = n(), replace = TRUE)  # Inspection close is after open date, within 100 days
  )

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

