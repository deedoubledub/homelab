#!/usr/bin/env bash

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml

# wait for ready
kubectl -n argocd wait --for=condition=Available --all deployments.apps/argocd-server

# Configure argo to manage itself
kubectl apply -n argocd -f argocd/app-argocd.yaml

# Display the initial admin password
echo "********"
echo -n "Initial Argo CD admin password: "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo "********"
