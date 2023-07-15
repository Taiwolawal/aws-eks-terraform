locals {
  namespaces = concat(var.developer_usernames, var.namespaces)
}
