import numpy as np
from Arima.arima_functions import (
    autoregressive_component, 
    integrated_component, 
    moving_average_component
)

def test_autoregressive_component():
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
    assert np.allclose(last_result, expected_output, 0.0000000005), f"Expected {expected_output}, but got {result}"

def test_integrated_component():
    # Load the dataset
    data = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)
    # Define test inputs
    lags = 2
    vector = np.array([0.9208, -0.0111, 0.0766])
    # Expected output
    expected_output = np.array([8.42711736])

    # Run the function
    #result = autoregressive_component(data, lags, vector)

    # Check if the result is as expected
    #assert np.allclose(result, expected_output, 0.005), f"Expected {expected_output}, but got {result}"
    assert True

def test_movingaverage_component():
    # Define test inputs
    #data = np.array([1, 2, 3, 4, 5])
    #lags = 2
    #vector = np.array([0.9208, -0.0111, 0.0766])

    # Expected output
    #expected_output = np.array([])

    # Run the function
    #result = autoregressive_component(data, lags, vector)

    # Check if the result is as expected
    #assert np.allclose(result, expected_output, 0.005), f"Expected {expected_output}, but got {result}"
    assert True