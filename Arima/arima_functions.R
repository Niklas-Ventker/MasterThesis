autoregressive_component_basic <- function(data, lags, vector) {
  rows <- length(data)
  forecast <- numeric(rows - lags) # Create a zero vector of the required size
  
  # Outer loop over valid forecast positions
  for (i in 1:(rows - lags)) {
    # Inner loop over lagged terms
    for (j in 0:lags) {
      forecast[i] <- forecast[i] + data[i + j] * vector[j + 1]
    }
  }
  
  return(forecast)
}

autoregressive_component_vectorized <- function(data, lags, vector) {
  rows <- length(data)
  lagged_matrix <- sapply(0:lags, function(i) c(data[(i + 1):rows], rep(NA, i)))
  
  lagged_matrix <- lagged_matrix[1:(rows - lags), ]  
  result <- lagged_matrix %*% vector
  return(result)
}

integrated_component_basic <- function(data, order) {
  differenced_data <- data
  for (i in 1:order) {
    differenced_data <- diff(differenced_data)
  }
  return(differenced_data)
}

integrated_component_vectorized <- function(data, order) {
  # Perform differencing on the data
  differenced_data <- diff(data, differences = order)
  return(differenced_data)
}

moving_average_component_basic <- function(original_data, forecast_data, order, theta) {
  original_data <- as.numeric(original_data)
  forecast_data <- as.numeric(forecast_data)
  theta <- as.numeric(theta)
  
  min_length <- min(length(original_data), length(forecast_data))
  original_data <- original_data[1:min_length]
  forecast_data <- forecast_data[1:min_length]
  
  errors <- original_data - forecast_data
  updated_forecast <- forecast_data
  
  for (t in (order + 1):length(errors)) {
    weighted_sum <- 0
    for (i in 1:order) {
      weighted_sum <- weighted_sum + theta[i] * errors[t - i]
    }
    updated_forecast[t] <- updated_forecast[t] + weighted_sum
  }
  
  return(updated_forecast)
}

moving_average_component_vectorized <- function(original_data, forecast_data, order, theta) {
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
