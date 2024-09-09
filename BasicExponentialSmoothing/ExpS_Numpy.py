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
def exponential_smoothing_parallel(data, alpha, number_of_executions):
    execution_times = []
    for _ in range(number_of_executions):
        start_time = time.time()
        smoothed_value = data[0]
        for i in prange(1, len(data)):
            smoothed_value = alpha * data[i] + (1 - alpha) * smoothed_value    
        last_smoothed_value = smoothed_value
        end_time = time.time()
        execution_times.append(end_time - start_time)
    function_time = np.median(execution_times)
    return last_smoothed_value, function_time

@jit(nopython=True)
def exponential_smoothing_parallel_vectorized(data, alpha, number_of_executions):
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
