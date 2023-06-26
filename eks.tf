module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = var.enable_irsa


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = var.eks_managed_node_groups

  manage_aws_auth_configmap = var.manage_aws_auth_configmap

  tags = var.tags
}