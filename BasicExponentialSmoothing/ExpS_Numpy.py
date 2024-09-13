import numpy as np
import time
from numba import jit, prange

def exponential_smoothing_basic(data, alpha, number_of_executions):
    execution_times = []
    for _ in range(number_of_executions):
        start_time = time.time()
        smoothed_value = data[0]
        for j in range(1, len(data)):
            smoothed_value = alpha * data[j] + (1 - alpha) * smoothed_value
        end_time = time.time()
        execution_times.append(end_time - start_time)
    function_time = np.median(execution_times)
    return smoothed_value, function_time

def exponential_smoothing_vectorized(data, alpha, number_of_executions):
    execution_times = []
    for _ in range(number_of_executions):
        start_time = time.time()
        n = data.shape[0]
        weights = alpha * (1 - alpha) ** np.arange(n)[::-1]
        smoothed = np.cumsum(weights * data)[::-1]
        smoothed_value = smoothed[0] / weights.sum()
        end_time = time.time()
        execution_times.append(end_time - start_time)
    function_time = np.median(execution_times)
    return smoothed_value, function_time

@jit(nopython=True)
def smooth_wind_speed_basic(wind_speed, alpha):
    smoothed_value = wind_speed[0]  # Initialize with the first value
    for i in prange(1, len(wind_speed)):
        smoothed_value = alpha * wind_speed[i] + (1 - alpha) * smoothed_value
    return smoothed_value

def exponential_smoothing_parallel(data, alpha, number_of_executions):
    execution_times = []

    for i in range(number_of_executions):
        start_time = time.time()

        # Perform exponential smoothing on the data
        last_smoothed_value = smooth_wind_speed_basic(data, alpha)

        # Stop the timer
        end_time = time.time()
        execution_times.append(end_time - start_time)

    # Calculate the function time
    function_time = np.median(execution_times)
    return last_smoothed_value, function_time


@jit(nopython=True)
def smooth_solar_energy_vectorized(data, alpha):
    n = data.shape[0]
    weights = alpha * (1 - alpha) ** np.arange(n)[::-1]
    smoothed = np.cumsum(weights * data)[::-1]
    smoothed_value = smoothed[0] / weights.sum()
    return smoothed_value

def exponential_smoothing_parallel_vectorized(data, alpha, number_of_executions):
    execution_times = []

    for _ in range(number_of_executions):
        start_time = time.time()

        # Perform exponential smoothing on the data
        smoothed_value = smooth_solar_energy_vectorized(data, alpha)

        # Stop the timer
        end_time = time.time()
        execution_times.append(end_time - start_time)

    # Calculate the function time
    function_time = np.median(execution_times)
    return smoothed_value, function_time
