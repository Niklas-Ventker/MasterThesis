library(data.table)

# Load the functions from the specified file
source('/Users/niklas/Documents/GitHub/MasterThesis/HoltWinters/HoltWinters.R')


#################################################
# Only Datasets with Saisonal Characteristics!
# Dataset B - Energy Generation Solar
data_b <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv', skip = 1)$V1

# Define the parameters for testing
alpha <- 0.2
beta <- 0.1
gamma <- 0.3
season_length <- 24
expected_output_b <- 90.60914407238147

# Initialize counters
passed_tests <- 0
failed_tests <- 0

# Define the test functions
test_triple_exponential_smoothing_basic_dataset_b <- function() {
  smoothed <- triple_exponential_smoothing_basic(data_b, alpha, beta, gamma, season_length)
  last_smoothed_value <- tail(smoothed, 1)
  if (abs(last_smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_triple_exponential_smoothing_basic_dataset_B: PASSED\n")
    return(TRUE)
  } else {
    cat("test_triple_exponential_smoothing_basic_dataset_B: FAILED\n")
    return(FALSE)
  }
}

test_triple_exponential_smoothing_vectorized_dataset_b <- function() {
  smoothed <- triple_exponential_smoothing_vectorized(data_b, alpha, beta, gamma, season_length)
  last_smoothed_value <- tail(smoothed, 1)
  if (abs(last_smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_triple_exponential_smoothing_vectorized_dataset_B: PASSED\n")
    return(TRUE)
  } else {
    cat("test_triple_exponential_smoothing_vectorized_dataset_B: FAILED\n")
    return(FALSE)
  }
}

test_triple_exponential_smoothing_basic_parallelized_dataset_b <- function() {
  smoothed <- triple_exponential_smoothing_basic_parallelized(data_b, alpha, beta, gamma, season_length)
  last_smoothed_value <- tail(smoothed, 1)
  if (abs(last_smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_triple_exponential_smoothing_basic_parallelized_dataset_B: PASSED\n")
    return(TRUE)
  } else {
    cat("test_triple_exponential_smoothing_basic_parallelized_dataset_B: FAILED\n")
    return(FALSE)
  }
}

test_triple_exponential_smoothing_vectorized_parallelized_dataset_b <- function() {
  smoothed <- triple_exponential_smoothing_vectorized_parallelized(data_b, alpha, beta, gamma, season_length)
  last_smoothed_value <- tail(smoothed, 1)
  if (abs(last_smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_triple_exponential_smoothing_vectorized_parallelized_dataset_B: PASSED\n")
    return(TRUE)
  } else {
    cat("test_triple_exponential_smoothing_vectorized_parallelized_dataset_B: FAILED\n")
    return(FALSE)
  }
}

# Run the tests and count the results
tests <- list(
  test_triple_exponential_smoothing_basic_dataset_b,
  test_triple_exponential_smoothing_vectorized_dataset_b,
  test_triple_exponential_smoothing_basic_parallelized_dataset_b,
  test_triple_exponential_smoothing_vectorized_parallelized_dataset_b
)

for (test in tests) {
  if (test()) {
    passed_tests <- passed_tests + 1
  } else {
    failed_tests <- failed_tests + 1
  }
}

cat("Total tests passed:", passed_tests, "\n")
cat("Total tests failed:", failed_tests, "\n")
