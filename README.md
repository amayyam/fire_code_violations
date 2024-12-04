# Highrise Residential Fire Inspections

## Overview

This project is focused on analyzing the duration of fire inspections for different types of properties using a dataset from Open Data Toronto. We aim to build a predictive model to estimate the inspection duration based on various property attributes and enforcement proceedings.

The dataset contains detailed records of properties, inspections, violations, and other relevant attributes, such as the type of property and enforcement proceedings. Our goal is to identify key predictors of inspection duration and develop a model that can provide accurate predictions.


## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated data used for validating analysis methods.
-   `data/01-raw_data` contains the raw data as obtained from Open Data Toronto.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant details about LLM chat interactions and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Reproducing the Paper

To reproduce the paper and run the analysis, follow these steps:

- Clone or download the Repository
- To download the data, go to `scripts` and run `02-download_data.R` to download the raw data files. 
- To clean the data, go to the `scripts` and run `03-clean_data.R` to process the raw data into a panel dataset suitable for analysis.
- To test the data, go to the `scripts` and run `04-test_analysis_data.R` to verify that the data meets the necessary specifications for the analysis.
- To render the paper, open the Quarto document located in the `paper/paper.qmd` folder and render the document to generate the PDF file.

## License

This project is licensed under the MIT License.

## Statement on LLM usage

Some code for data analysis and sentence phrasings had assistance from ChatGPT 4.0. The prompts and outputs were documented along with the entire chat history in other/llm/usage.txt.

