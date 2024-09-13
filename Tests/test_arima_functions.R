library(testthat)

# Load the necessary functions
source("arima_functions.R")

test_arima_autoregressive_component <- function() {
  # Load the dataset
  data <- read.csv("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", header = TRUE)
  data <- as.numeric(data[,1])  # Assuming the data is in the first column
  
  # Define test inputs
  lags <- 2
  vector <- c(0.9208, -0.0111, 0.0766)
  
  # Expected output
  expected_output <- 8.42711736
  
  # Run the function
  result <- autoregressive_component(data, lags, vector)
  last_result <- tail(result, 1)
  
  # Check if the result is as expected
  expect_equal(last_result, expected_output, tolerance = 1e-10)
}

test_arima_integrated_component <- function() {
  # Load the dataset
  data <- read.csv("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", header = TRUE)
  data <- as.numeric(data[,1])  # Assuming the data is in the first column
  
  # Define test inputs
  order <- 1
  
  # Expected output
  # (You need to define the expected output based on your data and order)
  
  # Run the function
  result <- integrated_component(data, order)
  
  # Check if the result is as expected
  # (You need to define the expected output based on your data and order)
  expect_true(TRUE)
}

test_arima_movingaverage_component <- function() {
  # Define test inputs
  original_data <- c(1, 2, 3, 4, 5)
  forecast_data <- c(1, 2, 3, 4, 5)
  order <- 2
  theta <- c(0.5, 0.3)
  
  # Expected output
  # (You need to define the expected output based on your data and parameters)
  
  # Run the function
  result <- moving_average_component(original_data, forecast_data, order, theta)
  
  # Check if the result is as expected
  # (You need to define the expected output based on your data and parameters)
  expect_true(TRUE)
}

# Run the tests
test_arima_autoregressive_component()
test_arima_integrated_component()
test_arima_movingaverage_component()
