resource "null_resource" "web" {
    provisioner "local-exec" {
    command = "terraform output kubeconfig > C:/Users/SUNEETHA/.kube/config"
    interpreter = ["PowerShell", "-Command"]
 }
    provisioner "local-exec" {
    command = "set KUBECONFIG=C:/Users/SUNEETHA/.kube/config"
    interpreter = ["PowerShell", "-Command"]
 }
}