autoregressive_component <- function(data, lags, vector) {
  # Create a matrix with lagged data
  rows <- length(data)
  lagged_matrix <- matrix(0, nrow = rows, ncol = lags + 1)
  
  for (i in 0:lags) {
    lagged_matrix[, i + 1] <- c(rep(NA, i), data[1:(rows - i)])
  }
  
  # Remove rows with incomplete data
  lagged_matrix <- lagged_matrix[complete.cases(lagged_matrix), ]
  
  # Perform matrix-vector multiplication
  result <- lagged_matrix %*% vector
  return(result)
}


integrated_component <- function(data, order) {
  # Perform differencing on the data
  differenced_data <- diff(data, differences = order)
  return(differenced_data)
}


moving_average_component <- function(original_data, forecast_data, order, theta) {
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
  lagged_errors <- matrix(0, nrow = order, ncol = length(errors))
  for (i in 1:order) {
    lagged_errors[i, (i + 1):length(errors)] <- errors[1:(length(errors) - i)]
  }
  
  # Calculate the weighted sum of lagged errors
  weighted_lagged_errors <- theta %*% lagged_errors
  
  # Update the forecast
  updated_forecast <- forecast_data + weighted_lagged_errors
  return(updated_forecast)
}
