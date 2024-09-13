import numpy as np
from Arima.arima_functions import (
    autoregressive_component, 
    integrated_component, 
    moving_average_component
)

#################################################
# Dataset A - wind_speed

def test_arima_autoregressive_component_dataset_a():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    # Expected output
    expected_output = np.array([8.42711736])
    # Run the function
    result = autoregressive_component(data, lags, vector)
    last_result = result[-1]
    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_integrated_component_dataset_a():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    order = 1
    # Expected output
    expected_output = np.array([0.55796623])

    # Run the function
    result = integrated_component(data, order)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_movingaverage_component_dataset_a():
    # Load the dataset
    initial_data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
        
    # Define test inputs
    theta = [0.3, 0.3]
    order = 2
    original_data = initial_data[order:]

    # Expected output and necessary AR component
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    forecast_data = autoregressive_component(initial_data, lags, vector)   
    expected_output = np.array([8.25047461])

    # Run the function
    result = moving_average_component(original_data, forecast_data, order, theta)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.0000000005), f"Expected {expected_output}, but got {result}"


#################################################
# Dataset B - energy_generation_solar

def test_arima_autoregressive_component_dataset_b():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    # Expected output
    expected_output = np.array([8.42711736])
    # Run the function
    result = autoregressive_component(data, lags, vector)
    last_result = result[-1]
    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_integrated_component_dataset_b():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    order = 1
    # Expected output
    expected_output = np.array([0.55796623])

    # Run the function
    result = integrated_component(data, order)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_movingaverage_component_dataset_b():
    # Load the dataset
    initial_data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
        
    # Define test inputs
    theta = [0.3, 0.3]
    order = 2
    original_data = initial_data[order:]

    # Expected output and necessary AR component
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    forecast_data = autoregressive_component(initial_data, lags, vector)   
    expected_output = np.array([8.25047461])

    # Run the function
    result = moving_average_component(original_data, forecast_data, order, theta)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.0000000005), f"Expected {expected_output}, but got {result}"


#################################################
# Dataset C - heart_rate

def test_arima_autoregressive_component_dataset_c():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    # Expected output
    expected_output = np.array([8.42711736])
    # Run the function
    result = autoregressive_component(data, lags, vector)
    last_result = result[-1]
    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_integrated_component_dataset_c():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    order = 1
    # Expected output
    expected_output = np.array([0.55796623])

    # Run the function
    result = integrated_component(data, order)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.00005), f"Expected {expected_output}, but got {result}"

def test_arima_movingaverage_component_dataset_c():
    # Load the dataset
    initial_data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
        
    # Define test inputs
    theta = [0.3, 0.3]
    order = 2
    original_data = initial_data[order:]

    # Expected output and necessary AR component
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    forecast_data = autoregressive_component(initial_data, lags, vector)   
    expected_output = np.array([8.25047461])

    # Run the function
    result = moving_average_component(original_data, forecast_data, order, theta)
    last_result = result[-1]

    # Check if the result is as expected
    assert np.allclose(last_result, expected_output, 0.0000000005), f"Expected {expected_output}, but got {result}"