# Base

```
$ ./bootstrap.sh
```

## Overview

Configure Argo CD to deploy core services.

## Argo CD

The `bootstrap.sh` script:

- creates the `argocd` namespace
- installs Argo CD
- waits for Argo CD to become available
- configures an Argo CD application to manage itself from the contents of `argocd/`
- deploys all manifests in `argocd/`
- displays the initial admin password

### Port Forward

```
$ kubectl port-forward svc/argocd-server -n argocd 8080:443
```
