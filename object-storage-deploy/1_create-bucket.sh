
source config.sh

# Make bucket.

# The -c and -l options specify the storage class and location, respectively,
# for the bucket. Once a bucket is created in a given location and with a
# given storage class, it cannot be moved to a different location, and the
# storage class cannot be changed. Instead, you would need to create a new
# bucket and move the data over and then delete the original bucket.
# https://cloud.google.com/storage/docs/quickstart-gsutil#create
# https://cloud.google.com/storage/docs/storage-classes

gsutil mb \
  -p ${GCP_BILLING_PROJECT} \
  -l ${GCP_BUCKET_LOCATION} \
  -c standard \
  gs://${GCP_BUCKET_NAME}

# Enforce public access prevention.

# Note, when you enforce public access prevention on a new or existing Cloud Storage resource, no one in your organization can make data public through IAM policies or ACLs.
# https://cloud.google.com/storage/docs/public-access-prevention

gsutil pap set enforced gs://${GCP_BUCKET_NAME}

# Specify global bucket access scope.
# https://cloud.google.com/storage/docs/gsutil/commands/bucketpolicyonly

gsutil bucketpolicyonly set on gs://${GCP_BUCKET_NAME}
gsutil bucketpolicyonly get gs://${GCP_BUCKET_NAME}
