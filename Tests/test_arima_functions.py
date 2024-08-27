import numpy as np
from Arima.arima_functions import autoregressive_component
from Arima.arima_functions import integrated_component
from Arima.arima_functions import moving_average_component


def test_autoregressive_component():
    # Define test inputs
    #data = np.array([1, 2, 3, 4, 5])
    #lags = 2
    #vector = np.array([0.9208, -0.0111, 0.0766])

    # Expected output
    #expected_output = np.array([])

    # Run the function
    #result = autoregressive_component(data, lags, vector)

    # Check if the result is as expected
    assert np.allclose(result, expected_output, 0.005), f"Expected {expected_output}, but got {result}"


def test_integrated_component():
    # Define test inputs
    #data = np.array([1, 2, 3, 4, 5])
    #lags = 2
    #vector = np.array([0.9208, -0.0111, 0.0766])

    # Expected output
    #expected_output = np.array([])

    # Run the function
    #result = autoregressive_component(data, lags, vector)

    # Check if the result is as expected
    assert np.allclose(result, expected_output, 0.005), f"Expected {expected_output}, but got {result}"

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
    assert np.allclose(result, expected_output, 0.005), f"Expected {expected_output}, but got {result}"
