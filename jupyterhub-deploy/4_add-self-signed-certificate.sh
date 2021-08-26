#!/bin/bash

source config.sh

# This will enable traffic encryption, but won't provide any "authentication" of the JupyterHub service.
# An domain would be needed for setting up a properly signed TLS certificate, which is a bit beyond the scope of the present exploratory setup.
# The JupyterHub Helm chart comes with Let's encrypt functionality, which could be used together with a domain in a production deployment.

# Make sure we don't override an already existing TLS certificate.

if [[ -f tls.crt ]]; then echo "Certificate already exists. Exiting..."; exit; fi
if [[ -f tls.key ]]; then echo "Certificate key already exists. Exiting..."; exit; fi

# Generate a self-signed TLS certificate.
# https://linuxize.com/post/creating-a-self-signed-ssl-certificate/

openssl req -newkey rsa:4096 -x509 -sha256 -days 183 -nodes \
  -out tls.crt -keyout tls.key \
  -subj "/C=DE/ST=Schleswig-Holstein/L=Kiel/CN=ESM-VFC cloud project"

#openssl x509 -in tls.crt -text -noout

# Create TLS certificate Kubernetes secret.

K8S_TLS_SECRET_NAME=self-signed-tls-cert

kubectl delete secret ${K8S_TLS_SECRET_NAME} \
  --namespace ${K8S_NAMESPACE}

kubectl create secret tls ${K8S_TLS_SECRET_NAME} \
  --namespace=${K8S_NAMESPACE} \
  --key=tls.key --cert=tls.crt 

# Check available secrets.

kubectl get secrets --namespace ${K8S_NAMESPACE}
kubectl describe secret ${K8S_TLS_SECRET_NAME} --namespace ${K8S_NAMESPACE}
