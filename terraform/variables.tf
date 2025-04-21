#General

variable "name" {
  description = "Resource Name"
  type        = string
  default     = "test"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-west-2"
}

variable "tags" {
  description = "Tags for Resources"
  type        = map(string)
  default = {
    Environment = "dev",
    Project     = "eks",
    Owner       = "juned",
    Terraform   = "true"
  }
}


#route53

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
  default     = "lab.juned.co.uk"
}


#VPC

variable "vpc-cidr-block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "publicsubnet1-cidr-block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "publicsubnet2-cidr-block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}


variable "privatesubnet1-cidr-block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}


variable "privatesubnet2-cidr-block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "enable-nat-gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "single-nat-gateway" {
  description = "Use a single NAT Gateway"
  type        = bool
  default     = true
}

variable "enable-dns-hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}


#eks

variable "cluster-version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.31"
}

variable "public-access-cidrs" {
  description = "range of ip's that can access the cluster"
  type        = string
  default     = "0.0.0.0/0"
}

variable "cluster-public-access" {
  description = "Enable public access to EKS cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster-admin-permissions" {
  description = "Enable admin permissions for cluster creator"
  type        = bool
  default     = true
}

variable "enable-irsa" {
  description = "Enable IAM Roles for Service Accounts (IRSA)"
  type        = bool
  default     = true
}

variable "instance-disk-size" {
  description = "Disk size for instances"
  type        = number
  default     = 50
}

variable "instance-types" {
  description = "List of instance types to be used within the cluster"
  type        = list(string)
  default     = ["t3.large"]
}


# IRSA

variable "cert-manager-role-name" {
  description = "The name of the IAM role for cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "cert-manager-policy-attach" {
  description = "Flag to attach the cert-manager policy"
  type        = bool
  default     = true
}

variable "external-dns-role-name" {
  description = "The name of the IAM role for cert-manager"
  type        = string
  default     = "external-dns"
}

variable "external-dns-policy-attach" {
  description = "Flag to attach the external-dns policy"
  type        = bool
  default     = true
}


# Helm

variable "cert-manager-helm-name" {
  description = "The name of the Helm release for cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "cert-manager-helm-values-file-path" {
  description = "The file path to the cert-manager Helm values"
  type        = string
  default     = "helm-values/cert-manager.yml"
}

variable "cert-manager-namespace" {
  description = "The namespace for cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "external-dns-helm-name" {
  description = "The name of the Helm release for external-dns"
  type        = string
  default     = "external-dns"
}

variable "external-dns-helm-values-file-path" {
  description = "The file path to the external-dns Helm values"
  type        = string
  default     = "helm-values/external-dns.yml"
}

variable "external-dns-namespace" {
  description = "The namespace for external-dns"
  type        = string
  default     = "external-dns"
}

variable "nginx-ingress-helm-name" {
  description = "The name of the Helm release for nginx-ingress"
  type        = string
  default     = "nginx-ingress"
}

variable "nginx-ingress-namespace" {
  description = "The namespace for nginx-ingress"
  type        = string
  default     = "nginx-ingress"
}

variable "argocd-helm-name" {
  description = "The name of the Helm release for argocd"
  type        = string
  default     = "argocd"
}

variable "argocd-helm-values-file-path" {
  description = "The file path to the argocd Helm values"
  type        = string
  default     = "helm-values/argo-cd.yml"
}

variable "argocd-namespace" {
  description = "The namespace for nginx-ingress"
  type        = string
  default     = "argocd"
}

variable "prom-graf-helm-name" {
  description = "The name of the Helm release for argocd"
  type        = string
  default     = "prom-graf"
}

variable "prom-graf-helm-values-file-path" {
  description = "The file path to the prom-graf Helm values"
  type        = string
  default     = "helm-values/prom-graf.yml"
}

variable "prom-graf-namespace" {
  description = "The namespace for prom-graf"
  type        = string
  default     = "monitor"
}