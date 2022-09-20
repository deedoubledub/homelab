#!/usr/bin/env bash

ARGO_CD_VERSION=v2.4.12

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGO_CD_VERSION/manifests/ha/install.yaml

# wait for ready
kubectl -n argocd wait --for=condition=Available --all deployments.apps/argocd-server

# Configure argo to manage itself
kubectl apply -n argocd -f argocd/app-argocd.yaml

# Display the initial admin password
echo "********"
echo -n "Initial Argo CD admin password: "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo "********"
