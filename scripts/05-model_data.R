#### Preamble ####
# Purpose: Models inspection duration as a function of other factors.
# Author: Maryam Ansari
# Date: 26 November 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: Analysis data should be downloaded and saved.
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
library(randomForest)
library(caret)
library(ggplot2)

# Load the analysis data
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Split the data into training (80%) and testing (20%) sets
set.seed(853)
train_index <- createDataPartition(analysis_data$inspection_duration, p = 0.8, list = FALSE)
train_data <- analysis_data[train_index, ]
test_data <- analysis_data[-train_index, ]

# Ensure categorical variables are factors
train_data$enforcement_proceedings <- as.factor(train_data$enforcement_proceedings)
train_data$property_type <- as.factor(train_data$property_type)

test_data$enforcement_proceedings <- as.factor(test_data$enforcement_proceedings)
test_data$property_type <- as.factor(test_data$property_type)

# Fit the Random Forest model
rf_model <- randomForest(inspection_duration ~ enforcement_proceedings + property_type + property_ward,
                         data = train_data, 
                         ntree = 500,  # Number of trees
                         mtry = 3,     # Number of variables to consider at each split
                         importance = TRUE)

# Make predictions on the test set
test_preds <- predict(rf_model, test_data)

# Calculate RMSE and R-squared for evaluation
test_rmse <- sqrt(mean((test_preds - test_data$inspection_duration)^2))
r_squared <- 1 - sum((test_preds - test_data$inspection_duration)^2) / sum((mean(test_data$inspection_duration) - test_data$inspection_duration)^2)

# Print results
cat("Test RMSE (original scale): ", test_rmse, "\n")
cat("R-squared (test set): ", r_squared, "\n")

# Feature importance
feature_importance <- data.frame(
  Feature = rownames(importance(rf_model)),
  Importance = importance(rf_model)[, 1]
)
print(feature_importance)

# Plot residuals
residuals <- test_preds - test_data$inspection_duration
ggplot(data = data.frame(residuals), aes(x = residuals)) +
  geom_histogram(bins = 30, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Residuals Histogram", x = "Residuals", y = "Frequency")

# Save the model
saveRDS(rf_model, "models/final_model.rds")






