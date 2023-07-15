##############
# VPC Variables
###############
vpc_name        = "EKS-VPC"
cidr            = "10.0.0.0/16"
region          = "us-east-1"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

# vpc_id = vpc-0282127e1f79ed93c

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
cluster_name    = "eks-prod"
cluster_version = "1.27"

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
}

# subnet_ids = ["10.0.1.0/24", "10.0.2.0/24"]

enable_irsa = true

cluster_security_group_name = var.cluster_name


eks_managed_node_groups = {
  ON_DEMAND = {
    name                 = "dev-ng-one"
    instance_types       = ["t3.medium"]
    capacity_type        = "ON_DEMAND"
    min_size             = 1
    max_size             = 2
    desired_size         = 1
    force_update_version = true
  }

  SPOT = {
    name                 = "dev-ng-two"
    instance_types       = ["t3.medium"]
    capacity_type        = "SPOT"
    min_size             = 1
    max_size             = 2
    desired_size         = 1
    force_update_version = true
  }


}

manage_aws_auth_configmap = true

namespaces          = ["dev"]
developer_usernames = ["developer-1"]

security_groups = {
  eks_worker_node = {
    name                = "dev-eks-workers"
    description         = "EKS worker node security group"
    create              = true
    security_group_id   = ""
    ingress_cidr_blocks = ["10.0.0.0/16"]
    egress_cidr_blocks  = ["10.0.0.0/16"]
    ingress_rules       = [/*"http-80-tcp",*/]
    egress_rules        = [/*"http-80-tcp",*/]
    ingress_with_cidr_blocks = [
      {
        from_port   = 8080
        to_port     = 8084
        protocol    = "tcp"
        description = "open port range 8080-8084/tcp ingress rule"
        cidr_blocks = "10.0.0.0/16"
      },
    ]
    egress_with_cidr_blocks = [
      {
        from_port   = 8080
        to_port     = 8084
        protocol    = "tcp"
        description = "open port range 8080-8084/tcp egress rule"
        cidr_blocks = "10.0.0.0/16"
      },
    ]
  }
}