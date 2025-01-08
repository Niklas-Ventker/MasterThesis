using CSV
using DataFrames
using Statistics
using Base.Threads

function exponential_smoothing_basic(data::Vector{Float64}, alpha::Float64, number_of_executions::Int)
    execution_times = Float64[]
    smoothed_value = 0.0
    for _ in 1:number_of_executions
        start_time = time()
        smoothed_value = data[1]
        for j in 2:length(data)
            smoothed_value = alpha * data[j] + (1 - alpha) * smoothed_value
        end
        end_time = time()
        push!(execution_times, end_time - start_time)
    end
    function_time = median(execution_times)
    return smoothed_value, function_time
end

function exponential_smoothing_vectorized(data::Vector{Float64}, alpha::Float64, number_of_executions::Int)
    execution_times = Float64[]
    smoothed_value = 0.0
    for _ in 1:number_of_executions
        start_time = time()
        n = length(data)
        weights = alpha * (1 - alpha) .^ (n-1:-1:0)
        smoothed = cumsum(weights .* data)
        smoothed_value = smoothed[end] / sum(weights)
        end_time = time()
        function_times = end_time - start_time
        push!(execution_times, function_times)
        println("function executed in: ", function_times, " seconds.\n")
    end
    function_time = median(execution_times)
    return smoothed_value, function_time
end

function exponential_smoothing_parallel(data::Vector{Float64}, alpha::Float64, number_of_executions::Int)
    execution_times = Float64[]
    smoothed_value = 0.0
    for _ in 1:number_of_executions
        start_time = time()
        smoothed_value = data[1]
        @threads for i in 2:length(data)
            smoothed_value = alpha * data[i] + (1 - alpha) * smoothed_value
        end
        end_time = time()
        push!(execution_times, end_time - start_time)
    end
    function_time = mean(execution_times)
    return smoothed_value, function_time
end

function exponential_smoothing_parallel_vectorized(data::Vector{Float64}, alpha::Float64, number_of_executions::Int)
    execution_times = Float64[]
    smoothed_value = 0.0
    for _ in 1:number_of_executions
        start_time = time()
        n = length(data)
        weights = alpha * (1 - alpha) .^ (n-1:-1:0)
        smoothed = cumsum(weights .* data)
        smoothed_value = smoothed[end] / sum(weights)
        end_time = time()
        push!(execution_times, end_time - start_time)
    end
    function_time = median(execution_times)
    return smoothed_value, function_time
end
