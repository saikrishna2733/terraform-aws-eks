provider "helm" {
  kubernetes {
    config_path = "~/.kube/eks-cluster"
  }
}

resource helm_release nginx_ingress {
  name       = "helm-automated-wordpress"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
