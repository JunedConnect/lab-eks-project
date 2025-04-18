module "cert-manager-irsa-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.52.2"
  role_name                     = "cert-manager"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/${aws_route53_zone.this.zone_id}"]
  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["cert-manager:cert-manager"] # the first value here is the namespace and the second value is the service account name
    }
  }
  tags = var.tags
}


module "external-dns-irsa-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.52.2"

  role_name                     = "external-dns"
  attach_external_dns_policy = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/${aws_route53_zone.this.zone_id}"]

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["external-dns:external-dns"] # the first value here is the namespace and the second value is the service account name
    }
  }

  tags = var.tags
}