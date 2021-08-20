# Variables Configuration
variable "AWS_SECRET_KEY"{
  default     = ""
  type        = string
  description = "aws secret key details"
}

variable "AWS_ACCESS_KEY"{
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
  default     = "ap-south-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}

variable "availability-zones" {
  default     = ["ap-south-1a", "ap-south-1b"]
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
  default     = "t2.medium"
  type        = string
  description = "Worker Node EC2 instance type"
}

variable "root-block-size" {
  default     = "20"
  type        = string
  description = "Size of the root EBS block device"

}

variable "desired-capacity" {
  default     = 1
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 2
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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgPc1rwgVQ+UGnnJOahug1dibsgQBqfUDRSdssLDdrv7HFDVNNHvMTvCOKC0hJLSLKy+UddNgbKMOqKJoJ/5WOrjPDH0J6jVHyYcjYhuPFmjMbAyCHGMDgtglv3427oz1AetHjUmP5O99jOg8nZxdgzt+ZA4bUfgwf+hJYzAsBcvJFWUWv0ykiubOd/6C0w3/2ryBl5XXmduNGgWBIVZXJ9clXDxisMRXw9iEIWtR9A73tyV7R3QWifoYSQtyyziuJ6vytKZqFTqrEvNyifge0DTqUASxg4+93NwhJpwEodI/BxPWHWIGYmJwqm2mD2+PQZwzLF4h4RjkU4Sv6knrBw== rsa-key-20210819"
  type        = string
  description = "AWS EC2 public key data"
}
variable "keypairname" {
  default     = "sai-keypair"
  type        = string
  description = "The name of your aws key pair"
}
################################# EC2-Keypair Variables ends here ######################