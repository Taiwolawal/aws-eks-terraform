##############
# VPC Variables
###############
vpc_name        = "EKS-VPC"
cidr            = "10.0.0.0/16"
region          = "us-east-1"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]


enable_nat_gateway = true
single_nat_gateway = true

enable_dns_hostnames = true
enable_dns_support   = true
tags = {
  Terraform   = "true"
  Environment = "dev"
}

################
# EKS variables
################
cluster_name    = "dev-eks"
cluster_version = "1.30"

cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true

cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

eks_managed_node_groups = {
  dev-eks = {
    min_size     = 1
    max_size     = 2
    desired_size = 1

    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
  }

}

enable_cluster_creator_admin_permissions = true

authentication_mode = "API"

# access_entries = {

#     admin = {
#       # authentication_mode = "API"
#       kubernetes_groups = ["my-admin"]
#       principal_arn     = "aws_iam_role.eks_admin.arn"

#       policy_associations = {
#         admin = {
#           policy_arn = "aws_iam_policy.eks_admin.arn"
#           access_scope = {
#             type       = "cluster"
#           }
#         }
#       }
#     } 
# }


