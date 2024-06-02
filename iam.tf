data "aws_caller_identity" "current" {}
module "eks_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.39.1"

  role_name         = "eks-role"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.eks_iam_policy.arn, 
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}

module "eks_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.39.1"

  name          = "allow-eks-access"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action =  "sts:AssumeRole",
        Principal = {
          "Service": "eks.amazonaws.com"
        }
      },
    ]
  })
}

module "node_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.39.1"

  role_name         = "node-role"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.node_iam_policy.arn, 
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}

module "node_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.39.1"

  name          = "allow-node-access"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action =  "sts:AssumeRole",
        Principal = {
          "Service": "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role" "eks_admin" {
  name = "eks-admin"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "eks_admin" {
  name = "AmazonEKSAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
  role       = aws_iam_role.eks_admin.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_policy" "eks_assume_admin" {
  name = "AmazonEKSAssumeAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "${aws_iam_role.eks_admin.arn}"
        }
    ]
}
POLICY
}

resource "aws_iam_user_policy_attachment" "manager" {
  user       = aws_iam_user.manager.name
  policy_arn = aws_iam_policy.eks_assume_admin.arn
}


## IAM Role that will be used by admin to access the cluster  
# module "eks_admins_iam_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
#   version = "5.39.1"

#   role_name         = "eks-admin"
#   create_role       = true
#   role_requires_mfa = false

#   custom_role_policy_arns = [module.eks_admin_iam_policy.arn]

#   trusted_role_arns = [
#     "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
#   ]
# }



## Policy to allow full EKS access for admin
# module "eks_admin_iam_policy" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version = "5.3.1"

#   name          = "allow-eks-access-admin"
#   create_policy = true

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = ["eks:*"]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#       {
#         Effect =  "Allow",
#         Action = "iam:PassRole",
#         Resource = "*",
#         Condition = {
#             "StringEquals": {
#                 "iam:PassedToService": "eks.amazonaws.com"
#             }
#         }
#       },
#       {
#         Action = "sts:AssumeRole",
#         Effect   = "Allow",
#         Principal = {
#           "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         }
#       }
#     ]
#   })
# }

## Create Admin users to access the cluster
module "admin_user" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "5.39.1"
  name                          = var.admin_username
  create_iam_access_key         = false
  create_iam_user_login_profile = false
  force_destroy                 = true
}

# resource "aws_iam_user_policy_attachment" "manager" {
#   user       = module.admin_user.iam_user_name
#   policy_arn = aws_iam_policy.eks_assume_admin.arn
# }

## Create an IAM group with users and attach assume policy
module "eks_admins_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.39.1"

  name                              = "eks-admin"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.admin_user.iam_user_name]
  custom_group_policy_arns          = [module.eks_admin_iam_policy.arn]
}



## IAM Role that will be used by admin to access the cluster  
module "eks_dev_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.39.1"

  role_name         = "eks-dev"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.eks_dev_iam_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}



## Policy to allow full EKS access for admin
module "eks_dev_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.39.1"

  name          = "allow-eks-access-dev"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = [
            "eks:DescribeCluster",
            "eks:ListClusters"
        ],        
        Resource = "*"
      },
      {
        Action = "sts:AssumeRole",
        Effect   = "Allow",
        Principal = {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })
}


## Create Dev users to access the cluster
module "dev_user" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "5.39.1"
  name                          = var.dev_username
  create_iam_access_key         = false
  create_iam_user_login_profile = false
  force_destroy                 = true
}

## Create an IAM group with users and attach assume policy
module "eks_dev_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.39.1"

  name                              = "eks-dev"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.dev_user.iam_user_name]
  custom_group_policy_arns          = [module.eks_admin_iam_policy.arn]
}


resource "aws_iam_role" "cluster_autoscaler" {
  name = "${module.eks.cluster_name}-cluster-autoscaler"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name = "${module.eks.cluster_name}-cluster-autoscaler-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
  role       = aws_iam_role.cluster_autoscaler.name
}

resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name    = module.eks.cluster_name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.cluster_autoscaler.arn
}
















# resource "aws_iam_role" "eks" {
#   name = "role-eks-cluster"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       }
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "eks" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks.name
# }

# resource "aws_iam_role" "nodes" {
#   name = "role-eks-nodes"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       }
#     }
#   ]
# }
# POLICY
# }

# # This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent
# resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes.name
# }