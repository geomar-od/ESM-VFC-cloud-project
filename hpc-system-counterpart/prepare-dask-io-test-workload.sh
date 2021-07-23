
module load singularity/3.5.2
singularity run --bind $WORK/github/ESM-VFC-cloud-project pangeo-notebook_2021.07.17.sif jupyter lab --no-browser --ip 0.0.0.0 

