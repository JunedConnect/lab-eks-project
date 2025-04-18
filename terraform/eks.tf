module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                             = var.name
  cluster_version                          = "1.31"

  cluster_endpoint_public_access_cidrs     = [var.public-access-cidrs] 
  cluster_endpoint_public_access           = true # make it into a variable later
  enable_cluster_creator_admin_permissions = true # make it into a variable later

  enable_irsa = true # make it into a variable later

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