
# This encrypts the JupyterHub traffic, but doesn't provide any "service authentication".
# Consider getting a domain name and setting up Let's encrypt.

NAMESPACE=jupyterhub-k8s-1

# Make sure we don't accidently override an already existing TLS certificate.

if [[ -f tls.crt ]]; then echo "Certificate already exists. Exiting..."; exit; fi
if [[ -f tls.key ]]; then echo "Certificate key already exists. Exiting..."; exit; fi

# Generate a self-signed TLS certificate.
# https://linuxize.com/post/creating-a-self-signed-ssl-certificate/

openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 183 \
            -nodes \
            -out tls.crt \
            -keyout tls.key \
            -subj "/C=DE/ST=Schleswig-Holstein/L=Kiel/CN=ESM-VFC cloud project"
#            -subj "/C=DE/ST=Schleswig-Holstein/L=Kiel/O=GEOMAR Helmholtz Centre for Ocean Research/OU=RD1-OD/CN=ESM-VFC cloud project"

openssl x509 -in tls.crt -text -noout

# Create TLS certificate Kubernetes secret.

kubectl delete secret self-signed-tls --namespace ${NAMESPACE}
kubectl create secret tls self-signed-tls --key=tls.key --cert=tls.crt --namespace=${NAMESPACE}

# Check available secrets.

kubectl get secrets --namespace ${NAMESPACE}
kubectl describe secret self-signed-tls --namespace ${NAMESPACE}

