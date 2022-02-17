# Base

## Overview

Configure Argo CD to deploy core services.

## Argo CD

### 1. Install

```
$ kubectl create namespace argocd
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Port Forward

```
$ kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### 3. Get Initial Password

```
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
