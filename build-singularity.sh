#!/bin/bash

docker build -t cloud-project-jupyter .

# For now, build Singularity images locally.

docker run \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(pwd):/output \
--privileged -t --rm \
quay.io/singularity/docker2singularity \
cloud-project-jupyter

