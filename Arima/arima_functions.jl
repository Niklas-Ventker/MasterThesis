# autoregressive_component

function autoregressive_component_basic(data::Vector{Float64}, lags::Int, vector::Vector{Float64})
    rows = length(data)
    forecast = zeros(Float64, rows - lags)
    # Outer loop over valid forecast positions
    for i in 1:(rows - lags)
        # Inner loop over lagged terms
        for j in 0:lags
            forecast[i] += data[i + j] * vector[j + 1]
        end
    end
    return forecast
end


function autoregressive_component_vectorized(data::Vector{Float64}, lags::Int, vector::Vector{Float64})
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

function integrated_component_basic(data::Vector{Float64}, order::Int)
    differenced_data = data
    for _ in 1:order
        new_data = Float64[]
        for i in 2:length(differenced_data)
            push!(new_data, differenced_data[i] - differenced_data[i - 1])
        end
        differenced_data = new_data
    end    
    return differenced_data
end


function integrated_component_vectorized(data::Vector{Float64}, order::Int)
    differenced_data = data
    for _ in 1:order
        differenced_data = diff(differenced_data)
    end    
    return differenced_data
end

# moving_average_component

function moving_average_component_basic(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
    min_length = min(length(original_data), length(forecast_data))
    original_data = original_data[1:min_length]
    forecast_data = forecast_data[1:min_length]
    
    errors = original_data - forecast_data
    updated_forecast = copy(forecast_data)
    
    for t in (order + 1):length(errors)
        weighted_sum = 0.0
        for i in 1:order
            weighted_sum += theta[i] * errors[t - i]
        end
        updated_forecast[t] += weighted_sum
    end
    
    return updated_forecast
end


function moving_average_component_vectorized(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
    min_length = min(length(original_data), length(forecast_data))
    original_data = original_data[1:min_length]
    forecast_data = forecast_data[1:min_length]
    
    errors = original_data - forecast_data
    lagged_errors = zeros(Float64, order, length(errors))
    
    for i in 1:order
        lagged_errors[i, (i + 1):end] = errors[1:(end - i)]
    end
    
    weighted_lagged_errors = transpose(theta) * lagged_errors
    
    updated_forecast = forecast_data .+ weighted_lagged_errors
    return updated_forecast
end


function moving_average_component_vectorized_v2(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
    min_length = min(length(original_data), length(forecast_data))
    original_data = original_data[1:min_length]
    forecast_data = forecast_data[1:min_length]

    # Adjust for errors from AR component
    errors = original_data - forecast_data
    lagged_errors = zeros(Float64, order, length(errors))
    for i in 1:order
        lagged_errors[i, (i + 1):end] = errors[1:(end - i)]
    end
    weighted_lagged_errors = theta' * lagged_errors
    updated_forecast = forecast_data .+ weighted_lagged_errors

    # Adjust for errors from own MA component
    updated_errors = forecast_data - updated_forecast
    lagged_updated_errors = zeros(Float64, order, length(updated_errors))
    for i in 1:order
        lagged_updated_errors[i, (i + 1):end] = updated_errors[1:(end - i)]
    end
    weighted_updated_errors = theta' * lagged_updated_errors
    updated_forecast .+= weighted_updated_errors

    return updated_forecast
end


# function moving_average_component_vectorized(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
#     min_length = min(length(original_data), length(forecast_data))
#     original_data = original_data[1:min_length]
#     forecast_data = forecast_data[1:min_length]

#     # Adjust for errors from AR component
#     errors = original_data - forecast_data
#     lagged_errors = zeros(Float64, order, min_length)
#     for i in 1:order
#         lagged_errors[i, (i + 1):end] .= errors[1:(end - i)]
#     end
#     weighted_lagged_errors = theta' * lagged_errors
#     updated_forecast = forecast_data .+ weighted_lagged_errors

#     # Adjust for errors from own MA component
#     updated_errors = forecast_data .- updated_forecast
#     lagged_updated_errors = zeros(Float64, order, min_length)
#     for i in 1:order
#         lagged_updated_errors[i, (i + 1):end] .= updated_errors[1:(end - i)]
#     end
#     weighted_updated_errors = theta' * lagged_updated_errors
#     updated_forecast .+= weighted_updated_errors

#     return updated_forecast
# end




# v3


function autoregressive_component_vectorized_v3(data::Vector{Float64}, lags::Int, vector::Vector{Float64})
    rows = length(data) - lags
    lagged_matrix = zeros(Float64, rows, lags + 1)
    
    for i in 0:lags
        lagged_matrix[:, i + 1] = @view data[(lags - i + 1):(end - i)]
    end
    
    return lagged_matrix * vector
end

function integrated_component_vectorized_v3(data::Vector{Float64}, order::Int)
    for _ in 1:order
        data = diff(data)
    end
    return data
end

function moving_average_component_vectorized_v3(original_data::Vector{Float64}, forecast_data::Vector{Float64}, order::Int, theta::Vector{Float64})
    min_length = min(length(original_data), length(forecast_data))
    original_data = original_data[1:min_length]
    forecast_data = forecast_data[1:min_length]

    errors = original_data - forecast_data
    lagged_errors = zeros(Float64, order, min_length)

    for i in 1:order
        lagged_errors[i, (i + 1):end] .= errors[1:(end - i)]
    end

    weighted_lagged_errors = theta' * lagged_errors
    updated_forecast = forecast_data .+ vec(weighted_lagged_errors)
    
    return updated_forecast
end