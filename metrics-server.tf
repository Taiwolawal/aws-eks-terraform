resource "helm_release" "metrics_server" {
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "cluster-autoscaler"
  version    = "3.12.1"

  values = [file("${path.module}/values/metrics-server.yaml")]

  depends_on = [module.eks]
}