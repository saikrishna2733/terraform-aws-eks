provider "helm" {
  kubernetes {
    config_path = "C:/Kubectl/kube/eks-cluster"
  }
}

resource helm_release helm-Camunda {
  name       = "camunda-helm"

  repository = "https://helm.camunda.cloud"
  chart      = "camunda-bpm-platform"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  
}
