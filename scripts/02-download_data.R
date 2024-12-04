#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Maryam Ansari
# Date: 26 November 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

all_data <- read_csv("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/f816b362-778a-4480-b9ed-9b240e0fe9c2/resource/98fddf20-5c46-49fc-a1b4-eadd1877acec/download/Highrise%20Inspections%20Data.csv")

write_csv(all_data, "data/01-raw_data/raw_data.csv")
         
