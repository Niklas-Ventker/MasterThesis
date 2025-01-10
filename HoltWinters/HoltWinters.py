import numpy as np

def triple_exponential_smoothing_basic(data, alpha, beta, gamma, season_length):
    
    n = len(data)

    # Initialize arrays
    level = np.zeros(n)
    trend = np.zeros(n)
    season = np.zeros(n)
    smoothed = np.zeros(n)

    # Initial values
    level[0] = data[0]
    trend[0] = data[1] - data[0]
    season[:season_length] = data[:season_length] - level[0]

    if season_length == 0:
        season_length = n

    # Calculate level, trend, and season components
    for t in range(1, n):
        level[t] = alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t-1] + trend[t-1])
        trend[t] = beta * (level[t] - level[t-1]) + (1 - beta) * trend[t-1]
        if t >= season_length:
            season[t] = gamma * (data[t] - level[t]) + (1 - gamma) * season[t - season_length]
        smoothed[t] = level[t] + trend[t] + season[t-t%season_length]

    return smoothed




def triple_exponential_smoothing_vectorized(data, alpha, beta, gamma, season_length):
    
    n = data.shape[0]

    # Initialize arrays
    level = np.zeros(n)
    trend = np.zeros(n)
    season = np.zeros(season_length)
    smoothed = np.zeros(n)

    # Initial values
    level[0] = data[0]
    trend[0] = data[1] - data[0]
    season[:season_length] = data[:season_length] - level[0]

    # Vectorized approach for each season
    for season_start in range(0, n, season_length):
        season_end = min(season_start + season_length, n)
        season_indices = np.arange(season_start, season_end)
        
        # Calculate level
        level_weights = alpha * (1 - alpha) ** np.arange(season_end - season_start)
        level_smoothed = np.cumsum(level_weights * data[season_indices][::-1])[::-1]
        level[season_indices] = level_smoothed / level_weights.sum()

        # Calculate trend
        trend_weights = beta * (1 - beta) ** np.arange(season_end - season_start)
        trend_smoothed = np.cumsum(trend_weights * (level_smoothed - np.roll(level_smoothed, 1))[::-1])[::-1]
        trend[season_indices] = trend_smoothed / trend_weights.sum()

        # Calculate season
        if season_start == 0:
            season_weights = np.zeros(season_end - season_start)
            season_smoothed = np.zeros(season_end - season_start)
        else:
            season_weights = gamma * (1 - gamma) ** np.arange(season_end - season_start)
            season_smoothed = np.cumsum(season_weights * (data[season_indices] - level_smoothed)[::-1])[::-1]
            season[season_indices % season_length] = season_smoothed / season_weights.sum()

        smoothed[season_indices] = level[season_indices] + trend[season_indices] + season[season_indices % season_length]

    return smoothed


import numpy as np
from concurrent.futures import ThreadPoolExecutor

def triple_exponential_smoothing_basic_parallelized(data, alpha, beta, gamma, season_length):
    n = len(data)

    # Initialize arrays
    level = np.zeros(n)
    trend = np.zeros(n)
    season = np.zeros(n)
    smoothed = np.zeros(n)

    # Initial values
    level[0] = data[0]
    trend[0] = data[1] - data[0]
    season[:season_length] = data[:season_length] - level[0]

    if season_length == 0:
        season_length = n

    def compute_t(t):
        nonlocal level, trend, season
        level_t = alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t-1] + trend[t-1])
        trend_t = beta * (level_t - level[t-1]) + (1 - beta) * trend[t-1]
        season_t = gamma * (data[t] - level_t) + (1 - gamma) * season[t - season_length] if t >= season_length else season[t]
        smoothed_t = level_t + trend_t + season[t-t%season_length]
        return level_t, trend_t, season_t, smoothed_t

    for t in range(1, n):
        level[t], trend[t], season[t], smoothed[t] = compute_t(t)

    return smoothed


import numpy as np

def triple_exponential_smoothing_vectorized_parallelized(data, alpha, beta, gamma, season_length):
    
    n = data.shape[0]

    # Initialize arrays
    level = np.zeros(n)
    trend = np.zeros(n)
    season = np.zeros(season_length)
    smoothed = np.zeros(n)

    # Initial values
    level[0] = data[0]
    trend[0] = data[1] - data[0]
    season[:season_length] = data[:season_length] - level[0]

    # Vectorized approach for each season
    for season_start in range(0, n, season_length):
        season_end = min(season_start + season_length, n)
        season_indices = np.arange(season_start, season_end)
        
        # Calculate level
        level_weights = alpha * (1 - alpha) ** np.arange(season_end - season_start)
        level_smoothed = np.cumsum(level_weights * data[season_indices][::-1])[::-1]
        level[season_indices] = level_smoothed / level_weights.sum()

        # Calculate trend
        trend_weights = beta * (1 - beta) ** np.arange(season_end - season_start)
        trend_smoothed = np.cumsum(trend_weights * (level_smoothed - np.roll(level_smoothed, 1))[::-1])[::-1]
        trend[season_indices] = trend_smoothed / trend_weights.sum()

        # Calculate season
        if season_start == 0:
            season_weights = np.zeros(season_end - season_start)
            season_smoothed = np.zeros(season_end - season_start)
        else:
            season_weights = gamma * (1 - gamma) ** np.arange(season_end - season_start)
            season_smoothed = np.cumsum(season_weights * (data[season_indices] - level_smoothed)[::-1])[::-1]
            season[season_indices % season_length] = season_smoothed / season_weights.sum()

        smoothed[season_indices] = level[season_indices] + trend[season_indices] + season[season_indices % season_length]

    return smoothed
