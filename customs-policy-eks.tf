
#############Cluster Autoscaler Policy For EKS################
resource "aws_iam_policy" "cluster_autoscaler_policy_for_eks" {
  name        = "dev-cluster-autoscaler-policy"
  description = "ASG ClusterAutoscalerPolicy"
  policy      = file("policies/ClusterAutoscalerPolicy.json")
}

#############Cluster Issuer Policy For EKS Nodegroup################
resource "aws_iam_policy" "eks_nodegroup_cluster_issuer_policy" {
  name        = "dev-EKSNodegroupClusterIssuerPolicy"
  description = "access to cluster certificate issuer stuff"
  policy      = file("policies/ClusterIssuerPolicy.json")
}

#############CExternal DNS Policy For EKS################
resource "aws_iam_policy" "eks_nodegroup_exteral_dns_policy" {
  name        = "dev-EKSNodegroupExternalDNSPolicy"
  description = "access to external dns issuer route53 stuff"
  policy      = file("policies/ExternalDNSPolicy.json")
}