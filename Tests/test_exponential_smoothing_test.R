library(testthat)

source("/Users/niklas/Documents/GitHub/MasterThesis/BasicExponentialSmoothing/ExpS_R.R")

# Load the dataset
data_a <- read.csv("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv")
alpha <- 0.7
number_of_executions <- 10
expected_output_a <- 9.729056156830051

test_that("test_exponential_smoothing_basic_dataset_A", {
  result <- exponential_smoothing_basic(data_a, alpha, number_of_executions)
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  expect_equal(smoothed_value, expected_output_a, tolerance = 0.0000000005)
  expect_true(function_time > 0)
})

test_that("test_exponential_smoothing_vectorized_dataset_A", {
  result <- exponential_smoothing_vectorized(data_a, alpha, number_of_executions)
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  expect_equal(smoothed_value, expected_output_a, tolerance = 0.0000000005)
  expect_true(function_time > 0)
})

test_that("Basic arithmetic works", {
  expect_equal(1 + 1, 2)
  expect_true(2 * 2 == 4)
})