provider "helm" {
  kubernetes {
    config_path = "~/.kube/eks-cluster"
  }
}

resource helm_release helm-wordpress3 {
  name       = "helm-automated-wordpress3"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "mariadb.enabled"
    value = "false"
  }
  set {
    name  = "externalDatabase.host"
    value = "myexternalhost"
  }
  set {
    name  = "externalDatabase.user"
    value = "myuser"
  }
  set {
    name  = "externalDatabase.password"
    value = "mypassword"
  }
  set {
    name  = "externalDatabase.database"
    value = "mydatabase"
  }
  set {
    name  = "externalDatabase.port"
    value = "3306"
  }  
}
