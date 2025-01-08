using CSV
using DataFrames
using Dates

# Load the functions from the specified file
include("/Users/niklas/Documents/GitHub/MasterThesis/Arima/arima_functions.jl")

# # Load the datasets
# data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", DataFrame)[:, 1]
# data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv", DataFrame)[:, 1]
# data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv", DataFrame)[:, 1]
# data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv", DataFrame)[:, 1]
# data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
# data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv", DataFrame)[:, 1]

data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv", DataFrame)[:, 1]
data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv", DataFrame)[:, 1]
data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv", DataFrame)[:, 1]
data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv", DataFrame)[:, 1]
data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv", DataFrame)[:, 1]

# Define the parameters for testing
lags = 2
vector = [0.9208, -0.0111, 0.0766]
order = 1
theta = [0.3, 0.3]

# Expected outputs
expected_output_ar_a = 8.42711736
expected_output_integrated_a = 0.55796623
expected_output_ma_a = 8.25047461
expected_output_complete_a = 3.059677

expected_output_ar_b = 33.09027077
expected_output_integrated_b = 1.23456789
expected_output_ma_b = 33.56789012
expected_output_complete_b = 61.78846

expected_output_ar_c = 98.77752695
expected_output_integrated_c = 2.34567890
expected_output_ma_c = 99.12345678
expected_output_complete_c = -6.16423

expected_output_complete_d = -1.066503

expected_output_complete_e = 6.920413

expected_output_complete_f = 1143.753

# Initialize counters
passed_tests = 0
failed_tests = 0

#################################################
# Dataset A

