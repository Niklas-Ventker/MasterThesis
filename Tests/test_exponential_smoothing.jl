using Test
include("/Users/niklas/Documents/GitHub/MasterThesis/BasicExponentialSmoothing/ExpS_Julia.jl")

# Load the dataset
data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", DataFrame)[:, 1]
alpha = 0.7
number_of_executions = 10
expected_output_a = 9.729056156830051

@testitem "test_exponantial_smoothing_basic_Dataset_A" begin
    smoothed_value, function_time = exponential_smoothing_basic(data_a, alpha, number_of_executions)
    @test isapprox(smoothed_value, expected_output_a, atol=0.0000000005)
    @test function_time > 0
end

@testitem "test_exponantial_smoothing_vectorized_Dataset_A" begin
    smoothed_value, function_time = exponential_smoothing_vectorized(data_a, alpha, number_of_executions)
    @test isapprox(smoothed_value, expected_output_a, atol=0.0000000005)
    @test function_time > 0
end

@testitem "Basic Test" begin
    @test 1 + 1 == 2
end
