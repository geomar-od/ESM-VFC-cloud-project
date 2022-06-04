#!/bin/bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=00:45:00
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --job-name=jupyterlab
###SBATCH --constraint=cascade,mem192 # NESH
#SBATCH --constraint=skylake,mem192 # NESH

module load singularity/3.6.4

singularity run \
--bind /gxfs_work1/geomar/smomw260/github/ESM-VFC-cloud-project \
--bind /scratch \
pangeo-notebook_2021.07.17.sif \
jupyter lab --no-browser --ip 0.0.0.0

