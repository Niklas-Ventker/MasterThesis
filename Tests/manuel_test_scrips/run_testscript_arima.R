library(data.table)

# Load the functions from the specified file
source('/Users/niklas/Documents/GitHub/MasterThesis/Arima/arima_functions.R')

# Load the datasets
# data_a <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', skip = 1)$V1
# data_b <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv', skip = 1)$V1
# data_c <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv', skip = 1)$V1
# data_d <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv', skip = 1)$V1
# data_e <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv', skip = 1)$V1
# data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv', skip = 1)$V1

# data_a <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv', skip = 0)$V1
# data_b <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv', skip = 0)$V1
# data_c <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv', skip = 0)$V1
# data_d <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv', skip = 0)$V1
data_e <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv', skip = 0)$V1
#data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv', skip = 0)$V1

# Define the parameters for testing
lags <- 2
vector <- c(0.9208, -0.0111, 0.0766)
#vector <- c(0.1, 0.1, 0.1)
order <- 1
theta <- c(0.3, 0.3)

# Expected outputs
expected_output_ar_a <- 8.42711736
expected_output_integrated_a <- 0.55796623
expected_output_ma_a <- 8.25047461
expected_output_complete_a <- 3.059677

expected_output_ar_b <- 33.09027077
expected_output_integrated_b <- 1.23456789
expected_output_ma_b <- 33.56789012
expected_output_complete_b <- 61.78846

expected_output_ar_c <- 98.77752695
expected_output_integrated_c <- 2.34567890
expected_output_ma_c <- 99.12345678
expected_output_complete_c <- -6.16423

expected_output_complete_d <- -1.066503

expected_output_complete_e <- 6.920413

expected_output_complete_f <- 1143.753


# Initialize counters
passed_tests <- 0
failed_tests <- 0

#################################################
# Define the test functions for data_a
test_arima_autoregressive_component_basic_dataset_a <- function() {
  result <- autoregressive_component_basic(data_a, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_a) < 0.00005) {
    cat("test_arima_autoregressive_component_basic_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_basic_dataset_a: FAILED\n")
    return(FALSE)
  }
}

test_arima_autoregressive_component_vectorized_dataset_a <- function() {
  result <- autoregressive_component_vectorized(data_a, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_a) < 0.00005) {
    cat("test_arima_autoregressive_component_vectorized_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_vectorized_dataset_a: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_basic_dataset_a <- function() {
  result <- integrated_component_basic(data_a, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_a) < 0.00005) {
    cat("test_arima_integrated_component_basic_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_basic_dataset_a: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_vectorized_dataset_a <- function() {
  result <- integrated_component_vectorized(data_a, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_a) < 0.00005) {
    cat("test_arima_integrated_component_vectorized_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_vectorized_dataset_a: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_basic_dataset_a <- function() {
  forecast_data <- autoregressive_component_basic(data_a, lags, vector)
  result <- moving_average_component_basic(data_a[(lags + 1):length(data_a)], forecast_data, lags, theta)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ma_a) < 0.0000000005) {
    cat("test_arima_moving_average_component_basic_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_basic_dataset_a: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_vectorized_dataset_a <- function() {
  forecast_data <- autoregressive_component_vectorized(data_a, lags, vector)
  result <- moving_average_component_vectorized(data_a[(lags + 1):length(data_a)], forecast_data, lags, theta)
  last_result_a <- tail(result, 1)
  if (abs(last_result_a - expected_output_ma_a) < 0.00005) {
    cat("test_arima_moving_average_component_vectorized_dataset_a: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_vectorized_dataset_a: FAILED\n")
    return(FALSE)
  }
}


##### COMPLETE 
test_arima_complete_basic_dataset_a <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_a, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_a <- tail(result, 1)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_a - expected_output_complete_a) < 0.00005) {
    cat("test_arima_complete_basic_dataset_a: PASSED: ")
    cat(last_result_a)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_a: FAILED\n")
    cat(last_result_a)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_a <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_a, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_a <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_a)
  if (abs(last_result_a - expected_output_complete_a) < 0.00005) {
    cat("test_arima_complete_vectorized_dataset_a: PASSED: ")
    cat(last_result_a)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_a: FAILED\n")
    cat(last_result_a)
    return(FALSE)
  }
}

#################################################
# Define the test functions for data_b
test_arima_autoregressive_component_basic_dataset_b <- function() {
  result <- autoregressive_component_basic(data_b, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_b) < 0.00005) {
    cat("test_arima_autoregressive_component_basic_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_basic_dataset_b: FAILED\n")
    return(FALSE)
  }
}

