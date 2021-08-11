# Variables Configuration
varibles "AWS_SECRET_KEY"{
  default     = ""
  type        = string
  description = "aws secret key details"
}

varibles "AWS_ACCESS_KEY"{
  default     = ""
  type        = string
  description = "aws secret key details"
}
variable "cluster-name" {
  default     = "eks-cluster"
  type        = string
  description = "The name of your EKS Cluster"
}


variable "aws-region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}

variable "availability-zones" {
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type        = list
  description = "The AWS AZ to deploy EKS"
}

variable "k8s-version" {
  default     = "1.20"
  type        = string
  description = "Required K8s version"
}

variable "kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the node kubelet process"
}

variable "public-kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the public node kubelet process"

}
####################THis is using at network.tf #########
variable "vpc-subnet-cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "The VPC Subnet CIDR"
}
####################THis is using at network.tf #########
variable "private-subnet-cidr" {
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  type        = list
  description = "Private Subnet CIDR"
}
####################THis is using at network.tf #########
variable "public-subnet-cidr" {
  default     = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
  type        = list
  description = "Public Subnet CIDR"
}
####################THis is using at network.tf #########
variable "db-subnet-cidr" {
  default     = ["10.0.192.0/21", "10.0.200.0/21", "10.0.208.0/21"]
  type        = list
  description = "DB/Spare Subnet CIDR"
}

variable "eks-cw-logging" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list
  description = "Enable EKS CWL for EKS components"
}

variable "node-instance-type" {
  default     = "t2.small"
  type        = string
  description = "Worker Node EC2 instance type"
}

variable "root-block-size" {
  default     = "20"
  type        = string
  description = "Size of the root EBS block device"

}

variable "desired-capacity" {
  default     = 2
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 5
  type        = string
  description = "Autoscaling maximum node capacity"
}

variable "min-size" {
  default     = 1
  type        = string
  description = "Autoscaling Minimum node capacity"
}
################################# EC2-Keypair Variables starts here ###################
variable "ec2-key-public-key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsbGfmwFr1if0a6eUnNlylnzbhAevNyU656H8ApcqIDh+vYvOIxqXYzkQ5nNlCCrGe2TAOt/grx4q0wfkuIIIqeZnTzx1Qv3h25Vox0lU2FGpS6bLT0k7y6+hzUzapmNPep1W9VGCNQxJ7MyuxwtTymbLyMHoKRH9gWudToUjG2ip1JQQABLgsJ8hWm6zwJJmOijs5HFBXLN61ZLL2o2PRkMH/Uo52tOK2sw58KLpGRyKo6JPbGoKGp5TJUjL3prKiF/eqX82zFRIxsFypobhCUeAnkGa6BBjg043CH6M61NpcfQddmtdX0cKWhId3rDuxqWDwzI+Gxq9Bho6yblxkQ== rsa-key-20210811"
  type        = string
  description = "AWS EC2 public key data"
}
variable "keypairname" {
  default     = "sai-keypair"
  type        = string
  description = "The name of your aws key pair"
}
################################# EC2-Keypair Variables ends here ######################