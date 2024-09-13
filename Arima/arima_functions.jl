# autoregressive_component
function autoregressive_component(data::Vector{Float64}, lags::Int, vector::Vector{Float64})
    rows = length(data)
    lagged_matrix = zeros(Float64, rows, lags + 1)
    
    for i in 0:lags
        lagged_matrix[:, i + 1] = circshift(data, -i)
    end
    
    # Remove rows with incomplete data
    lagged_matrix = lagged_matrix[1:(rows - lags), :]
    
    result = lagged_matrix * vector
    return result
end

# integrated_component
function integrated_component(data::Vector{Float64}, order::Int)
    differenced_data = data
    for _ in 1:order
        differenced_data = diff(differenced_data)
    end    
    return differenced_data
end

# moving_average_component
function moving_average_component(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
    min_length = min(length(original_data), length(forecast_data))
    original_data = original_data[1:min_length]
    forecast_data = forecast_data[1:min_length]
    
    errors = original_data - forecast_data
    
    lagged_errors = zeros(Float64, order, length(errors))
    for i in 1:order
        lagged_errors[i, (i + 1):end] = errors[1:(end - i)]
    end
    
    weighted_lagged_errors = theta' * lagged_errors
    
    updated_forecast = forecast_data .+ weighted_lagged_errors
    return updated_forecast
end
