module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.31.6"
  cluster_name    = local.cluster_name
  cluster_version = "1.31"
  subnet_ids         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  # Optional
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.micro"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
}

