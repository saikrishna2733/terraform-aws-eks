provider "helm" {
  kubernetes {
    config_path = "~/.kube/eks-cluster"
  }
}

resource helm_release helm-wordpress1 {
  name       = "helm-automated-wordpress1"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
