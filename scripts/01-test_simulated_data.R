#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(tidyverse)

# Load the simulated data
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test simulated data ####

# Check if the dataset has 1000 rows (as specified in the simulation)
if (nrow(simulated_data) == 1000) {
  message("Test Passed: The dataset has 1000 rows.")
} else {
  stop("Test Failed: The dataset does not have 1000 rows.")
}

# Check if the dataset has 8 columns 
if (ncol(simulated_data) == 8) {
  message("Test Passed: The dataset has 8 columns.")
} else {
  stop("Test Failed: The dataset does not have 8 columns.")
}

# Check if the 'enforcement_proceedings' column contains only 'Yes' or 'No'
if (all(simulated_data$enforcement_proceedings %in% c("Yes", "No"))) {
  message("Test Passed: The 'enforcement_proceedings' column contains only 'Yes' or 'No'.")
} else {
  stop("Test Failed: The 'enforcement_proceedings' column contains invalid values.")
}

# Check if the 'property_type' column contains valid property types
valid_property_types <- c(
  "Detention", "Group Home", "Group Home (VO)", "High Rise",
  "Hospital", "Hotel & Motel", "Low Rise", "Nursing Home",
  "Residential Care", "Rooming House"
)

if (all(simulated_data$property_type %in% valid_property_types)) {
  message("Test Passed: The 'property_type' column contains valid property types.")
} else {
  stop("Test Failed: The 'property_type' column contains invalid property types.")
}

# Check if the 'property_ward' column contains valid ward numbers or NA
if (all(simulated_data$property_ward %in% c(1:25, NA))) {
  message("Test Passed: The 'property_ward' column contains valid ward numbers or NA.")
} else {
  stop("Test Failed: The 'property_ward' column contains invalid values.")
}

# Check if there are no missing values in essential columns: 'property_address', 'inspection_open_date', and 'inspection_closed_date'
if (all(!is.na(simulated_data$property_address)) & all(!is.na(simulated_data$inspection_open_date)) & all(!is.na(simulated_data$inspection_closed_date))) {
  message("Test Passed: No missing values in essential columns ('property_address', 'inspection_open_date', 'inspection_closed_date').")
} else {
  stop("Test Failed: Missing values found in essential columns.")
}

# Check if the 'violation_code' column contains valid codes or NA
if (all(simulated_data$violation_code %in% c(paste("Code", 1:20), NA))) {
  message("Test Passed: The 'violation_code' column contains valid codes or NA.")
} else {
  stop("Test Failed: The 'violation_code' column contains invalid values.")
}




