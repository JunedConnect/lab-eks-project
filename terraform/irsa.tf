module "cert-manager-irsa-role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                       = "5.52.2"
  role_name                     = var.cert-manager-role-name
  attach_cert_manager_policy    = var.cert-manager-policy-attach
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/${aws_route53_zone.this.zone_id}"]
  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["${var.cert-manager-namespace}:cert-manager"] # the first value here is the namespace and the second value is the service account name
    }
  }
  tags = var.tags
}


module "external-dns-irsa-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.52.2"

  role_name                     = var.external-dns-role-name
  attach_external_dns_policy    = var.external-dns-policy-attach
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/${aws_route53_zone.this.zone_id}"]

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["${var.external-dns-namespace}:external-dns"] # the first value here is the namespace and the second value is the service account name
    }
  }

  tags = var.tags
}