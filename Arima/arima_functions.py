import numpy as np

#####
# Autoregressive Component

def autoregressive_component_basic(data, lags, vector):
    rows = len(data)
    lagged_matrix = np.zeros((rows, lags + 1))

    for i in range(lags + 1):
        for j in range(rows):
            if j + i < rows:
                lagged_matrix[j, i] = data[j + i]

    lagged_matrix = lagged_matrix[:rows - lags]

    result = np.zeros(len(lagged_matrix))
    for i in range(len(lagged_matrix)):
        for j in range(len(vector)):
            result[i] += lagged_matrix[i, j] * vector[j]

    return result


def autoregressive_component_basic_v2(data, lags, vector):
    rows = len(data)
    result = np.zeros(rows - lags)

    for i in range(rows - lags):
        for j in range(lags + 1):
            result[i] += data[i + j] * vector[j]

    return result


def autoregressive_component_vectorized(data, lags, vector):

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


#####
# Integrated Component

def integrated_component_basic(data, order):

    differenced_data = data.copy()
    for _ in range(order):
        differenced_data = [differenced_data[i] - differenced_data[i - 1] for i in range(1, len(differenced_data))]
    return np.array(differenced_data)


def integrated_component_vectorized(data, order):

    differenced_data = np.diff(data, n=order)
    return differenced_data


#####
# Moving Average Component

def moving_average_component_basic(original_data, forecast_data, order, theta):

    original_data = np.array(original_data)
    forecast_data = np.array(forecast_data)
    theta = np.array(theta)
    
    min_length = min(len(original_data), len(forecast_data))
    original_data = original_data[:min_length]
    forecast_data = forecast_data[:min_length]

    errors = original_data - forecast_data
    updated_forecast = forecast_data.copy()

    for t in range(order, len(errors)):
        weighted_sum = 0
        for i in range(1, order + 1):
            weighted_sum += theta[i - 1] * errors[t - i]
        updated_forecast[t] += weighted_sum

    return updated_forecast


def moving_average_component_vectorized(original_data, forecast_data, order, theta):

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


def moving_average_component_vectorized_v2(actual, forecast, order, theta):

    actual = np.array(actual)
    forecast = np.array(forecast)
    theta = np.array(theta)
    
    # Ensure the lengths of actual and forecast are the same
    min_length = min(len(actual), len(forecast))
    actual = actual[:min_length]
    forecast = forecast[:min_length]
    
    # Calculate the errors
    errors = actual - forecast
    
    # Adjust for errors from AR component
    lagged_errors = np.zeros((order, len(errors)))
    for i in range(1, order + 1):
        lagged_errors[i - 1, i:] = errors[:-i]
    weighted_lagged_errors = np.dot(theta, lagged_errors)
    updated_forecast = forecast + weighted_lagged_errors
    
    # Adjust for errors from own MA component
    updated_errors = actual - updated_forecast # TODO: Oder forecast - updated forecast
    lagged_updated_errors = np.zeros((order, len(updated_errors)))
    for i in range(1, order + 1):
        lagged_updated_errors[i - 1, i:] = updated_errors[:-i]
    weighted_updated_errors = np.dot(theta, lagged_updated_errors)
    updated_forecast += weighted_updated_errors
    
    return updated_forecast
