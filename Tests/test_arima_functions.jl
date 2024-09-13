using Test
include("../Arima/arima_functions.jl")


@testitem "test_arima_autoregressive_component" begin
    data = readdlm("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", ',', Float64, '\n')[2:end, 1]
    lags = 2
    vector = [0.9208, -0.0111, 0.0766]
    expected_output = [8.42711736]
    
    result = autoregressive_component(data, lags, vector)
    last_result = result[end]
    
    @test isapprox(last_result, expected_output[1], atol=1e-7)
end

@testitem "test_arima_integrated_component" begin
    data = readdlm("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", ',', Float64, '\n')[2:end, 1]
    order = 1

    result = integrated_component(data, order)
    
    @test true  # Replace with actual test when expected output is defined
end

@testitem "test_arima_moving_average_component" begin
    original_data = [1, 2, 3, 4, 5]
    forecast_data = [1, 2, 3, 4, 5]
    order = 2
    theta = [0.5, 0.3]
    
    result = moving_average_component(original_data, forecast_data, order, theta)
    
    @test true  # Replace with actual test when expected output is defined
end

