# Variables Configuration
variable "AWS_SECRET_KEY"{
  default     = "/Ozw0uuj28tFKRBb8ZL37EvHvqRDEstqnuoPMehS"
  type        = string
  description = "aws secret key details"
}

variable "AWS_ACCESS_KEY"{
  default     = "AKIAXJ7COV4QNMFOO75H"
  type        = string
  description = "aws secret key details"
}
variable "cluster-name" {
  default     = "eks-cluster"
  type        = string
  description = "The name of your EKS Cluster"
}


variable "aws-region" {
  default     = "us-west-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}

variable "availability-zones" {
  default     = ["us-west-1a", "us-west-1c"]
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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhkU5wegBBgB2qUgS5HDa6KHOyfdDgUm7nn3r5ZeSmwRYAD76CB9DAsCcLxsz+PAXP8watOFgbyU8JlFfL31wnpl1FwhsJjBnlx8RnaOFE3cRaPGbXqDMnst+rewrB48L499EakZ74LGBQtHXXgANsUNROY3cq9OGVPrjxskvCliQV3UKjtA6pVpf+V3/Exql//iFtwY5SkUxSYTOlTBQCpXZOWehVi6HDMUolJ7dYZuTn6m/w5FYDzEr+x/LAaT0ZTTtLJ63bqYBB5qrmddGo6GVeGYx/WvXdMGcWQ6liF9hbcz/kmY8GjUETUargcWJw+6Txvu7sPfW3MUeK6nQoQ== rsa-key-20210812"
  type        = string
  description = "AWS EC2 public key data"
}
variable "keypairname" {
  default     = "my-ec2-keypair"
  type        = string
  description = "The name of your aws key pair"
}
################################# EC2-Keypair Variables ends here ######################


########################################################################################


variable "build_image" {
  default = "aws/codebuild/docker:18.09.0"
}

variable "repo_name" {
  default = "tf-eks"
}
variable "default_branch" {
  default = "master"
  
}

# define build spec for build stage
variable "build_spec" {
  default = "buildspec/build.yml"
}

# define docker image for deploy stage
variable "deploy_image" {
  default = "aws/codebuild/standard:4.0"
}
# define build spec for deploy stage
variable "deploy_spec" {
  default = "buildspec/deploy.yml"
}