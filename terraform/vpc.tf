module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.19.0"
  name            = var.name
  cidr            = var.vpc-cidr-block
  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = [var.publicsubnet1-cidr-block, var.publicsubnet2-cidr-block]
  private_subnets = [var.privatesubnet1-cidr-block, var.privatesubnet2-cidr-block]

  enable_nat_gateway   = var.enable-nat-gateway
  single_nat_gateway   = var.single-nat-gateway
  enable_dns_hostnames = var.enable-dns-hostnames

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "owned"
    "kubernetes.io/role/internal-elb"   = 1
  }


  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "owned"
    "kubernetes.io/role/elb"            = 1
  }

  tags = var.tags
}