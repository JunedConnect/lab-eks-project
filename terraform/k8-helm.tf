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

  #  depends_on = [helm_release.nginx_ingress]
  #  depends_on = [module.cert-manager-irsa-role]
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

  #  depends_on = [helm_release.nginx_ingress]
}


resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  create_namespace = true
  namespace        = "nginx-ingress"

  #  depends_on = [ module.eks ]
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

}