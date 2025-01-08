# Load necessary libraries
library(parallel)
library(data.table)
library(pryr)

library(profmem)



# Load the functions from the specified file
source('/Users/niklas/Documents/GitHub/MasterThesis/BasicExponentialSmoothing/ExpS_R.R')

# Load the datasets
#data_a <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', skip = 1)$V1
#data_b <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv', skip = 1)$V1
#data_c <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv', skip = 1)$V1
#data_d <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv', skip = 1)$V1
#data_e <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv', skip = 1)$V1
#data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv', skip = 1)$V1

data_a <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv', skip = 0)$V1
data_b <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv', skip = 0)$V1
data_c <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv', skip = 0)$V1
data_d <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv', skip = 0)$V1
data_e <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv', skip = 0)$V1
data_f <- fread('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv', skip = 0)$V1

# Define the parameters for testing
alpha <- 0.7
number_of_executions <- 1

# Expected outputs
expected_output_a <- 9.729056156830051
expected_output_b <- 33.09027077319566
expected_output_c <- 98.77752694571055
expected_output_d <- 11.475341948013103 #temp delhi
expected_output_e <- 233.27015019545632 #stock microsoft
expected_output_f <- 26390.068709835385 #NYC Taxi

# Initialize counters
passed_tests <- 0
failed_tests <- 0

# Define the test functions

# Dataset A
#################################################
test_exponential_smoothing_basic_dataset_a <- function() {
  memory_profile <- profmem({  
    result <- exponential_smoothing_basic(data_a, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_a) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_A: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_A: FAILED\n")
    return(FALSE)
  }
gc()
}

test_exponential_smoothing_vectorized_dataset_a <- function() {
  memory_profile <- profmem({
      result <- exponential_smoothing_vectorized(data_a, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb2 <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_a) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_A: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb2, "mb\n\n")
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_A: FAILED\n")
    return(FALSE)
  }
gc()
}

test_exponential_smoothing_vectorized_parallel_dataset_a <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_a, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb3 <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_a) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_A: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb3, "mb\n\n")
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_A: FAILED\n")
    return(FALSE)
  }
gc()
}


# Dataset B
#################################################
test_exponential_smoothing_basic_dataset_b <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_basic(data_b, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_B: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_B: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_dataset_b <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_vectorized(data_b, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6  
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_B: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_B: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_parallel_dataset_b <- function() {
memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_b, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_b) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_parallel_dataset_B: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")    
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_parallel_dataset_B: FAILED\n")
    cat("smoothed_value: ", smoothed_value, "\n\n")
    return(FALSE)
  }
}


#Dataset C
#################################################
test_exponential_smoothing_basic_dataset_c <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_basic(data_c, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_c) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_C: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")    
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_C: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_dataset_c <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_vectorized(data_c, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_c) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_C: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")   
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_C: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_parallel_dataset_c <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_c, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_c) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_C: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")   
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_C: FAILED\n")
    return(FALSE)
  }
}

#Dataset D
#################################################
test_exponential_smoothing_basic_dataset_d <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_basic(data_d, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_d) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_D: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")   
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_D: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_dataset_d <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_vectorized(data_d, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_d) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_D: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")       
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_D: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_parallel_dataset_d <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_d, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_d) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_D: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")       
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_D: FAILED\n")
    return(FALSE)
  }
}

#Dataset E
#################################################
test_exponential_smoothing_basic_dataset_e <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_basic(data_e, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_e) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_E: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")   
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_E: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_dataset_e <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_vectorized(data_e, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_e) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_E: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")  
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_E: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_parallel_dataset_e <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_e, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_e) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_E: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")      
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_E: FAILED\n")
    return(FALSE)
  }
}

#Dataset F
#################################################
test_exponential_smoothing_basic_dataset_f <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_basic(data_f, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_f) < 0.0000000005) {
    cat("test_exponential_smoothing_basic_dataset_F: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")    
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_basic_dataset_F: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_dataset_f <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_vectorized(data_f, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_f) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_dataset_F: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")    
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_dataset_F: FAILED\n")
    return(FALSE)
  }
}

test_exponential_smoothing_vectorized_parallel_dataset_f <- function() {
  memory_profile <- profmem({
    result <- exponential_smoothing_parallel_vectorized(data_f, alpha, number_of_executions)
  })
  total_memory_used <- sum(memory_profile$bytes)
  total_memory_mb <- total_memory_used / 1e6
  smoothed_value <- result$smoothed_value
  function_time <- result$function_time
  if (abs(smoothed_value - expected_output_f) < 0.0000000005) {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_F: PASSED\n")
    cat("smoothed_value: ", smoothed_value, "\n")
    cat("function executed in: ", function_time, "seconds.\n")
    cat("Total memory used:", total_memory_mb, "mb\n\n")     
    return(TRUE)
  } else {
    cat("test_exponential_smoothing_vectorized_parallel_dataset_F: FAILED\n")
    return(FALSE)
  }
}


################################################################################################### # nolint

cat("\n### Simple Exponential Smoothing Experiments:\n\n")
gc()
# Run the tests and count the results
tests <- list(
  # Dataset A
  test_exponential_smoothing_basic_dataset_a,
  test_exponential_smoothing_vectorized_dataset_a,
  test_exponential_smoothing_vectorized_parallel_dataset_a,
  # Dataset B
  test_exponential_smoothing_basic_dataset_b,
  test_exponential_smoothing_vectorized_dataset_b,
  test_exponential_smoothing_vectorized_parallel_dataset_b,
  # Dataset C
  test_exponential_smoothing_basic_dataset_c,
  test_exponential_smoothing_vectorized_dataset_c,
  test_exponential_smoothing_vectorized_parallel_dataset_c,
  # Dataset D
  test_exponential_smoothing_basic_dataset_d,
  test_exponential_smoothing_vectorized_dataset_d,
  test_exponential_smoothing_vectorized_parallel_dataset_d,
  # Dataset E
  test_exponential_smoothing_basic_dataset_e,
  test_exponential_smoothing_vectorized_dataset_e,
  test_exponential_smoothing_vectorized_parallel_dataset_e,
  # Dataset F
  test_exponential_smoothing_basic_dataset_f,
  test_exponential_smoothing_vectorized_dataset_f,
  test_exponential_smoothing_vectorized_parallel_dataset_f 
)




for (test in tests) {
  if (test()) {
    passed_tests <- passed_tests + 1
  } else {
    failed_tests <- failed_tests + 1
  }
}

cat("Total tests passed:", passed_tests, "\n")
cat("Total tests failed:", failed_tests, "\n")