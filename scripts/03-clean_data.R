### Preamble ####
# Purpose: Cleans the data.
# Author: Maryam Ansari
# Date: 26 November 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: Raw data should be downloaded.
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
library(janitor)  
library(lubridate)
library(arrow)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>  # Standardize column names (e.g., INSPECTIONS_OPENDATE -> inspections_opendate)
  mutate(
    inspection_open_date = as.Date(inspections_opendate, format = "%Y-%m-%d"),
    inspection_closed_date = as.Date(inspections_closeddate, format = "%Y-%m-%d"),
    inspection_duration = as.numeric(difftime(inspection_closed_date, inspection_open_date, units = "days")),
    enforcement_proceedings = tolower(enforcement_proceedings),
    property_ward = as.numeric(raw_data$propertyWard),
    violations_item_number = as.numeric(violations_item_number)
  ) |>
  filter(!is.na(property_ward)) |>  # Removes rows with missing property ward
  tidyr::drop_na()

#### Save data ####
write_parquet(cleaned_data, 
              "data/02-analysis_data/analysis_data.parquet")