function test_arima_complete_basic_dataset_a()
    start_time = now()
    integrated_data = integrated_component_basic(data_a, order)
    forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
    result = moving_average_component_basic(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_a = result[end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    if abs(last_result_a - expected_output_complete_a) < 0.00005
      println("test_arima_complete_basic_dataset_a: PASSED: ", last_result_a)
      println("execution time:", execution_time)
      return true
    else
      println("test_arima_complete_basic_dataset_a: FAILED")
      println(last_result_a)
      return false
    end
end
  
function test_arima_complete_vectorized_dataset_a()
    start_time = now()
    integrated_data = integrated_component_vectorized_v3(data_a, order)
    forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
    result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_a = result[end, end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    println(last_result_a)
    if abs(last_result_a - expected_output_complete_a) < 0.00005
        println("test_arima_complete_vectorized_dataset_a: PASSED: ", last_result_a)
        println("execution time:", execution_time)
        return true
    else
        println("test_arima_complete_vectorized_dataset_a: FAILED")
        println(last_result_a)
        return false
    end
end

#################################################
# Dataset B

function test_arima_complete_basic_dataset_b()
    start_time = now()
    integrated_data = integrated_component_basic(data_b, order)
    forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
    result = moving_average_component_basic(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_b = result[end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    if abs(last_result_b - expected_output_complete_b) < 0.00005
      println("test_arima_complete_basic_dataset_b: PASSED: ", last_result_b)
      println("execution time:", execution_time)
      return true
    else
      println("test_arima_complete_basic_dataset_b: FAILED")
      println(last_result_b)
      return false
    end
end

function test_arima_complete_vectorized_dataset_b()
    start_time = now()
    integrated_data = integrated_component_vectorized_v3(data_b, order)
    forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
    result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_b = result[end, end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    println(last_result_b)
    if abs(last_result_b - expected_output_complete_b) < 0.00005
        println("test_arima_complete_vectorized_dataset_b: PASSED: ", last_result_b)
        println("execution time:", execution_time)
        return true
    else
        println("test_arima_complete_vectorized_dataset_b: FAILED")
        println(last_result_b)
        return false
    end
end


#################################################
# Dataset C

function test_arima_complete_basic_dataset_c()
    start_time = now()
    integrated_data = integrated_component_basic(data_c, order)
    forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
    result = moving_average_component_basic(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_c = result[end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    if abs(last_result_c - expected_output_complete_c) < 0.00005
      println("test_arima_complete_basic_dataset_c: PASSED: ", last_result_c)
      println("execution time:", execution_time)
      return true
    else
      println("test_arima_complete_basic_dataset_c: FAILED")
      println(last_result_c)
      return false
    end
end
  
function test_arima_complete_vectorized_dataset_c()
    start_time = now()
    integrated_data = integrated_component_vectorized_v3(data_c, order)
    forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
    result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
    last_result_c = result[end, end]
    end_time = now()
    execution_time = Dates.value(end_time - start_time) / 1000
    println(last_result_c)
    if abs(last_result_c - expected_output_complete_c) < 0.00005
        println("test_arima_complete_vectorized_dataset_c: PASSED: ", last_result_c)
        println("execution time:", execution_time)
        return true
    else
        println("test_arima_complete_vectorized_dataset_c: FAILED")
        println(last_result_c)
        return false
    end
end


#################################################
# Dataset D

function test_arima_complete_basic_dataset_d()
  start_time = now()
  integrated_data = integrated_component_basic_v3(data_d, order)
  forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
  result = moving_average_component_basic_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_d = result[end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  if abs(last_result_d - expected_output_complete_d) < 0.00005
    println("test_arima_complete_basic_dataset_d: PASSED: ", last_result_d)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_basic_dataset_d: FAILED")
    println(last_result_d)
    return false
  end
end

function test_arima_complete_vectorized_dataset_d()
  start_time = now()
  integrated_data = integrated_component_vectorized_v3(data_d, order)
  forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
  result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_d = result[end, end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  println(last_result_d)
  if abs(last_result_d - expected_output_complete_d) < 0.00005
    println("test_arima_complete_vectorized_dataset_d: PASSED: ", last_result_d)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_vectorized_dataset_d: FAILED")
    println(last_result_d)
    return false
  end
end

#################################################
# Dataset E

function test_arima_complete_basic_dataset_e()
  start_time = now()
  integrated_data = integrated_component_basic(data_e, order)
  forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
  result = moving_average_component_basic(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_e = result[end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  if abs(last_result_e - expected_output_complete_e) < 0.00005
    println("test_arima_complete_basic_dataset_e: PASSED: ", last_result_e)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_basic_dataset_e: FAILED")
    println(last_result_e)
    return false
  end
end

function test_arima_complete_vectorized_dataset_e()
  start_time = now()
  integrated_data = integrated_component_vectorized_v3(data_e, order)
  forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
  result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_e = result[end, end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  println(last_result_e)
  if abs(last_result_e - expected_output_complete_e) < 0.00005
    println("test_arima_complete_vectorized_dataset_e: PASSED: ", last_result_e)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_vectorized_dataset_e: FAILED")
    println(last_result_e)
    println("execution time:", execution_time)
    return false
  end
end

#################################################
# Dataset F

function test_arima_complete_basic_dataset_f()
  start_time = now()
  integrated_data = integrated_component_basic(data_f, order)
  forecast_data = autoregressive_component_basic(integrated_data, lags, vector)
  result = moving_average_component_basic(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_f = result[end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  if abs(last_result_f - expected_output_complete_f) < 0.005
    println("test_arima_complete_basic_dataset_f: PASSED: ", last_result_f)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_basic_dataset_f: FAILED")
    println(last_result_f)
    return false
  end
end

function test_arima_complete_vectorized_dataset_f()
  start_time = now()
  integrated_data = integrated_component_vectorized_v3(data_f, order)
  forecast_data = autoregressive_component_vectorized(integrated_data, lags, vector)
  result = moving_average_component_vectorized_v3(integrated_data[lags + 1:end], forecast_data, lags, theta)
  last_result_f = result[end, end]
  end_time = now()
  execution_time = Dates.value(end_time - start_time) / 1000
  println(last_result_f)
  if abs(last_result_f - expected_output_complete_f) < 0.005
    println("test_arima_complete_vectorized_dataset_f: PASSED: ", last_result_f)
    println("execution time:", execution_time)
    return true
  else
    println("test_arima_complete_vectorized_dataset_f: FAILED")
    println(last_result_f)
    return false
  end
end

tests = [
    # Dataset A
    # test_arima_complete_basic_dataset_a,
    # test_arima_complete_vectorized_dataset_a

    # # # Dataset B
    # test_arima_complete_basic_dataset_b,
    # test_arima_complete_vectorized_dataset_b
  
    # # Dataset C
    # test_arima_complete_basic_dataset_c,
    # test_arima_complete_vectorized_dataset_c
  
    # # # Dataset D
    # test_arima_complete_basic_dataset_d,
    # test_arima_complete_vectorized_dataset_d

    # # # Dataset E
    # test_arima_complete_basic_dataset_e,
    # test_arima_complete_vectorized_dataset_e
  
    # # # Dataset F
    # test_arima_complete_basic_dataset_f
    test_arima_complete_vectorized_dataset_f
]

for test in tests
  if test()
    println("PASSED")
  else
    println("FAILED")
  end
end


##########
# ARCHIVE


# using CSV
# using DataFrames
# using Statistics

# include("/Users/niklas/Documents/GitHub/MasterThesis/Arima/arima_functions.jl")

# # Load the datasets
# #data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv", DataFrame)[:, 1]
# #data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv", DataFrame)[:, 1]
# #data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv", DataFrame)[:, 1]
# #data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv", DataFrame)[:, 1]
# #data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
# #data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv", DataFrame)[:, 1]

# data_a = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv", DataFrame)[:, 1]
# # data_b = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv", DataFrame)[:, 1]
# # data_c = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv", DataFrame)[:, 1]
# # data_d = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv", DataFrame)[:, 1]
# # data_e = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv", DataFrame)[:, 1]
# # data_f = CSV.read("/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv", DataFrame)[:, 1]

# # Define the parameters for testing
# lags = 2
# vector = [0.9208, -0.0111, 0.0766]
# order = 1
# theta = [0.3, 0.3]

# # Expected outputs
# expected_output_ar_a = 8.42711736
# expected_output_integrated_a = 0.55796623
# expected_output_ma_a = 8.250474608750341 #8.25047461

# expected_output_ar_b = 33.09027077
# expected_output_integrated_b = 1.23456789
# expected_output_ma_b = 33.56789012

# expected_output_ar_c = 98.77752695
# expected_output_integrated_c = 2.34567890
# expected_output_ma_c = 99.12345678

# # Initialize counters
# global passed_tests = 0
# global failed_tests = 0

# # Define the test functions for data_a
# function test_arima_autoregressive_component_basic_dataset_a()
#     start_time = time()
#     result = autoregressive_component_basic(data_a, lags, vector)
#     end_time = time()
#     function_time = end_time - start_time
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_a) < 0.00005
#         println("test_arima_autoregressive_component_basic_dataset_a: PASSED")
#         println(function_time)
#         return true
#     else
#         println("test_arima_autoregressive_component_basic_dataset_a: FAILED")
#         return false
#     end
# end

# function test_arima_autoregressive_component_vectorized_dataset_a()
#     start_time = time()
#     result = autoregressive_component_vectorized(data_a, lags, vector)
#     end_time = time()
#     function_time = end_time - start_time
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_a) < 0.00005
#         println("test_arima_autoregressive_component_vectorized_dataset_a: PASSED")
#         println(function_time)
#         return true
#     else
#         println("test_arima_autoregressive_component_vectorized_dataset_a: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_basic_dataset_a()
#     result = integrated_component_basic(data_a, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_a) < 0.00005
#         println("test_arima_integrated_component_basic_dataset_a: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_basic_dataset_a: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_vectorized_dataset_a()
#     result = integrated_component_vectorized(data_a, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_a) < 0.00005
#         println("test_arima_integrated_component_vectorized_dataset_a: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_vectorized_dataset_a: FAILED")
#         return false
#     end
# end

# function test_arima_moving_average_component_basic_dataset_a()
#     forecast_data = autoregressive_component_basic(data_a, lags, vector)
#     result = moving_average_component_basic(data_a[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_a) < 0.0000000005
#         println("test_arima_moving_average_component_basic_dataset_a: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_basic_dataset_a: FAILED")
#         println(last_result)
#         return false
#     end
# end

# function test_arima_moving_average_component_vectorized_dataset_a()
#     forecast_data = autoregressive_component_vectorized(data_a, lags, vector)
#     result = moving_average_component_vectorized(data_a[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_a) < 0.0000000005
#         println("test_arima_moving_average_component_vectorized_dataset_a: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_vectorized_dataset_a: FAILED")
#         println(last_result)
#         return false
#     end
# end


# # Define the test functions for data_b
# function test_arima_autoregressive_component_basic_dataset_b()
#     result = autoregressive_component_basic(data_b, lags, vector)
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_b) < 0.00005
#         println("test_arima_autoregressive_component_basic_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_autoregressive_component_basic_dataset_b: FAILED")
#         return false
#     end
# end

# function test_arima_autoregressive_component_vectorized_dataset_b()
#     result = autoregressive_component_vectorized(data_b, lags, vector)
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_b) < 0.00005
#         println("test_arima_autoregressive_component_vectorized_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_autoregressive_component_vectorized_dataset_b: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_basic_dataset_b()
#     result = integrated_component_basic(data_b, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_b) < 0.00005
#         println("test_arima_integrated_component_basic_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_basic_dataset_b: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_vectorized_dataset_b()
#     result = integrated_component_vectorized(data_b, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_b) < 0.00005
#         println("test_arima_integrated_component_vectorized_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_vectorized_dataset_b: FAILED")
#         return false
#     end
# end

# function test_arima_moving_average_component_basic_dataset_b()
#     forecast_data = autoregressive_component_basic(data_b, lags, vector)
#     result = moving_average_component_basic(data_b[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_b) < 0.0000000005
#         println("test_arima_moving_average_component_basic_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_basic_dataset_b: FAILED")
#         return false
#     end
# end

# function test_arima_moving_average_component_vectorized_dataset_b()
#     forecast_data = autoregressive_component_vectorized(data_b, lags, vector)
#     result = moving_average_component_vectorized(data_b[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_b) < 0.0000000005
#         println("test_arima_moving_average_component_vectorized_dataset_b: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_vectorized_dataset_b: FAILED")
#         return false
#     end
# end

# # Define the test functions for data_c
# function test_arima_autoregressive_component_basic_dataset_c()
#     result = autoregressive_component_basic(data_c, lags, vector)
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_c) < 0.00005
#         println("test_arima_autoregressive_component_basic_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_autoregressive_component_basic_dataset_c: FAILED")
#         return false
#     end
# end

# function test_arima_autoregressive_component_vectorized_dataset_c()
#     result = autoregressive_component_vectorized(data_c, lags, vector)
#     last_result = result[end]
#     if abs(last_result - expected_output_ar_c) < 0.00005
#         println("test_arima_autoregressive_component_vectorized_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_autoregressive_component_vectorized_dataset_c: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_basic_dataset_c()
#     result = integrated_component_basic(data_c, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_c) < 0.00005
#         println("test_arima_integrated_component_basic_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_basic_dataset_c: FAILED")
#         return false
#     end
# end

# function test_arima_integrated_component_vectorized_dataset_c()
#     result = integrated_component_vectorized(data_c, order)
#     last_result = result[end]
#     if abs(last_result - expected_output_integrated_c) < 0.00005
#         println("test_arima_integrated_component_vectorized_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_integrated_component_vectorized_dataset_c: FAILED")
#         return false
#     end
# end

# function test_arima_moving_average_component_basic_dataset_c()
#     forecast_data = autoregressive_component_basic(data_c, lags, vector)
#     result = moving_average_component_basic(data_c[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_c) < 0.0000000005
#         println("test_arima_moving_average_component_basic_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_basic_dataset_c: FAILED")
#         return false
#     end
# end

# function test_arima_moving_average_component_vectorized_dataset_c()
#     forecast_data = autoregressive_component_vectorized(data_c, lags, vector)
#     result = moving_average_component_vectorized(data_c[lags+1:end], forecast_data, lags, theta)
#     last_result = result[end]
#     if abs(last_result - expected_output_ma_c) < 0.0000000005
#         println("test_arima_moving_average_component_vectorized_dataset_c: PASSED")
#         return true
#     else
#         println("test_arima_moving_average_component_vectorized_dataset_c: FAILED")
#         return false
#     end
# end

# # Run the tests and count the results
# tests = [
#     test_arima_autoregressive_component_basic_dataset_a,
#     test_arima_autoregressive_component_vectorized_dataset_a
#     # test_arima_integrated_component_basic_dataset_a,
#     # test_arima_integrated_component_vectorized_dataset_a,
#     # test_arima_moving_average_component_basic_dataset_a,
#     # test_arima_moving_average_component_vectorized_dataset_a
#     # test_arima_autoregressive_component_basic_dataset_b,
#     # test_arima_autoregressive_component_vectorized_dataset_b,
#     # test_arima_integrated_component_basic_dataset_b,
#     # test_arima_integrated_component_vectorized_dataset_b,
#     # test_arima_moving_average_component_basic_dataset_b,
#     # test_arima_moving_average_component_vectorized_dataset_b,
#     # test_arima_autoregressive_component_basic_dataset_c,
#     # test_arima_autoregressive_component_vectorized_dataset_c,
#     # test_arima_integrated_component_basic_dataset_c,
#     # test_arima_integrated_component_vectorized_dataset_c,
#     # test_arima_moving_average_component_basic_dataset_c,
#     # test_arima_moving_average_component_vectorized_dataset_c,

#     #test_arima_moving_average_component_vectorized_v2_dataset_a
# ]

# for test in tests
#     global passed_tests
#     global failed_tests
#     if test()
#         passed_tests += 1
#     else
#         failed_tests += 1
#     end
# end

# println("Total tests passed: ", passed_tests)
# println("Total tests failed: ", failed_tests)

