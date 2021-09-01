resource "aws_instance" "web" {
    provisioner "local-exec" {
    command = "terraform output kubeconfig > C:/Users/SUNEETHA/.kube/config"
    interpreter = ["PowerShell", "-Command"]
 }
}