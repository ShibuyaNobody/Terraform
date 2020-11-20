provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "main" {
  cidr_block        = "172.28.0.0/16"
  instance_tendancy = "default"

  tags = {
    Name = "race-city"
  }
}

resource "aws_subnet" "street1" {
  vpc_id            = aws_vpc.main.vpc_id
  cidr_block        = "172.28.0.0/18"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street1"
    Type = "Public"
  }
}

resource "aws_subnet" "street2" {
  vpc_id            = aws_vpc.main.vpc_id
  cidr_block        = "172.28.64.0/18"
  availability_zone = "us-west-1b"

  tags = {
    Name = "street2"
    Type = "Public"
  }
}

resource "aws_subnet" "street3" {
  vpc_id            = aws_vpc.main.vpc_id
  cidr_block        = "172.28.128.0/18"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street3"
    Type = "Private"
  }
}

resource "aws_subnet" "street4" {
  vpc_id            = aws_vpc.main.vpc_id
  cidr_block        = "172.28.192.0/18"
  availability_zone = "us-west-1a"

  tags = {
    Name = "street4"
    Type = "Private"
  }
}

resource "aws_internet_gateway" "city_highway" {
  vpc_id = aws_vpc.main.vpc_id

  tags = {
    Name = "city-highway"
  }
}

resource "aws_route_table" "post_office" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.city_highway.id
  }

  tags = {
    Name = "post-office"
  }
}

resource "aws_route_table_association" "street1" {
  subnet_id      = aws_subnet.street1.id
  route_table_id = aws_route_table.post_office.id
}

resource "aws_route_table_association" "street2" {
  subnet_id      = aws_subnet.street2.id
  route_table_id = aws_route_table.post_office.id
}

resource "aws_route_table_association" "street3" {
  subnet_id      = aws_subnet.street3.id
  route_table_id = aws_route_table.post_office.id
}

resource "aws_route_table_association" "street4" {
  subnet_id      = aws_subnet.street4.id
  route_table_id = aws_route_table.post_office.id
}