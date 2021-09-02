provider "helm" {
  kubernetes {
    config_path = "C:/Kubectl/kube/config"
  }
}

resource helm_release helm-Camunda {
  ###useful
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
    name  = "DB_DRIVER"
    value = "com.mysql.jdbc.Driver"
  }
  set {
    name  = "DB_URL"
    value = var.helmurl
  }
  set {
    name  = "credentialsSecretName"
    value = "camunda-secret"
  }
  set {
  name  = "env"
  value = {"DB_DRIVER" = "com.mysql.jdbc.Driver", "DB_URL" = "${var.helmurl}"}
}
  
}
