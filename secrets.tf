resource "aws_instance" "web" {
 
   provisioner "local-exec" {
    command = "terraform -version"
  }
}

output "data-local-exec" {
    value = aws-aws_instance.web.command
  
}