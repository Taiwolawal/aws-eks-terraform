# VPC VARIABLES
variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
}

variable "cidr" {
  type    = string
  default = ""
}

variable "azs" {
  type    = list(any)
  default = []
}

variable "private_subnets" {
  type    = list(any)
  default = []
}

variable "public_subnets" {
  type    = list(any)
  default = []
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
}

variable "single_nat_gateway" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}

variable "tags" {
  type    = map(any)
  default = {}
}

# EKS VARIABLE

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_endpoint_private_access" {
  type = bool
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "cluster_addons" {
  type = map(any)
}

variable "subnet_ids" {
  type = list(string)
}

variable "enable_irsa" {
  type = bool
}

variable "eks_managed_node_group_defaults" {
  type = map(any)
}

variable "eks_managed_node_groups" {
  type = map(any)
}

variable "manage_aws_auth_configmap" {
  type = bool
}

variable "role" {
  type    = string
}

variable "role_binding" {
  type    = string
}

variable "namespaces" {
  type        = list(string)
  description = "Kubernetes namespaces to create"
  default     = []
}