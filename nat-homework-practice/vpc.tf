provider "aws" {
  region = "us-west-1"
}

#VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.52.66.0/20"
  instance_tenancy = "default"

  tags = {
    Name = "nat-city"
  }
}

#Subnet divisions (8 separate subnets total)
resource "aws_subnet" "street1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.66.0/23"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street1"
    Type = "Public"
  }
}

resource "aws_subnet" "street2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.68.0/23"
  availability_zone = "us-west-1b"

  tags = {
    Name = "street2"
    Type = "Public"
  }
}

resource "aws_subnet" "street3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.70.0/23"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street3"
    Type = "Public"
  }
}

resource "aws_subnet" "street4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.72.0/23"
  availability_zone = "us-west-1b"

  tags = {
    Name = "street4"
    Type = "Public"
  }
}

resource "aws_subnet" "street5" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.74.0/23"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street5"
    Type = "Private"
  }
}

resource "aws_subnet" "street6" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.76.0/23"
  availability_zone = "us-west-1b"

  tags = {
    Name = "street6"
    Type = "Private"
  }
}

resource "aws_subnet" "street7" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.78.0/23"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street7"
    Type = "Private"
  }
}

resource "aws_subnet" "street8" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.52.80.0/23"
  availability_zone = "us-west-1b"

  tags = {
    Name = "street8"
    Type = "Private"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

#Route Tables
resource "aws_route_table" "public_post_office" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-post-office"
  }
}

#Route Table Associations (public)
resource "aws_route_table_association" "street1" {
  subnet_id      = aws_subnet.street1.id
  route_table_id = aws_route_table.public_post_office.id
}

resource "aws_route_table_association" "street2" {
  subnet_id      = aws_subnet.street2.id
  route_table_id = aws_route_table.public_post_office.id
}

resource "aws_route_table_association" "street3" {
  subnet_id      = aws_subnet.street3.id
  route_table_id = aws_route_table.public_post_office.id
}

resource "aws_route_table_association" "street4" {
  subnet_id      = aws_subnet.street4.id
  route_table_id = aws_route_table.public_post_office.id
}

#Route Table Associations (Private)
resource "aws_route_table" "private_post_office" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private-post-office"
  }
}

resource "aws_route_table_association" "street5" {
  subnet_id      = aws_subnet.street5.id
  route_table_id = aws_route_table.private_post_office.id
}

resource "aws_route_table_association" "street6" {
  subnet_id      = aws_subnet.street6.id
  route_table_id = aws_route_table.private_post_office.id
}

resource "aws_route_table_association" "street7" {
  subnet_id      = aws_subnet.street7.id
  route_table_id = aws_route_table.private_post_office.id
}

resource "aws_route_table_association" "street8" {
  subnet_id      = aws_subnet.street8.id
  route_table_id = aws_route_table.private_post_office.id
}
