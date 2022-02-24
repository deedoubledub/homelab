#!/usr/bin/env bash

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml

# wait for ready
kubectl -n argocd wait --for=condition=Available --all deployments.apps/argocd-server

# Configure argo to manage itself
kubectl apply -n argocd -f argocd/app-argocd.yaml
