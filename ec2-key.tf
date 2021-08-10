
resource "aws_key_pair" "deployer" {
  key_name   = var.keypairname
  public_key = var.ec2-key-public-key
}