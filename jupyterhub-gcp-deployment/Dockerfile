FROM ubuntu:21.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt update \
 && apt install --yes \
      ca-certificates \
      curl wget \
      python3 \
      git \
      vim

RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-348.0.0-linux-x86_64.tar.gz \
 && tar xf google-cloud-sdk-348.0.0-linux-x86_64.tar.gz \
 && rm google-cloud-sdk-348.0.0-linux-x86_64.tar.gz

RUN /google-cloud-sdk/install.sh \
  --command-completion true \
  --path-update true \
  --usage-reporting false \
  --additional-components kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/HEAD/scripts/get-helm-3 | bash

RUN useradd -g users -s /bin/bash --create-home gcpuser \
 && cp /root/.bashrc /home/gcpuser/.bashrc && chown gcpuser: /home/gcpuser/.bashrc

ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

USER gcpuser
WORKDIR /home/gcpuser
ENTRYPOINT ["/tini", "--"]

