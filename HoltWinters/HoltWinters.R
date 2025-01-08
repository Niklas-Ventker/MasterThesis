triple_exponential_smoothing_basic <- function(data, alpha, beta, gamma, season_length) {
  n <- length(data)
  level <- numeric(n)
  trend <- numeric(n)
  season <- numeric(n)
  smoothed <- numeric(n)
  
  # Initialize the first values
  level[season_length] <- mean(data[1:season_length])
  trend[season_length] <- mean(data[(season_length + 1):(2 * season_length)]) - mean(data[1:season_length])
  season[1:season_length] <- data[1:season_length] - level[season_length]
  
  for (t in (season_length + 1):n) {
    level[t] <- alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t - 1] + trend[t - 1])
    trend[t] <- beta * (level[t] - level[t - 1]) + (1 - beta) * trend[t - 1]
    season[t] <- gamma * (data[t] - level[t]) + (1 - gamma) * season[t - season_length]
    smoothed[t] <- level[t] + trend[t] + season[t - season_length]
  }
  
  return(smoothed)
}


triple_exponential_smoothing_vectorized <- function(data, alpha, beta, gamma, season_length) {
  n <- length(data)
  
  # Initialize arrays
  level <- numeric(n)
  trend <- numeric(n)
  season <- numeric(season_length)
  smoothed <- numeric(n)
  
  # Initial values
  level[1] <- data[1]
  trend[1] <- data[2] - data[1]
  season[1:season_length] <- data[1:season_length] - level[1]
  
  # Vectorized approach for each season
  for (season_start in seq(1, n, by = season_length)) {
    season_end <- min(season_start + season_length - 1, n)
    season_indices <- season_start:season_end
    
    # Calculate level
    level_weights <- alpha * (1 - alpha) ^ (0:(length(season_indices) - 1))
    level_smoothed <- rev(cumsum(rev(level_weights * data[season_indices])))
    level[season_indices] <- level_smoothed / sum(level_weights)
    
    # Calculate trend
    trend_weights <- beta * (1 - beta) ^ (0:(length(season_indices) - 1))
    trend_smoothed <- rev(cumsum(rev(trend_weights * (level_smoothed - c(NA, level_smoothed[-length(level_smoothed)])))))
    trend[season_indices] <- trend_smoothed / sum(trend_weights)
    
    # Calculate season
    if (season_start == 1) {
      season_weights <- numeric(length(season_indices))
      season_smoothed <- numeric(length(season_indices))
    } else {
      season_weights <- gamma * (1 - gamma) ^ (0:(length(season_indices) - 1))
      season_smoothed <- rev(cumsum(rev(season_weights * (data[season_indices] - level_smoothed))))
      season[season_indices %% season_length] <- season_smoothed / sum(season_weights)
    }
    
    smoothed[season_indices] <- level[season_indices] + trend[season_indices] + season[season_indices %% season_length]
  }
  
  return(smoothed)
}


library(parallel)

triple_exponential_smoothing_basic_parallelized <- function(data, alpha, beta, gamma, season_length) {
  n <- length(data)
  
  # Initialize arrays
  level <- numeric(n)
  trend <- numeric(n)
  season <- numeric(n)
  smoothed <- numeric(n)
  
  # Initial values
  level[1] <- data[1]
  trend[1] <- data[2] - data[1]
  season[1:season_length] <- data[1:season_length] - level[1]
  
  if (season_length == 0) {
    season_length <- n
  }
  
  compute_t <- function(t) {
    level_t <- alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t-1] + trend[t-1])
    trend_t <- beta * (level_t - level[t-1]) + (1 - beta) * trend[t-1]
    season_t <- if (t >= season_length) gamma * (data[t] - level_t) + (1 - gamma) * season[t - season_length] else season[t]
    smoothed_t <- level_t + trend_t + season[t - t %% season_length]
    return(c(level_t, trend_t, season_t, smoothed_t))
  }
  
  results <- mclapply(2:n, compute_t, mc.cores = detectCores())
  
  for (t in 2:n) {
    level[t] <- results[[t-1]][1]
    trend[t] <- results[[t-1]][2]
    season[t] <- results[[t-1]][3]
    smoothed[t] <- results[[t-1]][4]
  }
  
  return(smoothed)
}


triple_exponential_smoothing_vectorized_parallelized <- function(data, alpha, beta, gamma, season_length) {
  n <- length(data)
  
  # Initialize arrays
  level <- numeric(n)
  trend <- numeric(n)
  season <- numeric(season_length)
  smoothed <- numeric(n)
  
  # Initial values
  level[1] <- data[1]
  trend[1] <- data[2] - data[1]
  season[1:season_length] <- data[1:season_length] - level[1]
  
  # Vectorized approach for each season
  compute_season <- function(season_start) {
    season_end <- min(season_start + season_length - 1, n)
    season_indices <- season_start:season_end
    
    # Calculate level
    level_weights <- alpha * (1 - alpha) ^ (0:(length(season_indices) - 1))
    level_smoothed <- rev(cumsum(rev(level_weights * data[season_indices])))
    level[season_indices] <- level_smoothed / sum(level_weights)
    
    # Calculate trend
    trend_weights <- beta * (1 - beta) ^ (0:(length(season_indices) - 1))
    trend_smoothed <- rev(cumsum(rev(trend_weights * (level_smoothed - c(NA, level_smoothed[-length(level_smoothed)])))))
    trend[season_indices] <- trend_smoothed / sum(trend_weights)
    
    # Calculate season
    if (season_start == 1) {
      season_weights <- numeric(length(season_indices))
      season_smoothed <- numeric(length(season_indices))
    } else {
      season_weights <- gamma * (1 - gamma) ^ (0:(length(season_indices) - 1))
      season_smoothed <- rev(cumsum(rev(season_weights * (data[season_indices] - level_smoothed))))
      season[season_indices %% season_length] <- season_smoothed / sum(season_weights)
    }
    
    smoothed[season_indices] <- level[season_indices] + trend[season_indices] + season[season_indices %% season_length]
  }
  
  mclapply(seq(1, n, by = season_length), compute_season, mc.cores = detectCores())
  
  return(smoothed)
}
