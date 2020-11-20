resource "aws_vpc_peering_connection" "foo" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.race_city.id
  vpc_id        = aws_vpc.big_city.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between big_city and race_city"
  }
}

resource "aws_vpc" "big_city" {
  cidr_block = "10.1.0.0/22"
}

resource "aws_vpc" "race_city" {
  cidr_block = "172.28.0.0/16"
}

provider "aws" {
  alias  = "peer"
  region = "us-west-1"

  # Accepter's credentials.
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "peer" {
  provider   = aws.peer
  cidr_block = "10.1.0.0/16"
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.main.id
  peer_vpc_id   = aws_vpc.peer.id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = "us-west-1"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}