using CSV
using DataFrames
using Statistics
using LinearAlgebra
include("/Users/niklas/Documents/GitHub/MasterThesis/HoltWinters/HoltWinters.jl")

#################################################
# Only Datasets with Seasonal Characteristics!
# Dataset B - Energy Generation Solar

# Load the dataset
data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv", DataFrame)[:, 1]
data_b = convert(Vector{Float64}, data_b)

# Define the parameters for testing
alpha = 0.2
beta = 0.1
gamma = 0.3
season_length = 24
expected_output_b = 90.60914407238147

# Initialize counters
global passed_tests = 0
global failed_tests = 0

# Define the test functions
function test_triple_exponential_smoothing_basic_dataset_b()
    smoothed = triple_exponential_smoothing_basic(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[end]
    if abs(last_smoothed_value - expected_output_b) < 0.0000000005
        println("test_triple_exponential_smoothing_basic_dataset_b: PASSED")
        return true
    else
        println("test_triple_exponential_smoothing_basic_dataset_b: FAILED")
        return false
    end
end

function test_triple_exponential_smoothing_vectorized_dataset_b()
    smoothed = triple_exponential_smoothing_vectorized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[end]
    if abs(last_smoothed_value - expected_output_b) < 0.0000000005
        println("test_triple_exponential_smoothing_vectorized_dataset_b: PASSED")
        return true
    else
        println("test_triple_exponential_smoothing_vectorized_dataset_b: FAILED")
        return false
    end
end

function test_triple_exponential_smoothing_basic_parallelized_dataset_b()
    smoothed = triple_exponential_smoothing_basic_parallelized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[end]
    if abs(last_smoothed_value - expected_output_b) < 0.0000000005
        println("test_triple_exponential_smoothing_basic_parallelized_dataset_b: PASSED")
        return true
    else
        println("test_triple_exponential_smoothing_basic_parallelized_dataset_b: FAILED")
        return false
    end
end

function test_triple_exponential_smoothing_vectorized_parallelized_dataset_b()
    smoothed = triple_exponential_smoothing_vectorized_parallelized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[end]
    if abs(last_smoothed_value - expected_output_b) < 0.0000000005
        println("test_triple_exponential_smoothing_vectorized_parallelized_dataset_b: PASSED")
        return true
    else
        println("test_triple_exponential_smoothing_vectorized_parallelized_dataset_b: FAILED")
        return false
    end
end

# Run the tests and count the results
tests = [
    test_triple_exponential_smoothing_basic_dataset_b,
    test_triple_exponential_smoothing_vectorized_dataset_b,
    test_triple_exponential_smoothing_basic_parallelized_dataset_b,
    test_triple_exponential_smoothing_vectorized_parallelized_dataset_b
]

for test in tests
    global passed_tests
    global failed_tests
    if test()
        passed_tests += 1
    else
        failed_tests += 1
    end
end

println("Total tests passed: ", passed_tests)
println("Total tests failed: ", failed_tests)