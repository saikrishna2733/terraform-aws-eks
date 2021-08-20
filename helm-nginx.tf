provider "helm" {
  kubernetes {
    config_path = "~/.kube/eks-cluster"
  }
}

resource helm_release helm-wordpress {
  name       = "helm-automated-wordpress"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
