
# https://zero-to-jupyterhub.readthedocs.io/en/latest/jupyterhub/installation.html
# https://jupyterhub.github.io/helm-chart/

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm upgrade --cleanup-on-fail \
  --install jupyterhub-hr-1  jupyterhub/jupyterhub \
  --namespace jupyterhub-k8s-1 \
  --create-namespace \
  --version=1.0.1 \
  --values config.yaml

kubectl get service --namespace jupyterhub-k8s-1
kubectl describe service proxy-public --namespace jupyterhub-k8s-1
