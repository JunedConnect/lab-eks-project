helm uninstall argocd --namespace argocd
helm uninstall cert-manager --namespace cert-manager
helm uninstall external-dns --namespace external-dns
helm uninstall nginx-ingress --namespace nginx-ingress

kubectl delete crd applications.argoproj.io \
                   applicationsets.argoproj,io \
                   appprojects.argoproj.io

kubectl delete crd certificaterequests.cert-manager.io \
                   certificates.cert-manager.io \
                   challenges.acme.cert-manager.io \
                   clusterissuers.cert-manager.io \
                   issuers.cert-manager.io \
                   orders.acme.cert-manager.io