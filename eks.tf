module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups         = var.eks_managed_node_groups

   # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  authentication_mode = var.authentication_mode



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