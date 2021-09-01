provider "helm" {
  kubernetes {
    config_path = "C:/Kubectl/kube/config"
  }
}

resource helm_release helm-Camunda {
  name       = "camunda-helm"
  depends_on = null_resource.web
  repository = "https://helm.camunda.cloud"
  chart      = "camunda-bpm-platform"
  values = [
    "${file("C:/Kubectl/kube/values.yaml")}"
  ]


  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "driver"
    value = "com.mysql.jdbc.Driver"
  }
  set {
    name  = "url"
    value = var.helmurl
  }
  set {
    name  = "credentialsSecretName"
    value = "camunda-secret"
  }
  
}
