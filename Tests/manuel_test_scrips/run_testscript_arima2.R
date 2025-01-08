library(data.table)

# Load the functions from the specified file
source('/Users/niklas/Documents/GitHub/MasterThesis/Arima/arima_functions.R')

# Load the datasets
# data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv', skip = 1)$V1
# data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv', skip = 0)$V1
data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv', skip = 0)$V1


# Define the parameters for testing
lags <- 2
vector <- c(0.9208, -0.0111, 0.0766)
theta <- c(0.3, 0.3)



last_value <- tail(data_f, n=1)

# Sum of squares as error metric
#    error = np.sum((original - prediction) ** 2)
#    return error
# error_metric = sum_of_squares_error(wind_speed[lags+1:], updated_forecast)

test_arima_complete_vectorized_dataset_f_1 <- function() {

  order <- 1


  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f)^2)


  cat("test_arima_complete_vectorized_dataset_f_1: ERROR: ")
  cat(error)
  cat("\n")
}


test_arima_complete_vectorized_dataset_f_2 <- function() {
    
  order <- 2

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f)^2)
  
  cat("test_arima_complete_vectorized_dataset_f_2: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_3 <- function() {
    
  order <- 3

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f)^2)


  cat("test_arima_complete_vectorized_dataset_f_3: ERROR: ")
  cat(error)
  cat("\n")
}

test_arima_complete_vectorized_dataset_f_4 <- function() {
    
  order <- 4

  integrated_data <- integrated_component_vectorized(data_f, order)
  forecast_data <- autoregressive_component_vectorized(integrated_data, lags, vector)
  result <- moving_average_component_vectorized(integrated_data[(lags + 1):length(integrated_data)], forecast_data, lags, theta)
  last_result_f <- result[nrow(result), ncol(result)]

  print(last_result_f)
  print(last_value)

  error = sum((last_value - last_result_f)^2)


  cat("test_arima_complete_vectorized_dataset_f_4: ERROR: ")
  cat(error)
  cat("\n")
}


# Run the tests and count the results
tests <- list(
  
  # Dataset F
  test_arima_complete_vectorized_dataset_f_1,
  test_arima_complete_vectorized_dataset_f_2, 
  test_arima_complete_vectorized_dataset_f_3,
  test_arima_complete_vectorized_dataset_f_4
)

for (test in tests) {
    test()
}

