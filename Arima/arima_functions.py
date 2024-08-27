import numpy as np

def autoregressive_component(data, lags, vector):
    """
    Create a matrix with lagged data.
    Perform matrix-vector multiplication.

    Parameters:
    data (numpy array): The input data array.
    lags (int): The number of lags.
    vector (numpy array): The vector to multiply with the created lagged matrix.

    Returns:
    numpy array: The result of the matrix-vector multiplication.
    """

    # Create an empty matrix with the appropriate dimensions
    rows = len(data)
    lagged_matrix = np.zeros((rows, lags + 1))

    # Loop over number of lags and roll data 
    for i in range(lags + 1):
        lagged_matrix[:, i] = np.roll(data, -i)

    # Remove rows with incomplete data
    lagged_matrix = lagged_matrix[:rows - lags]

    result = np.matmul(lagged_matrix, vector)
    return result


def integrated_component(data, order):
    """
    Perform differencing on the data.

    Parameters:
    data (numpy array): The input data array.
    order (int): The order of differencing.

    Returns:
    numpy array: The differenced data.
    """
    differenced_data = np.diff(data, n=order)
    return differenced_data


def moving_average_component(original_data, forecast_data, order, theta):
    """
    Calculate the Moving Average (MA) component of an ARIMA model and update the forecast data.

    Parameters:
    original_data (array-like): Array of original data.
    forecast_data (array-like): Array of forecast data.
    order (int): Order of the MA model.
    theta (array-like): Array of MA coefficients.

    Returns:
    np.ndarray: Array of updated forecast values.
    """
    original_data = np.array(original_data)
    forecast_data = np.array(forecast_data)
    theta = np.array(theta)
    
    # Ensure the lengths of original_data and forecast_data are the same
    min_length = min(len(original_data), len(forecast_data))
    original_data = original_data[:min_length]
    forecast_data = forecast_data[:min_length]

    # Calculate the errors
    errors = original_data - forecast_data
    
    # Create a matrix of lagged errors
    lagged_errors = np.zeros((order, len(errors)))
    # loop over MA order 
    for i in range(1, order + 1):
        lagged_errors[i - 1, i:] = errors[:-i]
    
    # Calculate the weighted sum of lagged errors
    weighted_lagged_errors = np.matmul(theta, lagged_errors)
    
    # Update the forecast
    updated_forecast = forecast_data + weighted_lagged_errors
    
    return updated_forecast
