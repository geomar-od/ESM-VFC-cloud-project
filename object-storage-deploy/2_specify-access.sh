
source config.sh

# Make bucket objects publicly available.
# https://cloud.google.com/storage/docs/access-control/making-data-public

#gsutil iam ch allUsers:legacyObjectReader gs://${GCP_BUCKET_NAME}
#gsutil iam get gs://${GCP_BUCKET_NAME}

#gsutil iam ch -d allUsers gs://${GCP_BUCKET_NAME}
#gsutil iam get gs://${GCP_BUCKET_NAME}

# Create GCP project-wide IAM service account for this bucket.
# It will be "impersonated" by Google workload identities specified in the Kubernetes cluster part.
# https://cloud.google.com/storage/docs/access-control/using-iam-permissions
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

gcloud iam service-accounts create ${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME_PREFIX}

# Note, that xarray.open_zarr() needs at least objects.get and objects.list access:
# Legacy Bucket Reader: xxxxx@xxxxx.iam.gserviceaccount.com does not have storage.objects.get access to the Google Cloud Storage object.
# Legacy Object Reader: xxxxx@xxxxx.iam.gserviceaccount.com does not have storage.objects.list access to the Google Cloud Storage bucket.

# Assign access-levels to the above service account.
# Thinking about the least-privilege principle, we choose legacy access-types for now.
# https://cloud.google.com/storage/docs/access-control/iam-roles
# https://cloud.google.com/iam/help/members/types

gsutil iam ch serviceAccount:${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME}:legacyObjectReader gs://${GCP_BUCKET_NAME} # storage.objects.get
gsutil iam ch serviceAccount:${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME}:legacyBucketReader gs://${GCP_BUCKET_NAME} # storage.buckets.get, storage.objects.list
gsutil iam get gs://${GCP_BUCKET_NAME}

#gsutil iam ch -d serviceAccount:${GCP_BUCKET_IAM_SERVICE_ACCOUNT_NAME}:legacyObjectReader,legacyBucketReader gs://${GCP_BUCKET_NAME}
#gsutil iam get gs://${GCP_BUCKET_NAME}
