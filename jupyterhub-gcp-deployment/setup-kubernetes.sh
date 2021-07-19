
# https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/google/step-zero-gcp.html

# gcloud compute machine-types list | head -n 1
# gcloud compute machine-types list | grep europe-west3

gcloud container clusters create \
  --zone europe-west3-b \
  --machine-type e2-standard-2 \
  --num-nodes 2 \
  --cluster-version latest \
  jupyterhub-cluster-1

