#### Preamble ####
# Purpose: Tests downloaded data.
# Author: Maryam Ansari
# Date: 26 November 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: Raw data should be filtered and processed.
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

#### Test data ####

# Define valid property types
valid_property_types <- c(
  "Detention", "Group Home", "Group Home (VO)", "High Rise",
  "Hospital", "Hotel & Motel", "Low Rise", "Nursing Home",
  "Residential Care", "Rooming House"
)

test_that("dataset has 13 columns", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_equal(ncol(data), 13)
})

test_that("'id' is numeric", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(is.numeric(data$id))
})

test_that("'property_address' is character", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(is.character(data$property_address))
})

test_that("'enforcement_proceedings' is character and contains valid values", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(is.character(data$enforcement_proceedings))
  expect_true(all(data$enforcement_proceedings %in% c("Yes", "No")))
})

test_that("'property_type' is character and contains valid values", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(is.character(data$property_type))
  expect_true(all(data$property_type %in% valid_property_types))
})

test_that("'property_ward' is numeric or NA", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(all(is.numeric(data$property_ward) | is.na(data$property_ward)))
})

test_that("'inspection_open_date' is Date", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(inherits(data$inspection_open_date, "Date"))
})

test_that("'inspection_closed_date' is Date and after 'inspection_open_date'", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(inherits(data$inspection_closed_date, "Date"))
  expect_true(all(data$inspection_closed_date >= data$inspection_open_date, na.rm = TRUE))
})

test_that("'violation_code' is character and contains valid codes or NA", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(is.character(data$violation_code))
  expect_true(all(data$violation_code %in% c(paste("Code", 1:20), NA)))
})

test_that("no missing values in dataset", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(all(!is.na(data)))
})

test_that("no empty strings in 'property_address', 'enforcement_proceedings', and 'property_type'", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(all(data$property_address != ""))
  expect_true(all(data$enforcement_proceedings != ""))
  expect_true(all(data$property_type != ""))
})

test_that("'enforcement_proceedings' column contains at least 2 unique values", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(length(unique(data$enforcement_proceedings)) >= 2)
})

test_that("'property_ward' contains NA but no other missing values", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_true(any(is.na(data$property_ward)))
  expect_true(all(!is.na(data$property_address)))
})

test_that("no duplicate 'id' values", {
  data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
  expect_equal(length(unique(data$id)), nrow(data))
})



