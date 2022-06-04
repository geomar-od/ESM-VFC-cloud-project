
# Specify workload.

import numpy, dask.array

def calculate_pi(size_in_terabytes, chunk_size_in_megabytes):
    """Calculate pi using a Monte Carlo method."""

    total_array_size = (int(size_in_terabytes * 1e12 / 8 / 2), 2)
    number_of_tasks = (size_in_terabytes * 1e12) / (chunk_size_in_megabytes * 1e6)
    array_chunk_size = (int(total_array_size[0] / number_of_tasks), 2)

    xy = dask.array.random.uniform(
        low=0.0, high=1.0,
        size=total_array_size,
        chunks=array_chunk_size
    )

    xy_inside_circle = (xy ** 2).sum(axis=1) < 1

    pi = 4 * xy_inside_circle.mean()

    return pi
