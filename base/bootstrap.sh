#!/usr/bin/env bash

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml

# wait for ready
kubectl -n argocd wait --for=condition=Available --all deployments.apps/argocd-server

# Configure git repos
kubectl apply -n argocd -f argocd/repositories/homelab.yaml

# Configure applications
# metallb
kubectl apply -n argocd -f argocd/applications/metallb.yaml
# traefik
kubectl apply -n argocd -f argocd/applications/traefik.yaml
