using Base.Threads

function triple_exponential_smoothing_basic(data::Vector{Float64}, alpha::Float64, beta::Float64, gamma::Float64, season_length::Int)
    n = length(data)

    # Initialize arrays
    level = zeros(Float64, n)
    trend = zeros(Float64, n)
    season = zeros(Float64, season_length)
    smoothed = zeros(Float64, n)

    # Initial values
    level[1] = data[1]
    trend[1] = data[2] - data[1]
    season[1:season_length] .= data[1:season_length] .- level[1]

    if season_length == 0
        season_length = n
    end

    # Calculate level, trend, and season components
    for t in 2:n
        if t > season_length
            level[t] = alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t-1] + trend[t-1])
            trend[t] = beta * (level[t] - level[t-1]) + (1 - beta) * trend[t-1]
            season_index = t - season_length
            season[t % season_length == 0 ? season_length : t % season_length] = gamma * (data[t] - level[t]) + (1 - gamma) * season[season_index]
        else
            level[t] = alpha * data[t] + (1 - alpha) * (level[t-1] + trend[t-1])
            trend[t] = beta * (level[t] - level[t-1]) + (1 - beta) * trend[t-1]
        end
        smoothed[t] = level[t] + trend[t] + season[t % season_length == 0 ? season_length : t % season_length]
    end

    return smoothed
end



function triple_exponential_smoothing_vectorized(data::Vector{Float64}, alpha::Float64, beta::Float64, gamma::Float64, season_length::Int)
    n = length(data)

    # Initialize arrays
    level = zeros(Float64, n)
    trend = zeros(Float64, n)
    season = zeros(Float64, season_length)
    smoothed = zeros(Float64, n)

    # Initial values
    level[1] = data[1]
    trend[1] = data[2] - data[1]
    season[1:season_length] .= data[1:season_length] .- level[1]

    # Vectorized approach for each season
    for season_start in 1:season_length:n
        season_end = min(season_start + season_length - 1, n)
        season_indices = season_start:season_end
        
        # Calculate level
        level_weights = alpha * (1 - alpha) .^ (0:(season_end - season_start))
        level_smoothed = reverse(cumsum(reverse(level_weights .* data[season_indices])))
        level[season_indices] .= level_smoothed / sum(level_weights)

        # Calculate trend
        trend_weights = beta * (1 - beta) .^ (0:(season_end - season_start))
        trend_smoothed = reverse(cumsum(reverse(trend_weights .* (level_smoothed .- circshift(level_smoothed, 1)))))
        trend[season_indices] .= trend_smoothed / sum(trend_weights)

        # Calculate season
        if season_start == 1
            season_weights = zeros(season_end - season_start + 1)
            season_smoothed = zeros(season_end - season_start + 1)
        else
            season_weights = gamma * (1 - gamma) .^ (0:(season_end - season_start))
            season_smoothed = reverse(cumsum(reverse(season_weights .* (data[season_indices] .- level_smoothed))))
            season[season_indices .% season_length .+ 1] .= season_smoothed / sum(season_weights)
        end

        smoothed[season_indices] .= level[season_indices] .+ trend[season_indices] .+ season[season_indices .% season_length .+ 1]
    end

    return smoothed
end


function triple_exponential_smoothing_basic_parallelized(data::Vector{Float64}, alpha::Float64, beta::Float64, gamma::Float64, season_length::Int)
    n = length(data)

    # Initialize arrays
    level = zeros(Float64, n)
    trend = zeros(Float64, n)
    season = zeros(Float64, n)
    smoothed = zeros(Float64, n)

    # Initial values
    level[1] = data[1]
    trend[1] = data[2] - data[1]
    season[1:season_length] .= data[1:season_length] .- level[1]

    if season_length == 0
        season_length = n
    end

    function compute_t(t)
        level_t = alpha * (data[t] - season[t - season_length]) + (1 - alpha) * (level[t-1] + trend[t-1])
        trend_t = beta * (level_t - level[t-1]) + (1 - beta) * trend[t-1]
        season_t = t > season_length ? gamma * (data[t] - level_t) + (1 - gamma) * season[t - season_length] : season[t]
        smoothed_t = level_t + trend_t + season[t % season_length == 0 ? season_length : t % season_length]
        return level_t, trend_t, season_t, smoothed_t
    end

    @threads for t in 2:n
        level[t], trend[t], season[t], smoothed[t] = compute_t(t)
    end

    return smoothed
end


function triple_exponential_smoothing_vectorized_parallelized(data::Vector{Float64}, alpha::Float64, beta::Float64, gamma::Float64, season_length::Int)
    n = length(data)

    # Initialize arrays
    level = zeros(Float64, n)
    trend = zeros(Float64, n)
    season = zeros(Float64, season_length)
    smoothed = zeros(Float64, n)

    # Initial values
    level[1] = data[1]
    trend[1] = data[2] - data[1]
    season[1:season_length] .= data[1:season_length] .- level[1]

    # Vectorized approach for each season
    @threads for season_start in 1:season_length:n
        season_end = min(season_start + season_length - 1, n)
        season_indices = season_start:season_end
        
        # Calculate level
        level_weights = alpha * (1 - alpha) .^ (0:(season_end - season_start))
        level_smoothed = reverse(cumsum(reverse(level_weights .* data[season_indices])))
        level[season_indices] .= level_smoothed / sum(level_weights)

        # Calculate trend
        trend_weights = beta * (1 - beta) .^ (0:(season_end - season_start))
        trend_smoothed = reverse(cumsum(reverse(trend_weights .* (level_smoothed .- circshift(level_smoothed, 1)))))
        trend[season_indices] .= trend_smoothed / sum(trend_weights)

        # Calculate season
        if season_start == 1
            season_weights = zeros(season_end - season_start + 1)
            season_smoothed = zeros(season_end - season_start + 1)
        else
            season_weights = gamma * (1 - gamma) .^ (0:(season_end - season_start))
            season_smoothed = reverse(cumsum(reverse(season_weights .* (data[season_indices] .- level_smoothed))))
            season[season_indices .% season_length .+ 1] .= season_smoothed / sum(season_weights)
        end

        smoothed[season_indices] .= level[season_indices] .+ trend[season_indices] .+ season[season_indices .% season_length .+ 1]
    end

    return smoothed
end

