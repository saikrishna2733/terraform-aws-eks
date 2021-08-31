provider "helm" {
  kubernetes {
    config_path = "~/.kube/eks-cluster"
  }
}

resource helm_release helm-Camunda {
  name       = "helm-automated-Camunda"

  repository = "https://helm.camunda.cloud"
  chart      = "camunda"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  
}
