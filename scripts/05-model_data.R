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
library(arrow)
library(caret)  # For model evaluation
library(car)    # For Variance Inflation Factor (VIF)

# Load analysis data from Parquet file
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Data Preparation ####
# Convert categorical variables into factors
data$enforcement_proceedings <- as.factor(data$enforcement_proceedings)
data$property_type <- as.factor(data$property_type)

# Create a new column for the 'inspection_duration' (days between open and closed dates)
data$inspection_duration <- as.numeric(difftime(data$inspection_closed_date, 
                                                data$inspection_open_date, 
                                                units = "days"))

#### Split data into training and testing sets ####
set.seed(123)  # For reproducibility
train_index <- createDataPartition(data$id, p = 0.8, list = FALSE)  # 80% train, 20% test
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

#### Model Fitting ####
# Fit a multiple linear regression model
model <- lm(inspection_duration ~ enforcement_proceedings + property_type + 
              property_ward, data = train_data)

# Print model summary
summary(model)

#### Model Evaluation ####
# Make predictions on the test set
predictions <- predict(model, newdata = test_data)

# Evaluate model performance
# RMSE
rmse <- sqrt(mean((predictions - test_data$inspection_duration)^2))
cat("RMSE: ", rmse, "\n")

# R-squared
rsq <- summary(model)$r.squared
cat("R-squared: ", rsq, "\n")

#### Model Diagnostics ####

# Residuals vs Fitted values plot
plot(model, which = 1)  # Residuals vs Fitted plot

# Normal Q-Q plot to check for normality of residuals
plot(model, which = 2)  # Q-Q plot

# Scale-Location plot (Spread-Location plot) to check homoscedasticity
plot(model, which = 3)  # Scale-Location plot

# Cook's distance plot to check for influential points
plot(model, which = 4)  # Cook's Distance plot

# AIC and BIC for the model
cat("AIC: ", AIC(model), "\n")
cat("BIC: ", BIC(model), "\n")

# Check for multicollinearity using Variance Inflation Factor (VIF)
vif(model)

#### Feature Importance ####
# Check variable importance using caret
train_control <- trainControl(method = "cv", number = 10)
model_caret <- train(inspection_duration ~ enforcement_proceedings + property_type + 
                       property_ward, 
                     data = train_data, 
                     method = "lm", 
                     trControl = train_control)

# Display variable importance
print(varImp(model_caret))

#### Final Model Evaluation ####
# Test predictions vs actuals on test data
comparison <- data.frame(Actual = test_data$inspection_duration, Predicted = predictions)
head(comparison)

#### Save Model ####
# Save model as first_model.rds (add this as a final step)
saveRDS(model, "models/first_model.rds")
cat("Model saved as 'first_model.rds'.\n")




