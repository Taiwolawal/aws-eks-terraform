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

variable "tags" {
  type = map(any)
}