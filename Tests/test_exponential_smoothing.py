import numpy as np
import pytest

from BasicExponentialSmoothing.ExpS_Numpy import (
    exponential_smoothing_basic,
    exponential_smoothing_vectorized,
    #exponential_smoothing_parallel,
    exponential_smoothing_parallel_vectorized
)

#################################################
# Dataset A - Wind speed

# Load the dataset
#data_a = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/wind_speed_small.csv', delimiter=',', skip_header=1)   
data_a = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/wind_speed.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
expected_output_a = 9.729056156830051

def test_exponential_smoothing_basic_dataset_a():
    smoothed_value, function_time = exponential_smoothing_basic(data_a, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_a, 0.0000000005), f"Expected {expected_output_a}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_a")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_a():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_a, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_a, 0.0000000005), f"Expected {expected_output_a}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_a")
    print(f"Function execution time: {function_time} seconds\n")

#def test_exponential_smoothing_basic_parallel_dataset_a():
#    smoothed_value, function_time = exponential_smoothing_parallel(data_a, alpha, number_of_executions)
#    assert np.allclose(smoothed_value, expected_output_a, 0.0000000005), f"Expected {expected_output_a}, but got {smoothed_value}"
#    print(f"test_exponential_smoothing_basic_parallel_dataset_a")
#    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_a():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_a, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_a, 0.0000000005), f"Expected {expected_output_a}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_a")
    print(f"Function execution time: {function_time} seconds\n")

"""    
#################################################
# Dataset B - Energy generation solar

# Load the dataset
#data_b = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv', delimiter=',', skip_header=1)   
data_b = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/energy_generation_solar.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
expected_output_b = 33.09027077319566


def test_exponential_smoothing_basic_dataset_b():
    smoothed_value, function_time = exponential_smoothing_basic(data_b, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_b")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_b():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_b, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_b")
    print(f"Function execution time: {function_time} seconds\n")

#def test_exponential_smoothing_basic_parallel_dataset_b():
#    smoothed_value, function_time = exponential_smoothing_parallel(data_b, alpha, number_of_executions)
#    assert np.allclose(smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {smoothed_value}"
#    print(f"test_exponential_smoothing_basic_parallel_dataset_b")
#    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_b():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_b, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_b")
    print(f"Function execution time: {function_time} seconds\n")



#################################################
# Dataset C - Heart rate

# Load the dataset
#data_c = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/heart_rate_small.csv', delimiter=',', skip_header=1) 
data_c = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/heart_rate.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
# For heart_rate_small last smoothed value
expected_output_c = 98.77752694571055


def test_exponential_smoothing_basic_dataset_c():
    smoothed_value, function_time = exponential_smoothing_basic(data_c, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_c, 0.0000000005), f"Expected {expected_output_c}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_c")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_c():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_c, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_c, 0.0000000005), f"Expected {expected_output_c}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_c")
    print(f"Function execution time: {function_time} seconds\n")

#def test_exponential_smoothing_basic_parallel_dataset_c():
#    smoothed_value, function_time = exponential_smoothing_parallel(data_c, alpha, number_of_executions)
#    assert np.allclose(smoothed_value, expected_output_c, 0.0000000005), f"Expected {expected_output_c}, but got {smoothed_value}"
#    print(f"test_exponential_smoothing_basic_parallel_dataset_c")
#    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_c():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_c, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_c, 0.0000000005), f"Expected {expected_output_c}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_c")
    print(f"Function execution time: {function_time} seconds\n")



#################################################
# Dataset D

# Load the dataset
#data_d = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/temperature_delhi_small.csv', delimiter=',', skip_header=1)   
data_d = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/temperature_delhi.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
expected_output_d = 11.475341948013103


def test_exponential_smoothing_basic_dataset_d():
    smoothed_value, function_time = exponential_smoothing_basic(data_d, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_d, 0.0000000005), f"Expected {expected_output_d}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_d")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_d():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_d, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_d, 0.0000000005), f"Expected {expected_output_d}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_d")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_d():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_d, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_d, 0.0000000005), f"Expected {expected_output_d}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_d")
    print(f"Function execution time: {function_time} seconds\n")


#################################################
# Dataset E

# Load the dataset
#data_e = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/stock_open_microsoft.csv', delimiter=',', skip_header=1)   
data_e = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/stock_open_microsoft.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
expected_output_e = 233.27015019545632


def test_exponential_smoothing_basic_dataset_e():
    smoothed_value, function_time = exponential_smoothing_basic(data_e, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_e, 0.0000000005), f"Expected {expected_output_e}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_e")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_e():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_e, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_e, 0.0000000005), f"Expected {expected_output_e}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_e")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_e():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_e, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_e, 0.0000000005), f"Expected {expected_output_e}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_e")
    print(f"Function execution time: {function_time} seconds\n")

#################################################
# Dataset F

# Load the dataset
#data_f = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/nyctaxitraffic_small.csv', delimiter=',', skip_header=1)   
data_f = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/replicated_preprocessed_data_files/nyctaxitraffic.csv', delimiter=',', skip_header=1)   

# Define the parameters for testing
alpha = 0.7
number_of_executions = 10
expected_output_f = 26390.068709835385


def test_exponential_smoothing_basic_dataset_f():
    smoothed_value, function_time = exponential_smoothing_basic(data_f, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_f, 0.0000000005), f"Expected {expected_output_f}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_basic_dataset_f")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_dataset_f():
    smoothed_value, function_time = exponential_smoothing_vectorized(data_f, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_f, 0.0000000005), f"Expected {expected_output_f}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_dataset_f")
    print(f"Function execution time: {function_time} seconds\n")

def test_exponential_smoothing_vectorized_parallel_dataset_f():
    smoothed_value, function_time = exponential_smoothing_parallel_vectorized(data_f, alpha, number_of_executions)
    assert np.allclose(smoothed_value, expected_output_f, 0.0000000005), f"Expected {expected_output_f}, but got {smoothed_value}"
    print(f"test_exponential_smoothing_vectorized_parallel_dataset_f")
    print(f"Function execution time: {function_time} seconds\n")
"""
