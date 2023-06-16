variable "environment" {
  type        = string
  description = "Enviroment to deploy resources"
}

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

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
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

variable "aws_auth_users" {
  type = list(any)
}

variable "aws_auth_roles" {
  type = list(any)
}

variable "tags" {
  type = map(any)
}