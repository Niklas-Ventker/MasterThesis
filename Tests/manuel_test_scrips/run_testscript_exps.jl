using CSV
using DataFrames
using Statistics
include("/Users/niklas/Documents/GitHub/MasterThesis/BasicExponentialSmoothing/ExpS_Julia.jl")

# Load the datasets
#data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", DataFrame)[:, 1]
#data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv", DataFrame)[:, 1]
#data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv", DataFrame)[:, 1]
#data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv", DataFrame)[:, 1]
#data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
#data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv", DataFrame)[:, 1]

data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv", DataFrame)[:, 1]
data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv", DataFrame)[:, 1]
data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv", DataFrame)[:, 1]
data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv", DataFrame)[:, 1]
data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv", DataFrame)[:, 1]


# Define the parameters for testing
alpha = 0.7
number_of_executions = 10

# Expected outputs
expected_output_a = 9.729056156830051
expected_output_b = 33.09027077319566
expected_output_c = 98.77752694571055
expected_output_d = 11.475341948013103 #temp delhi
expected_output_e = 233.27015019545632 #stock microsoft
expected_output_f = 26390.068709835385 #NYC Taxi

# Initialize counters
global passed_tests = 0
global failed_tests = 0

# Define the test functions

# Dataset A
function test_exponential_smoothing_basic_dataset_a()
    smoothed_value, function_time = exponential_smoothing_basic(data_a, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_a) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_A: PASSED")
        #println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_A: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_a()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_a, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_a) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_A: PASSED")
        #println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_A: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_a()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_a, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_a) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_A: PASSED")
        #println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_A: FAILED")
        return false
    end
end

# Dataset B
#################################################
function test_exponential_smoothing_basic_dataset_b()
    smoothed_value, function_time = exponential_smoothing_basic(data_b, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_b) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_B: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_B: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_b()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_b, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_b) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_B: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_B: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_b()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_b, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_b) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_B: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_B: FAILED")
        return false
    end
end

# Dataset C
#################################################
function test_exponential_smoothing_basic_dataset_c()
    smoothed_value, function_time = exponential_smoothing_basic(data_c, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_c) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_C: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_C: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_c()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_c, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_c) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_C: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_C: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_c()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_c, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_c) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_C: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_C: FAILED")
        return false
    end
end

# Dataset D
#################################################
function test_exponential_smoothing_basic_dataset_d()
    smoothed_value, function_time = exponential_smoothing_basic(data_d, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_d) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_D: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_D: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_d()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_d, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_d) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_D: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_D: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_d()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_d, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_d) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_D: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_D: FAILED")
        return false
    end
end

# Dataset E
#################################################
function test_exponential_smoothing_basic_dataset_e()
    smoothed_value, function_time = exponential_smoothing_basic(data_e, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_e) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_E: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_E: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_e()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_e, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_e) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_E: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_E: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_e()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_e, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_e) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_E: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_E: FAILED")
        return false
    end
end

# Dataset F
#################################################
function test_exponential_smoothing_basic_dataset_f()
    smoothed_value, function_time = exponential_smoothing_basic(data_f, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_f) < 0.0000000005
        println("test_exponential_smoothing_basic_dataset_F: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_basic_dataset_F: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_dataset_f()
    smoothed_value, function_time = exponential_smoothing_vectorized(data_f, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_f) < 0.0000000005
        println("test_exponential_smoothing_vectorized_dataset_F: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_dataset_F: FAILED")
        return false
    end
end

function test_exponential_smoothing_vectorized_parallel_dataset_f()
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_f, alpha, number_of_executions)
    if abs(smoothed_value - expected_output_f) < 0.0000000005
        println("test_exponential_smoothing_vectorized_parallel_dataset_F: PASSED")
        println("smoothed_value: ", smoothed_value)
        println("function executed in: ", function_time, " seconds.\n")
        return true
    else
        println("test_exponential_smoothing_vectorized_parallel_dataset_F: FAILED")
        return false
    end
end


println("\n### Simple Exponential Smoothing Experiments:\n\n")
# Run the tests and count the results
tests = [
    # Dataset A
    #test_exponential_smoothing_basic_dataset_a,
    test_exponential_smoothing_vectorized_dataset_a
    #test_exponential_smoothing_vectorized_parallel_dataset_a,
    # Dataset B
    #test_exponential_smoothing_basic_dataset_b,
    #test_exponential_smoothing_vectorized_dataset_b,
    #test_exponential_smoothing_vectorized_parallel_dataset_b,
    # Dataset C
    #test_exponential_smoothing_basic_dataset_c,
    #test_exponential_smoothing_vectorized_dataset_c,
    #test_exponential_smoothing_vectorized_parallel_dataset_c,
    # Dataset D
    #test_exponential_smoothing_basic_dataset_d,
    #test_exponential_smoothing_vectorized_dataset_d,
    #test_exponential_smoothing_vectorized_parallel_dataset_d,
    # Dataset E
    #test_exponential_smoothing_basic_dataset_e,
    #test_exponential_smoothing_vectorized_dataset_e,
    #test_exponential_smoothing_vectorized_parallel_dataset_e,
    # Dataset F
    #test_exponential_smoothing_basic_dataset_f,
    #test_exponential_smoothing_vectorized_dataset_f,
    #test_exponential_smoothing_vectorized_parallel_dataset_f
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
