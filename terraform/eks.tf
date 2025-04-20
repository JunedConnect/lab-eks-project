module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.name
  cluster_version = var.cluster-version

  cluster_endpoint_public_access_cidrs     = [var.public-access-cidrs]
  cluster_endpoint_public_access           = var.cluster-public-access
  enable_cluster_creator_admin_permissions = var.cluster-admin-permissions

  enable_irsa = var.enable-irsa

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_group_defaults = {
    disk_size      = var.instance-disk-size
    instance_types = var.instance-types
  }

  eks_managed_node_groups = {
    default = {}
  }

  tags = var.tags
}