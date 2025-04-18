terraform {

  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
  backend "s3" {
    bucket = "tf-state-eks-project"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    encrypt = "true"
    use_lockfile = true
  }

}


provider "aws" {
  region = "eu-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}