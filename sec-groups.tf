# ### Security Groups

# # CLUSTER SECURITY GROUPS


# module "cluster-sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "3.0.1"

#   name        = "cluster-sg"
#   description = "EKS node security groups"
#   vpc_id      = data.aws_vpc.eks.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]

#   computed_ingress_with_source_security_group_id = [
#     {
#       from_port                = 443
#       to_port                  = 443
#       protocol                 = "tcp"
#       description              = "Allow pods to communicate with the cluster API Server"
#       source_security_group_id = module.node-sg.this_security_group_id
#     },
#   ]

#   number_of_computed_ingress_with_source_security_group_id = 1

#   egress_cidr_blocks = ["0.0.0.0/0"]
#   egress_rules       = ["all-all"]

#   tags = {
#     Name = "${var.cluster-name}-eks-cluster-sg"
#   }
# }

# NODES SECURITY GROUPS

# module "node-sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "3.0.1"

#   name        = "node-sg"
#   description = "EKS node security groups"
#   vpc_id      = data.aws_vpc.eks.id

#   ingress_cidr_blocks = [data.aws_vpc.eks.cidr_block]
#   ingress_with_self = [
#     {
#       rule = "all-all"
#     },
#   ]
#   computed_ingress_with_source_security_group_id = [
#     {
#       from_port                = 1025
#       to_port                  = 65535
#       protocol                 = "tcp"
#       description              = "Allow EKS Control Plane"
#       source_security_group_id = module.cluster-sg.this_security_group_id
#     },
#   ]

#   number_of_computed_ingress_with_source_security_group_id = 1

#   egress_cidr_blocks = ["0.0.0.0/0"]
#   egress_rules       = ["all-all"]

#   tags = {
#     Name                                        = "${var.cluster-name}-eks-node-sg"
#     "kubernetes.io/cluster/${var.cluster-name}" = "owned"
#   }
# }

# # BASTION
# module "ssh_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "3.0.1"

#   name        = "ssh-sg"
#   description = "Security group which is to allow SSH from Bastion"
#   vpc_id      = data.aws_vpc.eks.id

#   ingress_cidr_blocks = ["196.192.165.10/32"]
#   ingress_rules       = ["ssh-tcp"]
#   egress_cidr_blocks  = ["0.0.0.0/0"]
#   egress_rules        = ["all-all"]
# }


##########Security Group from Bastion Host ########################

resource "aws_security_group" "bastionsg" {
  name        = "BastionOpen-sg"
  description = "Allow 22 port inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress     {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  egress    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  tags = {
    Name = "${var.cluster-name}-BastionOpen-sg"
  }
}

##########Security Group from Cluster SQ Host ########################

resource "aws_security_group" "cluster-sg" {
  name        = "cluster-sg"
  description = "Allow 22 port inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress     {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 65535
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress   {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      security_groups = [aws_security_group.node-sg.id]
 
    }
  

  egress     {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  tags = {
    Name = "${var.cluster-name}-cluster-sg"
  }
}

##########Security Group from node Sg  ########################

resource "aws_security_group" "node-sg" {
  name        = "node-sg"
  description = "Allow 22 port inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress     {
      description      = "TLS from VPC"
      from_port        = 1025
      to_port          = 65535
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  egress     {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  tags = {
    Name = "${var.cluster-name}-node-sg"
  }
}
