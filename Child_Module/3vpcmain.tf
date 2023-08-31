#START OF VPC PROVISION CODE

#1. Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.project_name}-${var.env}-VPC"
    Environment = "${var.env}-environment"
  }
}

#2a. Create public subnets
resource "aws_subnet" "public_subnets" {
  count                                       = length(var.public_subnets_cidr)
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.public_subnets_cidr[count.index]
  availability_zone                           = var.availability_zone_webapp[count.index]
  map_public_ip_on_launch                     = var.map_public_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_resource_name_dns_a_record_on_launch

  tags = {
    Name = "${var.descriptor_a}-${var.env}-Public-Subnet-${count.index + 1}"
    Environment = "${var.env}-environment"
  }
}

#2b.Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.availability_zone_database[count.index]

  tags = {
    Name = "${var.descriptor_b}-${var.env}-Private-Subnet-${count.index + 1}"
    Environment = "${var.env}-environment"
  }
}

#3. Create Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name_b}-${var.env}-Internet-Gateway"
    Environment = "${var.env}-environment"
  }
}

#4. Create Elastic IP Adress
resource "aws_eip" "elastic-iP" {

  tags = {
    Name = "${var.project_name_b}-${var.env}-Elastic-iP"
    Environment = "${var.env}-environment"
  }
}

#5. Create NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.elastic-iP.id
  subnet_id     = aws_subnet.public_subnets[0].id
  


  tags = {
    Name = "${var.project_name_b}-${var.env}-Nat-Gateway"
    Environment = "${var.env}-environment"
  }

}

#4a.Create Public Route Table 
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  #The command below attaches the pulic route table to the Internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }


  tags = {
    Name = "${var.project_name}-${var.env}-Public-Route-Table"
    Environment = "${var.env}-environment"
  }
}

#4b.Create priv Route Table 
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  #The command below attaches the private route table to the NAT gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.env}-Private-Route-Table"
    Environment = "${var.env}-environment"
  }
}

#5a. Attach public Route Table to public subnets
resource "aws_route_table_association" "Attach-pub-route-table-pub-subnets" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}

#5c. Attach private Route Table To private subnets
resource "aws_route_table_association" "Attach-priv-route-table-priv-subnets" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}

