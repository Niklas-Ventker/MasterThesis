import numpy as np
import pytest

from HoltWinters.HoltWinters import (
    triple_exponential_smoothing_basic,
    triple_exponential_smoothing_vectorized,
    triple_exponential_smoothing_basic_parallelized,
    triple_exponential_smoothing_vectorized_parallelized
)

#################################################
# Only Datasets with Saisonal Characteristics!
# Dataset B - Energy Generation Solar

# Load the dataset
data_b = np.genfromtxt('/Users/niklas/Documents/GitHub/MasterThesis/0_Data_files/preprocessed_data_files/energy_generation_solar_small.csv', delimiter=',', skip_header=1)   
# Define the parameters for testing
alpha = 0.2
beta = 0.1
gamma = 0.3
season_length = 24
#number_of_executions = 10
# For wind_speed_small last smoothed value
expected_output_b = 90.60914407238147


def test_triple_exponential_smoothing_basic_dataset_b():
    smoothed = triple_exponential_smoothing_basic(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[-1]
    assert np.allclose(last_smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {last_smoothed_value}"
    

def test_triple_exponential_smoothing_vectorized_dataset_b():
    smoothed = triple_exponential_smoothing_vectorized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[-1]
    assert np.allclose(last_smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {last_smoothed_value}"


def test_triple_exponential_smoothing_basic_parallelized_dataset_b():
    smoothed = triple_exponential_smoothing_basic_parallelized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[-1]
    assert np.allclose(last_smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {last_smoothed_value}"


def test_triple_exponential_smoothing_vectorized_parallelized_dataset_b():
    smoothed = triple_exponential_smoothing_vectorized_parallelized(data_b, alpha, beta, gamma, season_length)
    last_smoothed_value = smoothed[-1]
    assert np.allclose(last_smoothed_value, expected_output_b, 0.0000000005), f"Expected {expected_output_b}, but got {last_smoothed_value}"