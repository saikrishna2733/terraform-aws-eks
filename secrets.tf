resource "null_resource" "web" {
 #His is useful
   provisioner "local-exec" {
    command = "terraform output kubeconfig > C:/Users/SUNEETHA/.kube/config"
    interpreter = ["PowerShell", "-Command"]
  }
  provisioner "local-exec" {
    command = "set KUBECONFIG=~/.kube/config"
    interpreter = ["PowerShell", "-Command"]
  }
}