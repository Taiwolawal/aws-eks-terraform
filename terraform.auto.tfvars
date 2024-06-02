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
cluster_version = "1.29"

cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true

cluster_addons = {
  coredns = {
    most_recent = true
  }
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }

  eks-pod-identity-agent = {
    most_recent = true
  }
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

access_entries = {
    # One access entry with a policy associated
    admin = {
      kubernetes_groups = ["admin"]
      principal_arn     = aws_iam_role.eks_admin.arn

      policy_associations = {
        admin = {
          policy_arn = aws_iam_policy.eks_assume_admin.arn
         
        }
      }
    }

    # developers = {
    #   kubernetes_groups = ["developer"]
    #   principal_arn     = "module.eks_dev_iam_role.iam_role_arn"

    #   policy_associations = {
    #     developers = {
    #       policy_arn = "module.eks.eks_dev_iam_policy.arn"
    #       access_scope = {
    #         namespaces = ["developer"]
    #         type       = "namespace"
    #       }
    #     }
    #   }
    # } 
  }

  admin_username = "Taiwo"
  dev_username = "Kenny"

