###################### VPC ###############

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "2.7.0"

#   name = "${var.cluster-name}-eks-vpc"
#   ###### from filename=variables.tf (this is used for eks cluster name)

#   cidr = var.vpc-subnet-cidr
#   ############from filename=variables.tf (this is used for eks cluster name)  default 10.0.0.0/16 & its pvt subnet

#   azs              = var.availability-zones
#   private_subnets  = var.private-subnet-cidr
#   public_subnets   = var.public-subnet-cidr
#   database_subnets = var.db-subnet-cidr
#   ############from filename=variables.tf
  
#   create_database_subnet_group = true

#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   enable_nat_gateway = true

#   tags = {
#     Name                                        = "${var.cluster-name}-vpc"
#     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
#   }

#   public_subnet_tags = {
#     Name                                        = "${var.cluster-name}-eks-public"
#     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
#     "kubernetes.io/role/elb"                    = 1
#   }
#   private_subnet_tags = {
#     Name                                        = "${var.cluster-name}-eks-private"
#     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
#     "kubernetes.io/role/internal-elb"           = 1
#   }
#   database_subnet_tags = {
#     Name = "${var.cluster-name}-eks-db"
#   }
# }


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
  name = "${var.cluster-name}-eks-vpc"
}
  
}
############################route table########################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public1" {
 # count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
 # count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.public.id
}
############################PUBLIC SUBNETS#####################
resource "aws_subnet" "publicsubnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.cluster-name}-eks-public"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"      =  1
    "kubernetes.io/role/elb"               =  1
  }
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.cluster-name}-eks-public"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"      =  1
    "kubernetes.io/role/elb"               =  1
  }
}
# resource "aws_subnet" "publicsubnet3" {
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = "10.0.3.0/24"
#   map_public_ip_on_launch = true ###by default its false for pvt subnets, no need to mention.
#   availability_zone = "us-east-1c"

#   tags = {
#     Name = "${var.cluster-name}-eks-public3"
#   }
# }
# ########################PRIVATE#######################
resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.30.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.cluster-name}-eks-private"
  }
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.cluster-name}-eks-private"
  }
}
# resource "aws_subnet" "privatesubnet3" {
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = "10.0.10.0/24"
#   availability_zone = "us-east-1c"
#   tags = {
#     Name = "${var.cluster-name}-eks-private"
#   }
# }

#########################Internet Gateway ########################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = "${var.cluster-name}-eks-vpc-igw"
  }
}

########################NAT GATEWAY ##############################
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.lb.id
#  subnet_id     = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]
  subnet_id     = aws_subnet.publicsubnet1.id
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
############################ELASTIC IP#################################
resource "aws_eip" "lb" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
}
