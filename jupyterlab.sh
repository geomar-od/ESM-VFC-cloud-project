#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=02:15:00
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --job-name=jupyterlab

module load singularity/3.6.4

singularity run \
--bind /gxfs_work1/geomar/smomw355/model_data/ocean-only/VIKING20X.L46-KFS003/nemo \
--bind /gxfs_work1/geomar/smomw260/github/NEMO-to-cloud \
--bind /scratch \
cloud-project-jupyter-2021-04-01-7aa253e171d6.sif \
--notebook-dir=$(pwd)

