resource "null_resource" "web" {
 
   provisioner "local-exec" {
    command = "terraform -version"
    interpreter = ["PowerShell", "-Command"]
  }
  provisioner "local-exec" {
    command = "kubectl -version"
    interpreter = ["PowerShell", "-Command"]
  }
}