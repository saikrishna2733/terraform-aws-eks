#
# Provider Configuration

provider "aws" {
  region = var.aws-region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY

}

provider "http" {}
