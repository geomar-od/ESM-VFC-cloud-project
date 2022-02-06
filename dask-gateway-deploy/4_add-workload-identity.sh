#!/bin/bash

source config.sh

if [[ ${ALONGSIDE_JUPYTERHUB} == 0 ]]; then

  # Create project-wide Google service account.

  gcloud iam service-accounts create \
    ${IAM_SERVICE_ACCOUNT_PREFIX}

  # Create Kubernetes cluster service account.

  kubectl create serviceaccount ${IAM_SERVICE_ACCOUNT_PREFIX} \
    --namespace ${K8S_NAMESPACE}

  # Allow the Kubernetes service account to impersonate the Google service account.
  # Note, if this IAM binding does not exist, the Pod will not be able to use the Google service account.

  gcloud iam service-accounts add-iam-policy-binding \
    ${IAM_SERVICE_ACCOUNT_NAME} \
    --member "serviceAccount:${GKE_WORKLOAD_POOL}[${K8S_NAMESPACE}/${IAM_SERVICE_ACCOUNT_PREFIX}]" \
    --role roles/iam.workloadIdentityUser

  # Annotate the Kubernetes cluster with the Google IAM service account.

  kubectl annotate serviceaccount ${IAM_SERVICE_ACCOUNT_PREFIX} \
    iam.gke.io/gcp-service-account=${IAM_SERVICE_ACCOUNT_NAME} \
    --namespace ${K8S_NAMESPACE} \
    --overwrite

fi