test_arima_autoregressive_component_vectorized_dataset_b <- function() {
  result <- autoregressive_component_vectorized(data_b, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_b) < 0.00005) {
    cat("test_arima_autoregressive_component_vectorized_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_vectorized_dataset_b: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_basic_dataset_b <- function() {
  result <- integrated_component_basic(data_b, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_b) < 0.00005) {
    cat("test_arima_integrated_component_basic_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_basic_dataset_b: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_vectorized_dataset_b <- function() {
  result <- integrated_component_vectorized(data_b, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_b) < 0.00005) {
    cat("test_arima_integrated_component_vectorized_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_vectorized_dataset_b: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_basic_dataset_b <- function() {
  forecast_data <- autoregressive_component_basic(data_b, lags, vector)
  result <- moving_average_component_basic(data_b[(lags + 1):length(data_b)], forecast_data, lags, theta)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ma_b) < 0.0000000005) {
    cat("test_arima_moving_average_component_basic_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_basic_dataset_b: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_vectorized_dataset_b <- function() {
  forecast_data <- autoregressive_component_vectorized(data_b, lags, vector)
  result <- moving_average_component_vectorized(data_b[(lags + 1):length(data_b)], forecast_data, lags, theta)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ma_b) < 0.0000000005) {
    cat("test_arima_moving_average_component_vectorized_dataset_b: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_vectorized_dataset_b: FAILED\n")
    return(FALSE)
  }
}

##### COMPLETE 
test_arima_complete_basic_dataset_b <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_b, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_b <- tail(result, 1)
  print(last_result_b)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_b - expected_output_complete_b) < 0.00005) {
    cat("test_arima_complete_basic_dataset_b: PASSED: ")
    cat(last_result_b)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_b: FAILED\n")
    cat(last_result_b)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_b <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_b, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_b <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_b)
  if (abs(last_result_b - expected_output_complete_b) < 0.00005) {
    cat("test_arima_complete_vectorized_dataset_b: PASSED: ")
    cat(last_result_b)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_b: FAILED\n")
    cat(last_result_b)
    return(FALSE)
  }
}


#################################################
# Define the test functions for data_c
test_arima_autoregressive_component_basic_dataset_c <- function() {
  result <- autoregressive_component_basic(data_c, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_c) < 0.00005) {
    cat("test_arima_autoregressive_component_basic_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_basic_dataset_c: FAILED\n")
    return(FALSE)
  }
}

test_arima_autoregressive_component_vectorized_dataset_c <- function() {
  result <- autoregressive_component_vectorized(data_c, lags, vector)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ar_c) < 0.00005) {
    cat("test_arima_autoregressive_component_vectorized_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_autoregressive_component_vectorized_dataset_c: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_basic_dataset_c <- function() {
  result <- integrated_component_basic(data_c, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_c) < 0.00005) {
    cat("test_arima_integrated_component_basic_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_basic_dataset_c: FAILED\n")
    return(FALSE)
  }
}

test_arima_integrated_component_vectorized_dataset_c <- function() {
  result <- integrated_component_vectorized(data_c, order)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_integrated_c) < 0.00005) {
    cat("test_arima_integrated_component_vectorized_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_integrated_component_vectorized_dataset_c: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_basic_dataset_c <- function() {
  forecast_data <- autoregressive_component_basic(data_c, lags, vector)
  result <- moving_average_component_basic(data_c[(lags + 1):length(data_c)], forecast_data, lags, theta)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ma_c) < 0.0000000005) {
    cat("test_arima_moving_average_component_basic_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_basic_dataset_c: FAILED\n")
    return(FALSE)
  }
}

test_arima_moving_average_component_vectorized_dataset_c <- function() {
  forecast_data <- autoregressive_component_vectorized(data_c, lags, vector)
  result <- moving_average_component_vectorized(data_c[(lags + 1):length(data_c)], forecast_data, lags, theta)
  last_result <- tail(result, 1)
  if (abs(last_result - expected_output_ma_c) < 0.0000000005) {
    cat("test_arima_moving_average_component_vectorized_dataset_c: PASSED\n")
    return(TRUE)
  } else {
    cat("test_arima_moving_average_component_vectorized_dataset_c: FAILED\n")
    return(FALSE)
  }
}

##### COMPLETE 
test_arima_complete_basic_dataset_c <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_c, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_c <- tail(result, 1)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_c - expected_output_complete_c) < 0.00005) {
    cat("test_arima_complete_basic_dataset_c: PASSED: ")
    cat(last_result_c)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_c: FAILED\n")
    cat(last_result_c)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_c <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_c, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_c <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_c)
  if (abs(last_result_c - expected_output_complete_c) < 0.00005) {
    cat("test_arima_complete_vectorized_dataset_c: PASSED: ")
    cat(last_result_c)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_c: FAILED\n")
    cat(last_result_c)
    return(FALSE)
  }
}

