provider "aws" {
    region = "us-west-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.1.0.0/22"
    instance_tenancy = "default"

    tags = {
        Name = "big-city"
    }
}


resource "aws_subnet" "street1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "street1a"
        Type = "Public"
    }
}

resource "aws_subnet" "street2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.1.256/24"
    availability_zone = "us-west-1b"

    tags = {
        Name = "street2b"
        Type = "Public"
    }
}

resource "aws_subnet" "street3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.1.512/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "street3a"
        Type = "Private"
    }
}

resource "aws_subnet" "street4" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.1.768/24"
    availability_zone = "us-west-1b"

    tags = {
        Name = "street4b"
        Type = "Private"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    
    tags = {
        Name = "city-gateway"
    }
}

resource "aws_route_table" "post_office" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
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