resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  set {
    name  = "crds.enabled"
    value = "true"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" # this will link the service account to the iam role
    value = module.cert-manager-irsa-role.iam_role_arn
  }

  values = [
    file("helm-values/cert-manager.yml")
  ]
}


resource "helm_release" "external-dns" {
  name       = "external-dns"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"

  set {
    name  = "wait-for"
    value = module.external-dns-irsa-role.iam_role_arn
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external-dns-irsa-role.iam_role_arn
  }

  values = [
    file("helm-values/external-dns.yml")
  ]

  depends_on = [ # this is required so that once all kubernetes related resources are destroyed, externaldns can then delete the records associated with them. If externaldns is removed before the other kubernetes resources, the records will not be removed. This will cause a problem when you try and destroy your terraform resources and terraform will not be able to destroy the route53 resource due to existing records.
    helm_release.cert-manager,
    helm_release.nginx-ingress-controller,
    helm_release.argocd
  ]
}


resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  create_namespace = true
  namespace        = "nginx-ingress"

  #  depends_on = [helm_release.cert-manager]
}


resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  timeout    = "600"
  version = "5.19.15"

  create_namespace = true
  namespace        = "argocd"

  values = [
    file("helm-values/argo-cd.yml")
  ]

  #  depends_on = [helm_release.cert-manager]
}