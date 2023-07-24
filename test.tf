# ####################
# # CREATE EKS CLUSTER
# ####################
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 19.0"

#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version

#   cluster_endpoint_private_access = var.cluster_endpoint_private_access
#   cluster_endpoint_public_access  = var.cluster_endpoint_public_access

#   cluster_addons = {
#     coredns = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#     aws-ebs-csi-driver = {
#       most_recent = true
#     }
#   }

#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets 
#   control_plane_subnet_ids = []

#   # additional sg group
#   cluster_security_group_name = var.cluster_name

#   iam_role_additional_policies = {
#     EKSNodegroupFullECRAccess       = aws_iam_policy.eks_nodegroup_ecr_full_access.arn
#     AmazonEBSCSIDriverPolicy        = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
#     EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
#     EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
#   }

#   cluster_security_group_additional_rules = {
#     ingress_cluster_tcp = {
#       description = "Allow Access to Security group from anywhere."
#       protocol    = "tcp"
#       from_port   = 443
#       to_port     = 443
#       type        = "ingress"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   node_security_group_additional_rules = {
#     "ingress_cluster_10250" : {
#       "description" : "Metric server to node groups",
#       "from_port" : 10250,
#       "protocol" : "tcp",
#       "self" : true,
#       "to_port" : 10250,
#       "type" : "ingress"
#     }
#   }

#   self_managed_node_group_defaults = {}

#   self_managed_node_groups = {}

#   eks_managed_node_group_defaults = {
#     iam_role_additional_policies = {
#       AmazonEBSCSIDriverPolicy        = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
#       EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
#       EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
#     }
#   }
#   eks_managed_node_groups = var.eks_managed_node_groups

#   #manage_aws_auth_configmap = true
#   #create_aws_auth_configmap = true



#   aws_auth_accounts = [
#     tostring(data.aws_caller_identity.current.account_id),
#   ]

#   tags = var.tags

# }