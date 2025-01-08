library(data.table)

# Load the functions from the specified file
# source('/Users/niklas/Documents/GitHub/MasterThesis/Arima/arima_functions.R')


autoregressive_component_vectorized <- function(data, lags, vector) {
  rows <- length(data)
  lagged_matrix <- sapply(0:lags, function(i) c(data[(i + 1):rows], rep(NA, i)))
  
  lagged_matrix <- lagged_matrix[1:(rows - lags), ]  
  result <- lagged_matrix %*% vector
  return(result)
}


integrated_component_vectorized <- function(data, order) {
  # Perform differencing on the data
  differenced_data <- diff(data, differences = order)
  return(differenced_data)
}


moving_average_component_vectorized <- function(original_data, forecast_data, order, theta, ma_lags) {
  original_data <- as.numeric(original_data)
  forecast_data <- as.numeric(forecast_data)
  theta <- as.numeric(theta)
  
  # Ensure the lengths of original_data and forecast_data are the same
  min_length <- min(length(original_data), length(forecast_data))
  original_data <- original_data[1:min_length]
  forecast_data <- forecast_data[1:min_length]
  
  # Calculate the errors
  errors <- original_data - forecast_data
  
  # Create a matrix of lagged errors
  ma_lags <- as.numeric(ma_lags)
  lagged_errors <- matrix(0, nrow = ma_lags, ncol = length(errors))
  for (i in 1:ma_lags) {
    lagged_errors[i, (i + 1):length(errors)] <- errors[1:(length(errors) - i)]
  }
  
  # Calculate the weighted sum of lagged errors
  weighted_lagged_errors <- theta %*% lagged_errors
  
  # Update the forecast
  updated_forecast <- forecast_data + weighted_lagged_errors
  return(updated_forecast)
}


# Load the datasets
data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv', skip = 0)$V1
#data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv', skip = 0)$V1
# data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv', skip = 0)$V1
# data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv', skip = 0)$V1


# Define the parameters for testing
order <- 1
lags <- 2
vector <- c(0.7, 0.7, 0.7)
last_value <- tail(data_f, n=1)

# Sum of squares as error metric
#    error = np.sum((original - prediction) ** 2)
#    return error
# error_metric = sum_of_squares_error(wind_speed[lags+1:], updated_forecast)

test_arima_complete_vectorized_dataset_f_1 <- function() {

  theta <- c(0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 1)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_1: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_2 <- function() {

  theta <- c(0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 2)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_2: ERROR: ")
  cat(error)
  cat("\n")
}


test_arima_complete_vectorized_dataset_f_3 <- function() {
    
  theta <- c(0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 3)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)

  cat("test_arima_complete_vectorized_dataset_f_3: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_4 <- function() {
    
  theta <- c(0.7, 0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 4)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_4: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_5 <- function() {
    
  theta <- c(0.7, 0.7, 0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 5)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_5: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_6 <- function() {
    
  theta <- c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 6)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_6: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_7 <- function() {
    
  theta <- c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 7)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_7: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_8 <- function() {
    
  theta <- c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7)

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta, 8)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f) ** 2)


  cat("test_arima_complete_vectorized_dataset_f_8: ERROR: ")
  cat(error)
  cat("\n")
}

# Run the tests and count the results
tests <- list(
  
  # Dataset F
  test_arima_complete_vectorized_dataset_f_1,
  test_arima_complete_vectorized_dataset_f_2, 
  test_arima_complete_vectorized_dataset_f_3, 
  test_arima_complete_vectorized_dataset_f_4, 
  test_arima_complete_vectorized_dataset_f_5,
  test_arima_complete_vectorized_dataset_f_6,
  test_arima_complete_vectorized_dataset_f_7,
  test_arima_complete_vectorized_dataset_f_8
)

for (test in tests) {
    test()
}

