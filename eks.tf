module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = var.enable_irsa

  iam_role_additional_policies = {
    EKSClusterAutoScalerPolicy      = aws_iam_policy.cluster_autoscaler_policy_for_eks.arn
    EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
    EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
  }

  eks_managed_node_group_defaults = {
    iam_role_additional_policies = {
      EKSClusterAutoScalerPolicy      = aws_iam_policy.cluster_autoscaler_policy_for_eks.arn
      EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
      EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
    }
  }

  eks_managed_node_groups = var.eks_managed_node_groups
  manage_aws_auth_configmap = var.manage_aws_auth_configmap

  # aws_auth_roles = [
  #   {
  #     rolearn  = module.eks_admins_iam_role.iam_role_arn
  #     username = module.eks_admins_iam_role.iam_role_name
  #     groups   = ["system:masters"]
  #   },
  #   {
  #     rolearn  = module.eks_developer_iam_role.iam_role_arn
  #     username = module.eks_developer_iam_role.iam_role_name
  #     groups   = [kubernetes_role_binding.developers.subject[0].name]
  #   },
  # ]

  tags = var.tags
}


# resource "kubernetes_namespace" "namespaces" {

#   metadata {
#     name = var.namespaces
#     labels = {
#       managed_by = "terraform"
#     }
#   }


# }


# resource "kubernetes_role" "developers_role" {
#   metadata {
#     name = var.role
#     labels = {
#       managed_by = "terraform"
#     }
#   }

#   rule {
#     api_groups = ["*"]
#     resources  = ["nodes", "namespaces", "pods", "events", "services"]
#     verbs      = ["get", "list"]
#   }
#   rule {
#     api_groups = ["apps"]
#     resources  = ["deployments", "daemonsets", "statefulsets", "replicasets"]
#     verbs      = ["get", "list"]
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces
#   ]
# }

# resource "kubernetes_role_binding" "developers" {
#   metadata {
#     name      = var.role_binding
#     namespace = var.namespaces
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = var.role
#   }
#   subject {
#     kind      = "Group"
#     name      = "eks-developer-group"
#     api_group = "rbac.authorization.k8s.io"
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces
#   ]
# }