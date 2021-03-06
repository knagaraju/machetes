# Internet VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"    # tamaño de la red
  instance_tenancy = "default"  # multiples instancias x hard
  enable_dns_support = true     # Se autoasigna el hostname y en el dns
  enable_dns_hostnames = true
  enable_classiclink = false
  tags = {
    Name = "main"
  }
}

# Subnets - public 1a
# 10.0.1.0
resource "aws_subnet" "main-public-1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"
  tags = {
    Name = "main-public-1"
  }
}

# Subnets - public 1b
# 10.0.2.0
resource "aws_subnet" "main-public-2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"
  tags = {
    Name = "main-public-2"
  }
}

# Subnets - private

# Subnet - private 1a
# 10.0.4.0
resource "aws_subnet" "main-private-1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-1a"
  tags = {
    Name = "main-private-1"
  }
}

# Subnet - private 1b
# 10.0.5.0
resource "aws_subnet" "main-private-2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-1b"
  tags = {
    Name = "main-private-2"
  }
}

# Internet GW
# gateway
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

# Route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}





























