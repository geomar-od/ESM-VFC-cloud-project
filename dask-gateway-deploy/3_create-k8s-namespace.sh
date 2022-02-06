#!/bin/bash

source config.sh

if [[ ${ALONGSIDE_JUPYTERHUB} == 0 ]]; then

  kubectl create namespace ${K8S_NAMESPACE}

fi
