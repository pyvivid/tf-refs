# Create File1: vpc.tf
#Create AWS VPC
resource "aws_vpc" "levelupvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "levelupvpc"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "levelupvpc-public-1" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"

  tags = {
    Name = "levelupvpc-public-1"
  }
}

resource "aws_subnet" "levelupvpc-public-2" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"

  tags = {
    Name = "levelupvpc-public-2"
  }
}

resource "aws_subnet" "levelupvpc-public-3" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2c"

  tags = {
    Name = "levelupvpc-public-3"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "levelupvpc-private-1" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2a"

  tags = {
    Name = "levelupvpc-private-1"
  }
}

resource "aws_subnet" "levelupvpc-private-2" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2b"

  tags = {
    Name = "levelupvpc-private-2"
  }
}

resource "aws_subnet" "levelupvpc-private-3" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2c"

  tags = {
    Name = "levelupvpc-private-3"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "levelup-gw" {
  vpc_id = aws_vpc.levelupvpc.id

  tags = {
    Name = "levelup-gw"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "levelup-public" {
  vpc_id = aws_vpc.levelupvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup-gw.id
  }

  tags = {
    Name = "levelup-public-1"
  }
}

resource "aws_route_table_association" "levelup-public-1-a" {
  subnet_id      = aws_subnet.levelupvpc-public-1.id
  route_table_id = aws_route_table.levelup-public.id
}

resource "aws_route_table_association" "levelup-public-2-a" {
  subnet_id      = aws_subnet.levelupvpc-public-2.id
  route_table_id = aws_route_table.levelup-public.id
}

resource "aws_route_table_association" "levelup-public-3-a" {
  subnet_id      = aws_subnet.levelupvpc-public-3.id
  route_table_id = aws_route_table.levelup-public.id
}


# Create File2: provider.tf
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}

# Create File3: nat.tf
#Define External IP 
resource "aws_eip" "levelup-nat" {
  vpc = true
}

resource "aws_nat_gateway" "levelup-nat-gw" {
  allocation_id = aws_eip.levelup-nat.id
  subnet_id     = aws_subnet.levelupvpc-public-1.id
  depends_on    = [aws_internet_gateway.levelup-gw]
}

resource "aws_route_table" "levelup-private" {
  vpc_id = aws_vpc.levelupvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.levelup-nat-gw.id
  }

  tags = {
    Name = "levelup-private"
  }
}

# route associations private
resource "aws_route_table_association" "level-private-1-a" {
  subnet_id      = aws_subnet.levelupvpc-private-1.id
  route_table_id = aws_route_table.levelup-private.id
}

resource "aws_route_table_association" "level-private-1-b" {
  subnet_id      = aws_subnet.levelupvpc-private-2.id
  route_table_id = aws_route_table.levelup-private.id
}

resource "aws_route_table_association" "level-private-1-c" {
  subnet_id      = aws_subnet.levelupvpc-private-3.id
  route_table_id = aws_route_table.levelup-private.id
}
# Create File4: variables.tf
variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIASMSIZOF42P2VUDSZ"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-2"
}

variable "Security_Group"{
    type = list
    default = ["sg-24076", "sg-90890", "sg-456789"]
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0f40c8f97004632f9"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-0352d5a37fb4f603f"
        us-west-1 = "ami-0f40c8f97004632f9"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
