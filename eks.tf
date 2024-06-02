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

  access_entries = var.access_entries

  depends_on = [
    module.eks_iam_role.custom_role_policy_arns,
    module.node_iam_role.custom_role_policy_arns
    # aws_iam_role_policy_attachment.eks,
    # aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    # aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    # aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]


  tags = var.tags
}

resource "kubernetes_namespace" "developer" {
  metadata {
    name = "developer"

    labels = {
      managed_by = "terraform"
    }
  }
}

resource "kubernetes_role" "developer" {
  metadata {
    name = "developer-role"
    namespace = "developer"
  }

  rule {
    api_groups     = ["*"]
    resources      = ["pods", "services", "delpoyment"]
    verbs          = ["get", "list", "describe"]
  }

}

resource "kubernetes_role_binding" "developer" {
  metadata {
    name      = "developer-role-binding"
    namespace = "developer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "developer-role"
  }
  subject {
    kind      = "Group"
    name      = "developer"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role" "cluster_viewer" {
  metadata {
    name = "admin-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  }

  rule {
    api_groups = [""]
    resources = ["pods/portforward"]
    verbs = ["get", "list", "create"]
  }

  rule {
    api_groups = ["apiextensions.k8s.io"]
    resources = ["customresourcedefinitions"]
    verbs = ["get", "list", "describe"]
  }

  rule {
    api_groups = [""]
    resources = ["pods/exec", "pods/attach"]
    verbs = ["get", "list", "create"]
  }
  
  rule {
    api_groups = [""]
    resources = ["pods"]
    verbs = ["get", "list", "create", "describe", "delete", "update"]
  }
}

resource "kubernetes_cluster_role_binding" "cluster_viewer" {
  metadata {
    name = "admin-cluster-role-binding"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "admin-cluster-role"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "Group"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
}