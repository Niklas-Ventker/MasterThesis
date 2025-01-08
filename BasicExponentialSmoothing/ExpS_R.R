# Load necessary libraries
library(parallel)

# Basic Exponential Smoothing
exponential_smoothing_basic <- function(data, alpha, number_of_executions) {
  execution_times <- numeric(number_of_executions)
  
  for (i in 1:number_of_executions) {
    start_time <- Sys.time()
    smoothed_value <- data[1]
    
    for (j in 2:length(data)) {
      smoothed_value <- alpha * data[j] + (1 - alpha) * smoothed_value
    }
    
    end_time <- Sys.time()
    execution_times[i] <- as.numeric(difftime(end_time, start_time, units = "secs"))
  }
  
  function_time <- mean(execution_times)
  return(list(smoothed_value = smoothed_value, function_time = function_time))
}

# Vectorized Exponential Smoothing
exponential_smoothing_vectorized <- function(data, alpha, number_of_executions) {
  execution_times <- numeric(number_of_executions)
  
  for (i in 1:number_of_executions) {
    start_time <- Sys.time()
    n <- length(data)
    weights <- alpha * (1 - alpha) ^ (rev(seq_len(n)) - 1)
    smoothed <- cumsum(weights * data)
    smoothed_value <- smoothed[n] / sum(weights)
    end_time <- Sys.time()
    execution_times[i] <- as.numeric(difftime(end_time, start_time, units = "secs"))
  }
  
  function_time <- mean(execution_times)
  return(list(smoothed_value = smoothed_value, function_time = function_time))
}

# Parallel Exponential Smoothing
exponential_smoothing_parallel <- function(data, alpha, number_of_executions) {
  execution_times <- numeric(number_of_executions)
  
  for (i in 1:number_of_executions) {
    start_time <- Sys.time()
    smoothed_value <- data[1]
    
    mclapply(2:length(data), function(j) {
      smoothed_value <- alpha * data[j] + (1 - alpha) * smoothed_value
    }, mc.cores = detectCores())
    
    end_time <- Sys.time()
    execution_times[i] <- as.numeric(difftime(end_time, start_time, units = "secs"))
  }
  
  function_time <- mean(execution_times)
  return(list(smoothed_value = smoothed_value, function_time = function_time))
}

# Parallel Vectorized Exponential Smoothing
exponential_smoothing_parallel_vectorized <- function(data, alpha, number_of_executions) {
  execution_times <- numeric(number_of_executions)
  
  for (i in 1:number_of_executions) {
    start_time <- Sys.time()
    n <- length(data)
    weights <- alpha * (1 - alpha) ^ (rev(seq_len(n)) - 1)
    smoothed <- cumsum(weights * data)
    smoothed_value <- smoothed[n] / sum(weights)
    end_time <- Sys.time()
    execution_times[i] <- as.numeric(difftime(end_time, start_time, units = "secs"))
  }
  
  function_time <- mean(execution_times)
  return(list(smoothed_value = smoothed_value, function_time = function_time))
}
