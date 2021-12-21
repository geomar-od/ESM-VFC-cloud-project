#!/bin/bash

source config.sh

WORKLOAD_IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_NAME}

IAM_SERVICE_ACCOUNT_PREFIX=jupyterhub2-requester-pays
IAM_SERVICE_ACCOUNT_SUFFIX=${GCP_BILLING_PROJECT}.iam.gserviceaccount.com # Don't change.
IAM_SERVICE_ACCOUNT_NAME=${IAM_SERVICE_ACCOUNT_PREFIX}@${IAM_SERVICE_ACCOUNT_SUFFIX} # Don't change.

# List already available service accounts.

gcloud iam service-accounts list

# Create project-wide Google service account.

gcloud iam service-accounts create \
  ${IAM_SERVICE_ACCOUNT_PREFIX}

# Grant the above service account serviceUsageConsumer access to the GCP project.
# https://cloud.google.com/storage/docs/requester-pays#requirements
# https://cloud.google.com/service-usage/docs/access-control#predefined_roles
# The project used in the request must be in good standing, and the user must have a role in the project that contains the serviceusage.services.use permission.
# The Service Usage Consumer role contains the required permission.
# https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating

gcloud projects add-iam-policy-binding \
  ${GCP_BILLING_PROJECT} \
  --member="serviceAccount:${IAM_SERVICE_ACCOUNT_NAME}" \
  --role="roles/serviceusage.serviceUsageConsumer"

# Grant the workload identity service account roles/iam.serviceAccountUser access to the "requester pays" service account.
# https://cloud.google.com/iam/docs/impersonating-service-accounts#allow-impersonation
# Note, we have to do implement "requester pays" functionality via chaining service accounts, because KubeSpawner which is used by Z2JH only supports specifying up to one service account.
# We could have also added the serviceusage.serviceUsageConsumer role directly to the workload identity service account, but I'd like to keep things separately here.
# https://zero-to-jupyterhub.readthedocs.io/en/latest/resources/reference.html#singleuser-serviceaccountname
# https://jupyterhub-kubespawner.readthedocs.io/en/latest/spawner.html

gcloud iam service-accounts add-iam-policy-binding \
  ${IAM_SERVICE_ACCOUNT_NAME} \
  --member "serviceAccount:${WORKLOAD_IAM_SERVICE_ACCOUNT_NAME}" \
  --role roles/iam.serviceAccountUser

# List available service accounts.

gcloud iam service-accounts list
