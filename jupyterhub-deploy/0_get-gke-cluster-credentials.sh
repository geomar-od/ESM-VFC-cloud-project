#!/bin/bash

source config.sh

gcloud container clusters \
  get-credentials ${GKE_CLUSTER_NAME} \
  --zone ${GCP_RESOURCE_ZONE}
