#!/bin/bash
#SBATCH --cpus-per-task=7
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --job-name=daskworker
###SBATCH --constraint=cascade,mem192 # NESH
#SBATCH --constraint=skylake,mem192 # NESH

module load singularity/3.6.4

singularity run \
--bind /gxfs_work1/geomar/smomw260/github/ESM-VFC-cloud-project \
--bind /scratch \
/gxfs_home/geomar/smomw260/github/ESM-VFC-cloud-project/performance/pangeo-notebook_2021.07.17.sif \
dask-worker 172.18.4.12:46517 --interface ib0 --nthreads 7 --memory-limit 32GiB
