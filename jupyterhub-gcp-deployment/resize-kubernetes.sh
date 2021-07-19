
# Note, bringing down the JupyterHub Kubernetes cluster is more complex than scaling down things like this!

# https://cloud.google.com/kubernetes-engine/docs/how-to/managing-clusters#resizing_clusters
# https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster

gcloud container clusters \
  resize jupyterhub-cluster-1 \
  --zone europe-west3-b \
  --num-nodes=0