#################################################
# Dataset D

##### COMPLETE 
test_arima_complete_basic_dataset_d <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_d, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_d <- tail(result, 1)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_d - expected_output_complete_d) < 0.00005) {
    cat("test_arima_complete_basic_dataset_d: PASSED: ")
    cat(last_result_d)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_d: FAILED\n")
    cat(last_result_d)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_d <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_d, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_d <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_d)
  if (abs(last_result_d - expected_output_complete_d) < 0.00005) {
    cat("test_arima_complete_vectorized_dataset_d: PASSED: ")
    cat(last_result_d)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_d: FAILED\n")
    cat(last_result_d)
    return(FALSE)
  }
}

#################################################
# Dataset E

##### COMPLETE 
test_arima_complete_basic_dataset_e <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_e, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_e <- tail(result, 1)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_e - expected_output_complete_e) < 0.00005) {
    cat("test_arima_complete_basic_dataset_e: PASSED: ")
    cat(last_result_e)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_e: FAILED\n")
    cat(last_result_e)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_e <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_e, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_e <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_e)
  if (abs(last_result_e - expected_output_complete_e) < 0.00005) {
    cat("test_arima_complete_vectorized_dataset_e: PASSED: ")
    cat(last_result_e)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_e: FAILED\n")
    cat(last_result_e)
    return(FALSE)
  }
}

#################################################
# Dataset F

##### COMPLETE 
test_arima_complete_basic_dataset_f <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_basic(data_f, order)
  forecast_data <- autoregressive_component_basic(integrated_data, lags, vector)
  result <- moving_average_component_basic(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- tail(result, 1)
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  if (abs(last_result_f - expected_output_complete_f) < 0.005) {
    cat("test_arima_complete_basic_dataset_f: PASSED: ")
    cat(last_result_f)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_basic_dataset_f: FAILED\n")
    cat(last_result_f)
    return(FALSE)
  }
}

test_arima_complete_vectorized_dataset_f <- function() {
  start_time <- Sys.time()
  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- result[nrow(result), ncol(result)]
  end_time <- Sys.time()
  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  print(last_result_f)
  if (abs(last_result_f - expected_output_complete_f) < 0.005) {
    cat("test_arima_complete_vectorized_dataset_f: PASSED: ")
    cat(last_result_f)
    cat("\nexecution time:")
    cat(execution_time)
    cat("\n")
    return(TRUE)
  } else {
    cat("test_arima_complete_vectorized_dataset_f: FAILED\n")
    cat(last_result_f)
    return(FALSE)
  }
}


# Run the tests and count the results
tests <- list(
  # Dataset A
  # test_arima_autoregressive_component_basic_dataset_a,
  # test_arima_autoregressive_component_vectorized_dataset_a,
  # test_arima_integrated_component_basic_dataset_a,
  # test_arima_integrated_component_vectorized_dataset_a,
  # test_arima_moving_average_component_basic_dataset_a,
  # test_arima_moving_average_component_vectorized_dataset_a,
  # test_arima_complete_basic_dataset_a,
  # test_arima_complete_vectorized_dataset_a,

  # # Dataset B 
  # # test_arima_autoregressive_component_basic_dataset_b,
  # # test_arima_autoregressive_component_vectorized_dataset_b,
  # # test_arima_integrated_component_basic_dataset_b,
  # # test_arima_integrated_component_vectorized_dataset_b,
  # # test_arima_moving_average_component_basic_dataset_b,
  # # test_arima_moving_average_component_vectorized_dataset_b,
  # test_arima_complete_basic_dataset_b,
  # test_arima_complete_vectorized_dataset_b,

  # # Dataset C
  # # test_arima_autoregressive_component_basic_dataset_c,
  # # test_arima_autoregressive_component_vectorized_dataset_c,
  # # test_arima_integrated_component_basic_dataset_c,
  # # test_arima_integrated_component_vectorized_dataset_c,
  # # test_arima_moving_average_component_basic_dataset_c,
  # # test_arima_moving_average_component_vectorized_dataset_c
  # test_arima_complete_basic_dataset_c,
  # test_arima_complete_vectorized_dataset_c,

  # # Dataset D
  # test_arima_complete_basic_dataset_d,
  # test_arima_complete_vectorized_dataset_d,

  # # Dataset E
  test_arima_complete_basic_dataset_e,
  test_arima_complete_vectorized_dataset_e
  
  # Dataset F
  # test_arima_complete_basic_dataset_f,
  # test_arima_complete_vectorized_dataset_f
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
